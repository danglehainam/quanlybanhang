---
description: Quy trình Phát triển & Bảo trì Chuẩn (Clean Architecture & UI Design) cho Dự án QuanLyBanHang (/cleancode)
---

> **BẮT BUỘC**: Khi phát triển bất kỳ tính năng nào trong dự án QuanLyBanHang, AI PHẢI tuân thủ nghiêm ngặt toàn bộ nội dung file này. Không được sáng tạo, không được dùng giải pháp thay thế.

### // turbo-all

---

# PHẦN A: QUY TẮC TOÀN CỤC

Các quy tắc dưới đây có hiệu lực ở **MỌI bước**, **MỌI file**, **MỌI tầng** trong dự án.

## A1. Công nghệ Bắt buộc (Tech Stack)
| Mục đích | Thư viện | Ghi chú |
| :--- | :--- | :--- |
| Quản lý trạng thái | `flutter_bloc` + `freezed` | Cấm dùng `equatable`, `provider`, `riverpod` |
| Điều hướng | `go_router` | Cấu hình tại `lib/core/routes/app_router.dart` |
| Dependency Injection | `get_it` | Đăng ký tại `lib/core/di/dependency_injection.dart` |
| CSDL cục bộ | `drift` | Lưu trữ SQLite local |
| Đa ngôn ngữ | `intl` (file `.arb`) | Lưu tại `lib/l10n/` |
| Lưu cấu hình người dùng | `shared_preferences` | Dùng cho SettingsBloc |
| Xử lý lỗi hàm | `dartz` hoặc `fpdart` | Kiểu trả về `Either<Failure, T>` |

- ❌ **CẤM**: Tự ý thêm thư viện mới vào `pubspec.yaml` mà không xin phép người dùng trước.

## A2. Quy tắc Đặt tên (Naming)
- Tên file và thư mục: `snake_case` (VD: `pos_screen.dart`, `product_model.dart`).
- Tên class: `PascalCase` (VD: `PosScreen`, `ProductModel`).
- Tên biến và hàm: `camelCase` (VD: `finalAmount`, `getProducts()`).
- Tên file BLoC: `[tên]_bloc.dart`, `[tên]_event.dart`, `[tên]_state.dart`.

## A3. Quy tắc Tiền tệ (Money)
- ❌ **CẤM TUYỆT ĐỐI** dùng `double` cho tiền tệ (tránh lỗi số thực dấu phẩy động).
- ✅ **BẮT BUỘC** dùng `int` (đơn vị: VND). VD: `15000` thay vì `15000.0`.

## A4. Quy tắc Ngày giờ (DateTime)
- ✅ Lưu vào CSDL dưới dạng UTC (`DateTime.toUtc()`).
- ✅ Chỉ chuyển sang giờ địa phương (`toLocal()`) tại tầng Presentation, ngay trước khi hiển thị.

## A5. Quy tắc Đa ngôn ngữ (Localization)
- ❌ **CẤM** viết cứng chuỗi hiển thị trong UI (VD: `Text('Đăng nhập')`).
- ✅ Luôn thêm chuỗi vào file `.arb` trước, rồi dùng `AppLocalizations.of(context)!.tenKey`.

## A6. Quy tắc Màu sắc (Color)
- ❌ **CẤM** viết cứng mã màu hex hoặc dùng `Colors.blue` mặc định của Flutter.
- ✅ Luôn dùng class `AppColors` từ `lib/core/constants/app_colors.dart`.

## A7. Quy tắc Hàm tiện ích (Utility)
- ✅ Mọi logic tái sử dụng (định dạng tiền, ngày tháng, xử lý chuỗi...) PHẢI tách ra `lib/core/utils/`.
- ❌ **CẤM** để hàm tiện ích lẫn trong file BLoC hoặc file UI.

## A8. Quy tắc Sinh mã (Code Generation)
- ✅ Bất cứ khi nào sửa file `Freezed` (State/Event) hoặc bảng `Drift`, **BẮT BUỘC** chạy: `dart run build_runner build -d`.
- ✅ Các file `.freezed.dart` và `.g.dart` là file tự sinh. **CẤM** sửa tay các file này.

