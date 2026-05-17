// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Quản Lý Bán Hàng';

  @override
  String get login => 'Đăng nhập';

  @override
  String get register => 'Đăng ký';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get confirmPassword => 'Xác nhận mật khẩu';

  @override
  String get userName => 'Tên của bạn';

  @override
  String get storeName => 'Tên cửa hàng';

  @override
  String get rememberMe => 'Ghi nhớ đăng nhập';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get noAccountYet => 'Chưa có tài khoản? ';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản? ';

  @override
  String get validationEmailRequired => 'Vui lòng nhập email';

  @override
  String get validationEmailInvalid => 'Email không hợp lệ';

  @override
  String get validationPasswordRequired => 'Vui lòng nhập mật khẩu';

  @override
  String get validationPasswordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get validationConfirmPasswordRequired => 'Vui lòng xác nhận mật khẩu';

  @override
  String get validationPasswordMismatch => 'Mật khẩu không khớp';

  @override
  String get validationNameRequired => 'Vui lòng nhập tên';

  @override
  String get validationStoreNameRequired => 'Vui lòng nhập tên cửa hàng';

  @override
  String get home => 'Trang chủ';

  @override
  String welcomeUser(String name) {
    return 'Xin chào, $name!';
  }

  @override
  String get owner => 'Chủ cửa hàng';

  @override
  String get employee => 'Nhân viên';

  @override
  String get menuOverview => 'Tổng quan';

  @override
  String get menuProducts => 'Sản phẩm';

  @override
  String get menuCategories => 'Danh mục';

  @override
  String get menuTransactions => 'Giao dịch';

  @override
  String get menuPartners => 'Đối tác';

  @override
  String get menuCashbook => 'Sổ quỹ';

  @override
  String get menuReports => 'Báo cáo';

  @override
  String get btnSell => 'Bán hàng';

  @override
  String get switchDesktop => 'Giao diện Desktop';

  @override
  String get switchMobile => 'Giao diện Mobile';

  @override
  String get filterAndSearch => 'Bộ lọc & Tìm kiếm';

  @override
  String get searchCategory => 'Tìm kiếm danh mục...';

  @override
  String get searchByName => 'Tìm kiếm theo tên...';

  @override
  String get sortBy => 'Sắp xếp theo';

  @override
  String get newest => 'Mới nhất';

  @override
  String get oldest => 'Cũ nhất';

  @override
  String get emptyCategoryMessage =>
      'Chưa có danh mục nào.\nHãy thêm danh mục mới để quản lý dễ dàng hơn.';

  @override
  String get retry => 'Thử lại';

  @override
  String get addCategory => 'Thêm danh mục';
}
