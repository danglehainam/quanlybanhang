# Database Schema Thiết Kế Cấp Thấp (Drift / SQLite)
Dự án: Quản Lý Bán Hàng (Offline-First)

Tài liệu này định nghĩa cấu trúc các bảng dữ liệu (Tables) sử dụng cho Local Database (Drift). Thiết kế tuân thủ nghiêm ngặt các quy tắc Coding Culture của dự án:
- **Tiền tệ (Money)**: Sử dụng kiểu `INTEGER` (đơn vị VND), không dùng `DOUBLE`.
- **Thời gian (DateTime)**: Lưu trữ dưới dạng `INTEGER` (Unix Timestamp UTC).

---

# NHÓM A: CỬA HÀNG & PHÂN QUYỀN

---

## 1. Bảng Cửa Hàng (`stores`)
Thông tin cửa hàng. Là gốc liên kết cho toàn bộ hệ thống.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `name` | TEXT | NOT NULL | Tên cửa hàng |
| `address` | TEXT | NULLABLE | Địa chỉ |
| `phone` | TEXT | NULLABLE | SĐT cửa hàng |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---

## 2. Bảng Vai Trò (`roles`)
Các vai trò do chủ cửa hàng tự định nghĩa (VD: "Thu ngân", "Quản lý kho"). Mỗi cửa hàng có bộ vai trò riêng.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `name` | TEXT | NOT NULL | Tên vai trò |
| `description` | TEXT | NULLABLE | Mô tả |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---

## 3. Bảng Quyền (`permissions`)
Danh sách tất cả quyền (tính năng) trong app. Dữ liệu **cài sẵn** khi mở app lần đầu, KHÔNG thuộc cửa hàng cụ thể nào.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `code` | TEXT | NOT NULL, UNIQUE | Mã quyền (VD: `create_order`, `view_report`) |
| `name` | TEXT | NOT NULL | Tên hiển thị (VD: "Tạo đơn hàng") |
| `group_name` | TEXT | NOT NULL | Nhóm quyền (VD: "Đơn hàng", "Báo cáo") |

---

## 4. Bảng Quyền Theo Vai Trò (`role_permissions`)
Bảng nối: Gán quyền cụ thể cho từng vai trò.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `role_id` | INTEGER | NOT NULL, FOREIGN KEY (`roles.id`) | Vai trò nào |
| `permission_id` | INTEGER | NOT NULL, FOREIGN KEY (`permissions.id`) | Quyền nào |
| | | UNIQUE(`role_id`, `permission_id`) | Không gán trùng |

---

## 5. Bảng Tài Khoản (`users`)
Tài khoản đăng nhập vào hệ thống. Mỗi user thuộc 1 cửa hàng và được gán 1 vai trò.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `email` | TEXT | NOT NULL, UNIQUE | Email đăng nhập |
| `password_hash` | TEXT | NOT NULL | Mật khẩu đã mã hóa |
| `name` | TEXT | NOT NULL | Tên hiển thị |
| `is_owner` | INTEGER | NOT NULL, DEFAULT 0 | Là chủ? (0: nhân viên, 1: chủ) |
| `role_id` | INTEGER | NULLABLE, FOREIGN KEY (`roles.id`) | Vai trò (null nếu là chủ) |
| `is_active` | INTEGER | NOT NULL, DEFAULT 1 | 1: hoạt động, 0: vô hiệu hóa |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

**Logic phân quyền:**
- `is_owner = 1` → Có **TẤT CẢ** quyền, bỏ qua mọi kiểm tra.
- `is_owner = 0` → Kiểm tra `role_id` → Tìm quyền trong `role_permissions`.

---

# NHÓM B: NGHIỆP VỤ BÁN HÀNG


---

## 6. Bảng Danh Mục (`categories`)
Quản lý các nhóm sản phẩm (Ví dụ: Đồ uống, Đồ ăn vặt, Đồ gia dụng).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `name` | TEXT | NOT NULL | Tên danh mục |
| `description` | TEXT | NULLABLE | Mô tả thêm |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---

## 7. Bảng Sản Phẩm (`products`)
Quản lý thông tin chi tiết của từng mặt hàng.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `category_id` | INTEGER | NULLABLE, FOREIGN KEY (`categories.id`) | Thuộc danh mục nào (null = chưa phân loại) |
| `name` | TEXT | NOT NULL | Tên sản phẩm |
| `price` | INTEGER | NOT NULL | Giá bán (VND) |
| `image_url` | TEXT | NULLABLE | Đường dẫn ảnh sản phẩm |
| `description` | TEXT | NULLABLE | Mô tả sản phẩm |
| `status` | INTEGER | NOT NULL, DEFAULT 1 | Trạng thái (0: hết hàng, 1: còn hàng) |
| `stock` | INTEGER | NULLABLE | Số lượng tồn kho (null = không giới hạn/đồ chế biến) |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---