## A9. Quy tắc Giao diện Đa nền tảng (Responsive - Hybrid Pattern)
- ✅ Dùng `SettingsBloc` để lưu `ViewMode` (auto, mobile, desktop) và đồng bộ bằng `shared_preferences`.
- ✅ Dùng `ResponsiveWrapper` tại `lib/core/utils/responsive_wrapper.dart` để tự động phân luồng: macOS/Windows → Desktop, còn lại → Mobile. Ưu tiên tôn trọng lựa chọn thủ công của người dùng.
- ✅ Với màn hình phức tạp (POS, Trang chủ): **BẮT BUỘC** tách thành `[screen]_mobile_view.dart` và `[screen]_desktop_view.dart`, bọc bằng `ResponsiveWrapper`.
- ✅ Với màn hình đơn giản (Đăng nhập, Thêm sản phẩm): Dùng 1 file duy nhất với `Container(maxWidth: 500)`.
- ❌ **CẤM** nhân bản logic nghiệp vụ. Cả 2 giao diện Mobile và Desktop PHẢI dùng chung 1 BLoC duy nhất.

## A10. Quy tắc Tác dụng phụ trong BLoC (Side Effect)
BLoC là bộ não thuần túy, chỉ được phép `emit` State. BLoC **KHÔNG ĐƯỢC PHÉP** điều khiển giao diện.
- ❌ **CẤM** gọi `Navigator` (push, pop, go) trong BLoC.
- ❌ **CẤM** gọi `showDialog`, `showBottomSheet`, `showSnackBar`, `ScaffoldMessenger` trong BLoC.
- ❌ **CẤM** truyền `BuildContext` vào BLoC.
- ✅ BLoC chỉ `emit` State. Tầng UI dùng `BlocListener` để lắng nghe State thay đổi rồi tự quyết định hiển thị SnackBar, chuyển trang, hay mở Dialog.

## A11. Quy tắc Hằng số (Constants)
Mọi giá trị được sử dụng lặp lại ở nhiều nơi **BẮT BUỘC** phải khai báo thành hằng số tại `lib/core/constants/`.

| File | Mục đích |
| :--- | :--- |
| `app_colors.dart` | Màu sắc toàn app (`AppColors.primary`, `AppColors.error`) |
| `app_spacing.dart` | Khoảng cách chuẩn (`AppSpacing.xs = 4`, `sm = 8`, `md = 16`, `lg = 24`, `xl = 32`) |
| `app_durations.dart` | Thời gian animation (`AppDurations.fast = 200ms`, `normal = 300ms`) |

- ❌ **CẤM** viết cứng tên Route dưới dạng chuỗi. Phải dùng hằng số `AppRoutes` trong `lib/core/routes/app_router.dart`.
- ❌ **CẤM** viết cứng Key của SharedPreferences rải rác. Phải khai báo `static const` trong class sử dụng nó.
- ✅ Các giá trị padding/spacing nên dùng `AppSpacing` để đảm bảo đồng nhất giao diện.

## A12. Quy tắc Giao diện cho Trạng thái Bất đồng bộ (Async State UX)
Mọi màn hình có tải dữ liệu **BẮT BUỘC** xử lý đầy đủ các trạng thái sau bằng Widget dùng chung. **CẤM** mỗi màn hình tự vẽ kiểu riêng.

| Trạng thái | Widget bắt buộc | Vị trí |
| :--- | :--- | :--- |
| `loading` | `AppLoadingWidget` (vòng xoay hoặc Shimmer) | `lib/presentation/widgets/app_loading_widget.dart` |
| `loaded` (rỗng) | `EmptyDataWidget` (icon + thông báo + nút hành động) | `lib/presentation/widgets/empty_data_widget.dart` |
| `error` | `AppErrorWidget` (thông báo lỗi + **nút Thử lại**) | `lib/presentation/widgets/app_error_widget.dart` |

- ✅ `AppErrorWidget` **BẮT BUỘC** nhận callback `onRetry` để gửi lại Event cho BLoC.
- ✅ Dùng `state.when(...)` để xử lý đủ tất cả trạng thái, bao gồm cả trường hợp danh sách trả về rỗng (`loaded` nhưng 0 items → hiển thị `EmptyDataWidget`).
- ❌ **CẤM** để màn hình trắng trơn khi đang tải dữ liệu.
- ❌ **CẤM** hiển thị lỗi mà không có nút Thử lại (trừ khi lỗi không thể retry).

## A13. Quy tắc Xác thực dữ liệu (Validation)
Áp dụng mô hình **Validation 2 tầng**:

| Tầng | Loại kiểm tra | Cách thực hiện |
| :--- | :--- | :--- |
| **UI (Form)** | Định dạng & bắt buộc (trống, email sai, độ dài) | `TextFormField.validator`. Phản hồi tức thì |
| **UseCase (Domain)** | Quy tắc nghiệp vụ (giá > 0, tên trùng, tồn kho âm) | Trả về `Left(ValidationFailure('...'))` |

