# Hướng Dẫn Kỹ Thuật: Xây Dựng Sơ Đồ Kéo Thả (Interactive Map Editor) Bằng Flutter Thuần

Tài liệu này ghi chép lại cách thức xây dựng tính năng **Sơ đồ Quản lý Bàn** nâng cao cho ứng dụng Quản Lý Bán Hàng. Tính năng này cho phép người dùng (chủ quán) tải lên ảnh mặt bằng, sau đó kéo thả, thay đổi kích thước các đối tượng (Bàn, Cửa, Cây, Hồ cá...) trực tiếp trên ảnh.

Đặc điểm nổi bật của giải pháp này là **hoàn toàn Custom bằng các Widget lõi của Flutter**, không phụ thuộc vào bất kỳ thư viện kéo thả (Drag & Drop) bên thứ ba nào, đảm bảo hiệu năng và dễ dàng bảo trì.

---

## 1. Tư Duy Kiến Trúc (Core Concepts)

### 1.1. Virtual Canvas (Khung vẽ ảo cố định)
Thay vì đau đầu xử lý tọa độ `%` (phần trăm) khi màn hình điện thoại và máy tính có kích thước khác nhau, chúng ta sử dụng kỹ thuật **Virtual Resolution**.
- Tạo ra một khung tàng hình cố định có kích thước **1000 x 1000**.
- Hệ tọa độ của tất cả mọi vật thể luôn luôn nằm trong khoảng `x: 0 -> 1000`, `y: 0 -> 1000`.
- Điều này cho phép lưu tọa độ xuống SQLite bằng kiểu số nguyên (`INTEGER`) một cách an toàn và chuẩn xác.

### 1.2. Kỹ thuật Responsive hoàn hảo (`FittedBox`)
Để cái khung 1000x1000 này có thể hiển thị vừa vặn trên màn hình iPhone bé xíu hay màn hình PC rộng lớn mà không bị méo, chúng ta gói nó vào một `FittedBox`:
```dart
FittedBox(
  fit: BoxFit.contain, // Co giãn giữ đúng tỷ lệ, không làm méo hình
  child: SizedBox(
    width: 1000,
    height: 1000,
    child: Stack(...),
  ),
)
```

### 1.3. Lớp cắt cảnh (Layers) bằng `Stack`
Cấu trúc Canvas được phân lớp rõ ràng:
1. **Lớp dưới cùng (Background):** Hình ảnh sơ đồ quán do người dùng tải lên.
2. **Lớp trên cùng (Foreground):** Các vật thể `Positioned` (bàn, ghế) được ghim theo tọa độ `x, y`.

---

## 2. Các Thành Phần Kỹ Thuật Chính

### Bước 1: Khai báo Model Dữ Liệu
Đối tượng kéo thả cần lưu các trạng thái cơ bản:
```dart
class DraggableItem {
  final int id;
  String label;
  IconData icon;
  double x;      // Tọa độ trục hoành (0 -> 1000)
  double y;      // Tọa độ trục tung (0 -> 1000)
  double width;  // Chiều ngang đối tượng
  double height; // Chiều cao đối tượng
  
  // Các thuộc tính khác như color...
}
```

### Bước 2: Hiển thị Ảnh Nền
Để giải quyết bài toán "kích thước ảnh gốc khác nhau", chúng ta dùng `BoxFit.contain`:
```dart
Positioned.fill(
  child: Image.file(backgroundImage, fit: BoxFit.contain),
)
```
Bức ảnh sẽ tự động căn giữa khung 1000x1000, thu nhỏ vừa vặn mà không quan tâm kích thước gốc là bao nhiêu.

### Bước 3: Thuật toán Kéo Thả (Drag & Drop)
Sử dụng `GestureDetector` bọc quanh Widget vật thể. Sự kiện `onPanUpdate` trả về khoảng cách dịch chuyển của ngón tay (`details.delta`).
Chúng ta cộng khoảng cách này vào tọa độ gốc:

```dart
GestureDetector(
  onPanUpdate: (details) {
    setState(() {
      item.x += details.delta.dx;
      item.y += details.delta.dy;
      
      // Thuật toán chặn không cho kéo ra ngoài khung
      if (item.x < 0) item.x = 0;
      if (item.x > 1000 - item.width) item.x = 1000 - item.width;
      if (item.y < 0) item.y = 0;
      if (item.y > 1000 - item.height) item.y = 1000 - item.height;
    });
  },
  child: Container(...), // Vẽ vật thể tại đây
)
```

### Bước 4: Thuật toán Thay đổi kích thước (Resize)
Tương tự việc kéo thả, chúng ta đặt một `GestureDetector` nhỏ xíu ở góc dưới cùng bên phải của vật thể:
```dart
Positioned(
  bottom: 0,
  right: 0,
  child: GestureDetector(
    onPanUpdate: (details) {
      setState(() {
        // Thay vì cộng tọa độ, ta cộng vào kích thước
        item.width += details.delta.dx;
        item.height += details.delta.dy;
        
        // Cần chặn kích thước tối thiểu để vật thể không bị âm (lật ngược)
        if (item.width < 50) item.width = 50;
        if (item.height < 50) item.height = 50;
      });
    },
    child: Icon(Icons.open_in_full), // Icon góc báo hiệu Resize
  ),
)
```

### Bước 5: Tính năng Xóa vật thể (Delete)
Để người dùng có thể xóa vật thể khi đặt sai, ta gắn thêm một nút `X` (Close) ở góc trên bên phải:
```dart
Positioned(
  top: 0,
  right: 0,
  child: InkWell(
    onTap: () {
      setState(() {
        _items.removeWhere((e) => e.id == item.id);
      });
    },
    child: Container(
      color: Colors.red,
      child: const Icon(Icons.close, color: Colors.white, size: 16),
    ),
  ),
)
```

### Bước 6: Thanh Công Cụ Kéo Thả (Palette / Toolbox)
Bên ngoài vùng Canvas 1000x1000, ta thiết kế một thanh Menu bên trái (SizedBox width: 250) chứa danh sách các vật thể có sẵn (Bàn, Cây, Cửa). Khi click vào một món đồ trong Toolbox:
```dart
void _addNewItem(String label, IconData icon, Color color) {
  setState(() {
    _items.add(_DraggableItem(
      id: DateTime.now().millisecondsSinceEpoch,
      label: label,
      icon: icon,
      color: color,
      x: 450, // Thả vào giữa khung 1000x1000
      y: 450, // Thả vào giữa khung 1000x1000
    ));
  });
}
```
Vật thể sẽ lập tức xuất hiện ở chính giữa Canvas, sẵn sàng để người dùng kéo đi chỗ khác.

---

## 3. Quản Lý Ảnh Nền Tối Ưu Nhất
Để tránh phình to dung lượng ứng dụng (do người dùng tải lên ảnh 4K), bắt buộc phải sử dụng trình nén ảnh gốc trước khi lưu. 

Ví dụ với `image_picker`:
```dart
final pickedFile = await _picker.pickImage(
  source: ImageSource.gallery,
  maxWidth: 1000,  // Nén cứng chiều dài tối đa
  maxHeight: 1000, // Nén cứng chiều cao tối đa
  imageQuality: 85,// Nén chất lượng
);
```
Nhờ bước này, một bức ảnh 5MB sẽ chỉ còn ~100KB, lưu trong hệ thống hoàn toàn nhẹ và tối ưu.

## 4. Tổng Kết
Sự kết hợp giữa `Stack`, `Positioned`, `GestureDetector` và đặc biệt là `FittedBox(SizedBox(1000x1000))` tạo ra một Editor mạnh mẽ. 

**Khi triển khai thật vào Database:**
1. Tạo bảng `areas` (hoặc lưu thông tin chung `map_image_path` vào settings).
2. Sửa bảng `customer_tables` thêm các cột `pos_x`, `pos_y`, `width`, `height` (Kiểu INTEGER).
3. Đổ dữ liệu từ Database lên giao diện, và khi kéo thả xong, bấm "Lưu", gọi API / Repository Update cập nhật lại tọa độ.