## 8. Bảng Khách Hàng (`customers`)
Lưu thông tin khách hàng. Nhận diện khách qua số điện thoại.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `name` | TEXT | NOT NULL | Tên khách hàng |
| `phone` | TEXT | NOT NULL | Số điện thoại (dùng để nhận diện) |
| | | UNIQUE(`store_id`, `phone`) | Mỗi SĐT chỉ duy nhất trong 1 cửa hàng |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |
| `updated_at` | INTEGER | NOT NULL | Ngày cập nhật (UTC) |

---

## 9. Bảng Đơn Hàng (`orders`)
Quản lý các hóa đơn bán hàng (Đại diện cho các khoản Thu chính).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Đơn hàng thuộc cửa hàng nào |
| `created_by` | INTEGER | NOT NULL, FOREIGN KEY (`users.id`) | Đơn hàng do ai tạo |
| `customer_id` | INTEGER | NULL, FOREIGN KEY (`customers.id`) | Đơn hàng của khách nào (nếu có) |
| `table_id` | INTEGER | NULL, FOREIGN KEY (`customer_tables.id`) | ID bàn khách ngồi (NULL nếu mang đi) |
| `total_amount` | INTEGER | NOT NULL | Tổng tiền trước giảm giá (VND) |
| `discount_percent` | REAL | NULLABLE | Mức giảm giá theo phần trăm (VD: 10.5) |
| `discount` | INTEGER | NOT NULL, DEFAULT 0 | Số tiền giảm giá (VND) |
| `final_amount` | INTEGER | NOT NULL | Tổng tiền khách phải trả (VND) |
| `status` | INTEGER | NOT NULL | Trạng thái Enum (0: pending, 1: completed, 2: cancelled) |
| `note` | TEXT | NULLABLE | Ghi chú đơn hàng |
| `created_at` | INTEGER | NOT NULL | Thời điểm bán hàng (UTC) |
| `updated_at` | INTEGER | NOT NULL | Thời điểm cập nhật (UTC) |

---

## 10. Bảng Chi Tiết Đơn Hàng (`order_items`)
Lưu chi tiết từng sản phẩm được bán trong một đơn hàng. Dùng bảng này để thống kê **Sản phẩm bán chạy nhất**.

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `order_id` | INTEGER | NOT NULL, FOREIGN KEY (`orders.id`) | Thuộc đơn hàng nào |
| `product_id` | INTEGER | NOT NULL, FOREIGN KEY (`products.id`) | Sản phẩm nào được bán |
| `quantity` | INTEGER | NOT NULL | Số lượng mua |
| `product_name` | TEXT | NOT NULL | Tên sản phẩm tại thời điểm bán (Snapshot) |
| `price_at_purchase`| INTEGER| NOT NULL | Giá bán TẠI THỜI ĐIỂM ĐÓ (VND) (Snapshot) |
| `subtotal` | INTEGER | NOT NULL | Thành tiền (quantity * price) (VND) |

---

## 11. Bảng Giao Dịch Thu/Chi (`transactions`)
Dùng để quản lý các dòng tiền ngoài bán hàng (Chi trả tiền nhập hàng, Chi trả tiền điện nước, Thu nhập khác).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `created_by` | INTEGER | NOT NULL, FOREIGN KEY (`users.id`) | Ai ghi nhận giao dịch này |
| `type` | INTEGER | NOT NULL | Loại Enum (0: income/thu, 1: expense/chi) |
| `amount` | INTEGER | NOT NULL | Số tiền (VND) |
| `note` | TEXT | NOT NULL | Ghi chú (VD: Trả tiền điện tháng 5) |
| `created_at` | INTEGER | NOT NULL | Ngày thực hiện (UTC) |

---

## 12. Bảng Bàn Khách Hàng (`customer_tables`)
Quản lý danh sách bàn trong cửa hàng (phục vụ khách ngồi lại).

| Tên Trường (Field) | Kiểu Dữ Liệu (Type) | Ràng Buộc (Constraints) | Mô Tả |
| :--- | :--- | :--- | :--- |
| `id` | INTEGER | PRIMARY KEY, AUTOINCREMENT | Khóa chính |
| `store_id` | INTEGER | NOT NULL, FOREIGN KEY (`stores.id`) | Thuộc cửa hàng nào |
| `name` | TEXT | NOT NULL | Tên/Số bàn (VD: Bàn 1, VIP 2) |
| `status` | INTEGER | NOT NULL | Trạng thái (0: Trống, 1: Có khách, 2: Đặt trước) |
| `capacity` | INTEGER | NULL | Số ghế tối đa (tùy chọn) |
| `is_active` | INTEGER | NOT NULL | 1: Hoạt động, 0: Đã xóa/hủy |
| `created_at` | INTEGER | NOT NULL | Ngày tạo (UTC) |

---