- ✅ Hàm validate dùng chung **BẮT BUỘC** đặt tại `lib/core/utils/validators.dart`.
- ✅ Form **BẮT BUỘC** dùng `GlobalKey<FormState>` và gọi `formKey.currentState!.validate()` trước khi gửi Event cho BLoC.
- ❌ **CẤM** viết logic validate trong BLoC. BLoC chỉ chuyển tiếp dữ liệu cho UseCase.
- ❌ **CẤM** viết hàm validate inline lặp lại trong nhiều Form. Phải tách ra `validators.dart`.

---

# PHẦN B: QUY TRÌNH LÀM VIỆC (Từng bước)

---

## Bước 0: Chuẩn bị & Thiết kế (Database First)
**Làm gì**: Đọc hoặc cập nhật tài liệu `docs/database.md`.
**Mục đích**: Hiểu rõ Schema (tên trường, kiểu dữ liệu, quan hệ cha-con) trước khi viết bất kỳ dòng code nào.

---

## Bước 1: Tầng Domain (Nghiệp vụ cốt lõi)
**Làm gì**: Luôn bắt đầu từ "Trái tim" của ứng dụng (tầng trong cùng).

| Thành phần | Vị trí file |
| :--- | :--- |
| Entity | `lib/domain/entities/[tên]_entity.dart` |
| Repository Interface | `lib/domain/repositories/[tên]_repository.dart` |
| UseCase | `lib/domain/usecases/[động_từ]_[tên]_usecase.dart` |
| Failure | `lib/core/error/failures.dart` |

**Quy tắc riêng:**
- ✅ Entity phải là class thuần Dart với `const` constructor và thuộc tính `final`. Không kế thừa, không phụ thuộc.
- ✅ UseCase **BẮT BUỘC** dùng method `call()` để có thể gọi tắt như hàm. Tên class bắt đầu bằng động từ (VD: `GetCategoriesUseCase`).
- ✅ Repository Interface **BẮT BUỘC** khai báo kiểu trả về `Either<Failure, T>`.
- ❌ **CẤM** Entity import bất kỳ file nào từ tầng Data hoặc Presentation.
- ❌ **CẤM** viết `try-catch` trong UseCase.

---

## Bước 2: Tầng Data (Truy xuất dữ liệu)
**Làm gì**: Kết nối ứng dụng với CSDL cục bộ (Drift/SQLite).

| Thành phần | Vị trí file |
| :--- | :--- |
| Drift Table | `lib/data/datasources/local/tables/[tên]_table.dart` |
| AppDatabase | `lib/data/datasources/local/app_database.dart` |
| Model | `lib/data/models/[tên]_model.dart` |
| DataSource | `lib/data/datasources/local/[tên]_local_datasource.dart` |
| Repository Impl | `lib/data/repositories/[tên]_repository_impl.dart` |

**Quy tắc riêng:**
- ✅ Khi thêm bảng mới, thêm tên bảng vào danh sách `tables` trong annotation `@DriftDatabase` ở `app_database.dart`.
- ✅ Model **BẮT BUỘC** có đầy đủ 4 mapper dùng `factory` constructor: `fromJson`, `toJson`, `toEntity`, `fromEntity`.
- ✅ `try-catch` **CHỈ ĐƯỢC PHÉP** viết ở Repository Impl. Bắt Exception → trả về `Left(Failure)`.
- ❌ **CẤM** Model kế thừa (`extends`) từ Entity.
- ❌ **CẤM** dùng `extension` method để ánh xạ dữ liệu. Chỉ dùng `factory` constructor.

---

## Bước 3: Tầng Presentation (Giao diện & Logic giao diện)
**Làm gì**: Xây dựng giao diện người dùng và quản lý trạng thái hiển thị.

### 3.1 Điều hướng (Routing)
- ✅ Dùng `go_router`. Cấu hình tập trung tại `lib/core/routes/app_router.dart`.
- ✅ Chuyển màn hình: `context.go()` hoặc `context.push()`. Đóng Dialog/BottomSheet: `Navigator.pop(context)`.
- ✅ Bảo vệ màn hình yêu cầu đăng nhập bằng `redirect` + `AuthBloc`.

### 3.2 BLoC (Quản lý trạng thái)

| Loại BLoC | Vị trí |
| :--- | :--- |
| Dùng chung nhiều màn hình (`AuthBloc`, `SettingsBloc`) | `lib/presentation/bloc/[tên]/` |
| Riêng của 1 màn hình | `lib/presentation/screens/[tên_màn_hình]/bloc/` |

