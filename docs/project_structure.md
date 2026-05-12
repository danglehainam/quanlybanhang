# Cấu trúc thư mục dự án QuanLyBanHang

Dự án `QuanLyBanHang` được thiết kế theo mô hình **Clean Architecture**. Mô hình này chia ứng dụng thành các tầng riêng biệt để dễ dàng quản lý, mở rộng và bảo trì.

Dưới đây là giải thích chi tiết về tác dụng của từng thư mục trong dự án:

## Cấu trúc tổng quan

```text
lib/
├── core/
├── data/
├── domain/
└── presentation/
```

---

## 1. Thư mục `lib/core/` (Tầng Cốt Lõi)
Chứa các thành phần, tiện ích và cấu hình dùng chung cho toàn bộ dự án. Bất kỳ tầng nào (Data, Domain, hay Presentation) cũng có thể gọi đến `core`.

- **`core/constants/`**: Nơi lưu trữ các hằng số tĩnh (static) của toàn bộ app. Ví dụ: URL API (`api_constants.dart`), các mã màu (`app_colors.dart`), đường dẫn ảnh/icon (`asset_paths.dart`), các text mặc định.
- **`core/di/`** *(Dependency Injection)*: Nơi cấu hình việc khởi tạo và tiêm phụ thuộc (Injection) cho các class. Thường dùng package `get_it` để đăng ký các Repositories, UseCases, và Blocs ở đây. Giúp app dễ test và quản lý bộ nhớ hơn.
- **`core/error/`**: Nơi quản lý xử lý lỗi tập trung.
  - `exceptions.dart`: Chứa các Exception (Lỗi ngoại lệ) ném ra từ tầng Data (VD: `ServerException`, `CacheException`).
  - `failures.dart`: Chứa các Failure (Thất bại) trả về từ tầng Repository cho UI xử lý (VD: `ServerFailure`, `NetworkFailure`).

---

## 2. Thư mục `lib/domain/` (Tầng Nghiệp Vụ - Trái tim của app)
Tầng này chứa "Luật kinh doanh" của ứng dụng. Tầng này **độc lập hoàn toàn**, không phụ thuộc vào bất kỳ thư viện hay framework bên ngoài nào (không import Flutter UI hay thư viện gọi API).

- **`domain/entities/`**: Chứa các Object cơ bản nhất. Ví dụ: `Product`, `User`, `Order`. Khác với Models, Entities không chứa logic parse JSON, nó chỉ thuần túy là dữ liệu.
- **`domain/repositories/`**: Chứa các **Interface (Abstract class)**. Quy định các hàm bắt buộc phải có để lấy dữ liệu (VD: `getProducts()`, `login()`), nhưng *không viết code thực hiện* ở đây.
- **`domain/usecases/`**: Chứa các tác vụ cụ thể mà người dùng có thể thực hiện. Mỗi file UseCase thường chỉ làm đúng 1 việc. Ví dụ: `GetProductsUseCase`, `LoginUseCase`. Tầng UI sẽ chỉ gọi UseCase thay vì gọi thẳng Repository.

---

## 3. Thư mục `lib/data/` (Tầng Dữ Liệu)
Tầng này chịu trách nhiệm lấy dữ liệu (từ API, Local DB, Firebase...) và định dạng dữ liệu đó trả về cho tầng Domain.

- **`data/models/`**: Kế thừa từ `entities` (tầng Domain) nhưng bổ sung thêm logic chuyển đổi dữ liệu. Thường chứa các hàm `fromJson()` và `toJson()` để biến đổi dữ liệu thô từ API/DB thành Object trong app.
- **`data/datasources/`**: Nơi **thực sự** kết nối để lấy dữ liệu.
  - `remote/`: Lấy dữ liệu qua mạng (API, Firebase).
  - `local/`: Lấy/Lưu dữ liệu trong máy (SharedPreferences, SQLite, Hive).
- **`data/repositories/`**: Nơi **viết code thực hiện** (Implement) cho các Interface Repositories bên tầng `domain`. Nó quyết định việc gọi `remote` (lấy từ mạng) hay `local` (lấy từ cache), bắt các lỗi (`Exceptions`) và gói lại thành `Failures`.

---

## 4. Thư mục `lib/presentation/` (Tầng Giao Diện - UI)
Tầng này chịu trách nhiệm hiển thị mọi thứ cho người dùng xem và nhận tương tác (bấm nút, nhập text).

- **`presentation/bloc/`** *(hoặc `cubit`, `provider`, `controller`)*: Nơi quản lý trạng thái (State Management) của màn hình. Nó nhận sự kiện từ UI, gọi đến các `UseCases` (tầng Domain), và thay đổi trạng thái (State) để UI tự động cập nhật.
- **`presentation/screens/`** *(hoặc `pages`)*: Chứa các màn hình hoàn chỉnh (Ví dụ: `LoginScreen`, `HomeScreen`). Trong này thường chỉ chứa giao diện thô, kết nối với `Bloc` để lấy dữ liệu hiển thị, hạn chế tối đa việc viết logic tính toán ở đây.
- **`presentation/widgets/`**: Chứa các thành phần UI nhỏ lẻ, có thể tái sử dụng nhiều lần ở nhiều màn hình khác nhau (Ví dụ: `CustomButton`, `ProductItemCard`, `LoadingSpinner`).

---

## Luồng chạy dữ liệu chuẩn (Data Flow)
Khi người dùng bấm nút "Lấy danh sách sản phẩm":
1. **[Presentation]** Màn hình UI gửi Event đến `Bloc`.
2. **[Presentation]** `Bloc` gọi `GetProductsUseCase`.
3. **[Domain]** `GetProductsUseCase` gọi `ProductRepository` (chỉ là interface).
4. **[Data]** Lớp `ProductRepositoryImpl` (thực thi interface) gọi `ProductRemoteDataSource`.
5. **[Data]** `ProductRemoteDataSource` gọi API, nhận JSON về, biến thành `ProductModel` và ném về lại.
6. **[Data -> Domain]** `RepositoryImpl` trả danh sách này về dạng `Either<Failure, List<Product>>`.
7. **[Presentation]** `Bloc` nhận kết quả, nếu thành công thì emit `SuccessState` kèm dữ liệu, nếu thất bại thì emit `ErrorState` kèm message. UI tự cập nhật theo State mới.
