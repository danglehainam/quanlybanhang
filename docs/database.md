# Database Schema Thiết Kế Cấp Thấp (Drift / SQLite)
Dự án: Quản Lý Bán Hàng (Offline-First)

Tài liệu này định nghĩa cấu trúc các bảng dữ liệu (Tables) sử dụng cho Local Database (Drift). Thiết kế tuân thủ nghiêm ngặt các quy tắc Coding Culture của dự án:
- **Tiền tệ (Money)**: Sử dụng kiểu `INTEGER` (đơn vị VND), không dùng `DOUBLE`.
- **Thời gian (DateTime)**: Lưu trữ dưới dạng `INTEGER` (Unix Timestamp UTC).

---

## 1. Bảng Danh Mục (`categories`)
Quản lý các nhóm sản phẩm (Ví dụ: Đồ uống, Đồ ăn vặt, Đồ gia dụng).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `name` | TEXT | NOT NULL | Tên danh mục |
| `description` | TEXT | NULLABLE | Mô tả thêm |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC Timestamp) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC Timestamp) |

---

## 2. Bảng Sản Phẩm (`products`)
Quản lý thông tin chi tiết của từng mặt hàng.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `category_id` | INTEGER | FOREIGN KEY (`categories.id`) | Thuộc danh mục nào |
| `name` | TEXT | NOT NULL | Tên sản phẩm |
| `barcode` | TEXT | NULLABLE, UNIQUE | Mã vạch (nếu có để quét) |
| `price` | INTEGER | NOT NULL | Giá bán (VND) |
| `cost_price` | INTEGER | NOT NULL | Giá vốn (VND - Dùng để tính lãi) |
| `stock_quantity`| INTEGER | NOT NULL, DEFAULT 0 | Số lượng tồn kho hiện tại |
| `image_url` | TEXT | NULLABLE | Đường dẫn ảnh (Local path) |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---



## 3. Bảng Đơn Hàng (`orders`)
Quản lý các hóa đơn bán hàng (Đại diện cho các khoản Thu chính).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `customer_name`| TEXT | NULLABLE | Tên khách hàng (nếu có) |
| `total_amount` | INTEGER | NOT NULL | Tổng tiền trước giảm giá (VND) |
| `discount` | INTEGER | NOT NULL, DEFAULT 0 | Số tiền giảm giá (VND) |
| `final_amount` | INTEGER | NOT NULL | Tổng tiền khách phải trả (VND) |
| `status` | INTEGER | NOT NULL | Trạng thái Enum (0: pending, 1: completed, 2: cancelled) |
| `created_at` | INTEGER | NOT NULL | Thời điểm bán hàng (UTC) |
| `updated_at` | INTEGER | NOT NULL | Thời điểm cập nhật (UTC) |

---

## 4. Bảng Chi Tiết Đơn Hàng (`order_items`)
Lưu chi tiết từng sản phẩm được bán trong một đơn hàng. Dùng bảng này để thống kê **Sản phẩm bán chạy nhất**.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `order_id` | INTEGER | FOREIGN KEY (`orders.id`) | Thuộc đơn hàng nào |
| `product_id` | INTEGER | FOREIGN KEY (`products.id`) | Sản phẩm nào được bán |
| `quantity` | INTEGER | NOT NULL | Số lượng mua |
| `product_name` | TEXT | NOT NULL | Tên sản phẩm tại thời điểm bán * |
| `price_at_purchase`| INTEGER| NOT NULL | Giá bán TẠI THỜI ĐIỂM ĐÓ (VND) * |
| `subtotal` | INTEGER | NOT NULL | Thành tiền (quantity * price) (VND) |

*(Lưu ý `product_name` và `price_at_purchase`: Đây là kỹ thuật "chụp ảnh" (Snapshot) hóa đơn. Tên và giá sản phẩm ở bảng gốc có thể bị sửa hoặc xóa trong tương lai, nhưng hóa đơn đã in ra trong quá khứ thì phải bất di bất dịch).*

---

## 5. Bảng Giao Dịch Thu/Chi (`transactions`)
Dùng để quản lý các dòng tiền ngoài bán hàng (Chi trả tiền nhập hàng, Chi trả tiền điện nước, Thu nhập khác).

| Tên Trường (Field) | Kiểu Dữ bản Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `type` | INTEGER | NOT NULL | Loại Enum (0: income/thu, 1: expense/chi) |
| `amount` | INTEGER | NOT NULL | Số tiền (VND) |
| `reason` | TEXT | NOT NULL | Lý do (VD: Trả tiền điện tháng 5) |
| `created_at` | INTEGER | NOT NULL | Ngày thực hiện (UTC) |

---

## Thiết Kế Các Câu Thống Kê (Statistics Guide)

Dựa trên cấu trúc bảng này, chúng ta sẽ thực hiện các UseCase thống kê rất dễ dàng:
1. **Sản phẩm bán chạy**: `SELECT product_id, SUM(quantity) FROM order_items GROUP BY product_id ORDER BY SUM(quantity) DESC`.
2. **Tổng Thu (Bán hàng)**: `SUM(final_amount)` từ bảng `orders` (nơi status = 'completed') theo ngày/tháng.
3. **Tổng Chi**: `SUM(amount)` từ bảng `transactions` (nơi type = 'expense') theo ngày/tháng.
4. **Lợi nhuận gộp**: Dựa vào `price_at_purchase` trừ đi `cost_price` (của product tương ứng) nhân với `quantity`.