- ✅ **BẮT BUỘC** dùng `freezed` cho State và Event. Khai báo class **BẮT BUỘC** thêm từ khóa `abstract` (VD: `abstract class CategoryState with _$CategoryState`).
- ✅ **BẮT BUỘC** có đủ 4 trạng thái chuẩn: `initial`, `loading`, `loaded/success`, `error/failure`.
- ✅ Với Stream (Drift watch query): Luôn dùng `emit.forEach`. **CẤM** dùng `Stream.listen`.
- ❌ **CẤM** gọi `emit` bên trong callback chưa được `await` hoặc sau khi handler kết thúc.

### 3.3 Widget & Bố cục

| Thành phần | Vị trí |
| :--- | :--- |
| Màn hình chính | `lib/presentation/screens/[tên]/[tên]_screen.dart` |
| Widget riêng của màn hình | `lib/presentation/screens/[tên]/widgets/` |
| Widget dùng chung toàn app | `lib/presentation/widgets/` |
| Giao diện Mobile (nếu tách) | `lib/presentation/screens/[tên]/views/[tên]_mobile_view.dart` |
| Giao diện Desktop (nếu tách) | `lib/presentation/screens/[tên]/views/[tên]_desktop_view.dart` |

- ✅ Ưu tiên tách nhỏ màn hình thành Widget con đơn trách nhiệm.
- ✅ **BẮT BUỘC** kiểm tra `lib/presentation/widgets/` trước khi tạo widget mới. Tái sử dụng nếu đã có.
- ❌ **CẤM** viết hàm trả về Widget (VD: `Widget _buildList() { ... }`). Phải tách thành Widget class riêng biệt.

---

## Bước 4: Dependency Injection (Kết nối)
**Làm gì**: Đăng ký các thành phần trong `lib/core/di/dependency_injection.dart`.
**Thứ tự đăng ký BẮT BUỘC**: `DataSource → Repository → UseCase → Bloc`.

- ✅ DataSource, Repository và UseCase dùng `registerLazySingleton` (tạo 1 lần duy nhất).
- ✅ Bloc dùng `registerFactory` (tạo mới mỗi lần gọi).

---

## Bước 5: Kiểm tra & Hoàn tất
1. ✅ Chạy `dart run build_runner build -d` nếu có sửa file Freezed hoặc Drift.
2. ✅ Chạy `flutter analyze` để kiểm tra code sạch, không có import thừa.
3. ✅ Viết Unit Test cho UseCase và Repository tại thư mục `test/`.
4. ✅ Xóa file rác và code chết sau khi hoàn thành.

---

# PHẦN C: HÀNH VI AI (BẮT BUỘC)

## C1. Khi TẠO MỚI chức năng
1. **[BẮT BUỘC] KIỂM TRA TRƯỚC KHI TẠO**: Trước khi viết bất kỳ widget mới nào, PHẢI dùng `list_dir` hoặc `grep_search` để kiểm tra `lib/presentation/widgets/`. Nếu đã có widget tương tự thì TÁI SỬ DỤNG.
2. **[BẮT BUỘC] SINH CODE TỪNG BƯỚC**: Khi tạo màn hình phức tạp, KHÔNG ĐƯỢC sinh tất cả trong 1 lần. Phải đề xuất danh sách widget con → tạo từng file → lắp ghép vào màn hình chính.

## C2. Khi SỬA/CẬP NHẬT chức năng cũ
Khi có thay đổi về cấu trúc dữ liệu, **BẮT BUỘC** cập nhật theo đúng thứ tự:
`database.md → Drift Table → Migration → Model → Entity → BLoC → UI → build_runner → flutter analyze`

**Quy tắc Migration (Di cư dữ liệu):**
- ✅ Sau khi sửa Drift Table, **BẮT BUỘC** tăng `schemaVersion` lên 1 đơn vị trong `app_database.dart`.
- ✅ **BẮT BUỘC** viết hàm `onUpgrade` trong `MigrationStrategy` để hướng dẫn Drift cập nhật bảng cũ (VD: `addColumn`, `createTable`).
- ❌ **CẤM** xóa các bước migration cũ trong code (vì khách hàng lâu ngày không cập nhật app vẫn cần chạy lại từ version cũ).
- ❌ **CẤM** bỏ qua bất kỳ bước nào trong chuỗi trên.
- ❌ **CẤM** sửa UI trước khi sửa Entity/Model.

