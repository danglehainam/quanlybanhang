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
  String get menuOrders => 'Đơn hàng';

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

  @override
  String get addCategoryTitle => 'Thêm danh mục mới';

  @override
  String get categoryName => 'Tên danh mục';

  @override
  String get categoryDescription => 'Mô tả';

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get validationCategoryNameRequired => 'Vui lòng nhập tên danh mục';

  @override
  String get editCategory => 'Cập nhật danh mục';

  @override
  String get edit => 'Sửa';

  @override
  String get delete => 'Xóa';

  @override
  String get deleteCategoryConfirmTitle => 'Xóa danh mục';

  @override
  String get deleteCategoryConfirmMessage =>
      'Bạn có chắc chắn muốn xóa danh mục này không? Thao tác này không thể hoàn tác.';

  @override
  String get categoryCreatedSuccess => 'Tạo danh mục thành công!';

  @override
  String get categoryUpdatedSuccess => 'Cập nhật danh mục thành công!';

  @override
  String get categoryDeletedSuccess => 'Xóa danh mục thành công!';

  @override
  String get productName => 'Tên sản phẩm';

  @override
  String get price => 'Giá bán';

  @override
  String get description => 'Mô tả sản phẩm';

  @override
  String get status => 'Trạng thái';

  @override
  String get selectCategory => 'Chọn danh mục';

  @override
  String get unassignedCategory => 'Chưa phân loại';

  @override
  String get addProduct => 'Thêm sản phẩm';

  @override
  String get editProduct => 'Cập nhật sản phẩm';

  @override
  String get deleteProductConfirmTitle => 'Xóa sản phẩm';

  @override
  String get deleteProductConfirmMessage =>
      'Bạn có chắc chắn muốn xóa sản phẩm này không?';

  @override
  String get productCreatedSuccess => 'Tạo sản phẩm thành công!';

  @override
  String get productUpdatedSuccess => 'Cập nhật sản phẩm thành công!';

  @override
  String get productDeletedSuccess => 'Xóa sản phẩm thành công!';

  @override
  String get emptyProductMessage =>
      'Chưa có sản phẩm nào. Hãy bấm nút Thêm để bắt đầu!';

  @override
  String get validationRequired => 'Vui lòng nhập thông tin này';

  @override
  String get validationPriceRequired => 'Vui lòng nhập giá bán hợp lệ';

  @override
  String get searchProduct => 'Tìm sản phẩm...';

  @override
  String get addOrder => 'Thêm đơn';

  @override
  String orderNumber(int number) {
    return 'Đơn #$number';
  }

  @override
  String get completeOrder => 'Hoàn thành';

  @override
  String get confirmOrder => 'Xác nhận';

  @override
  String get emptyOrderMessage => 'Chưa có món nào.';

  @override
  String get cart => 'Giỏ hàng';

  @override
  String get totalAmount => 'Tổng cộng';

  @override
  String get checkout => 'Thanh toán';

  @override
  String get draftOrders => 'Đơn hàng đang phục vụ';

  @override
  String get orderCompletedSuccess => 'Đã hoàn thành đơn hàng!';

  @override
  String get orderConfirmedSuccess => 'Đã xác nhận đơn hàng (lưu nháp)!';

  @override
  String get customer => 'Khách';

  @override
  String get retailCustomer => 'Khách lẻ';

  @override
  String get table => 'Bàn';

  @override
  String get selectTable => 'Chọn bàn';

  @override
  String get discount => 'Giảm';

  @override
  String get enterDiscount => 'Nhập giảm giá';

  @override
  String get note => 'Ghi chú';

  @override
  String get enterNote => 'Nhập ghi chú';

  @override
  String get orderCode => 'Mã ĐH';

  @override
  String get orderTime => 'Thời gian';

  @override
  String get finalAmount => 'Phải trả';

  @override
  String get actions => 'Chi tiết';

  @override
  String get emptyOrdersMessage => 'Không tìm thấy đơn hàng nào.';

  @override
  String get orderStatusPending => 'Chờ thanh toán';

  @override
  String get orderStatusCompleted => 'Đã hoàn thành';

  @override
  String get orderStatusCancelled => 'Đã huỷ';

  @override
  String get searchOrdersPlaceholder => 'Tìm đơn hàng...';

  @override
  String get searchFieldLabel => 'Nhập SĐT, Tên bàn, ID...';

  @override
  String orderDetailTitle(int id) {
    return 'Chi tiết đơn hàng #$id';
  }

  @override
  String get orderDetailProducts => 'Danh sách sản phẩm';

  @override
  String get orderDate => 'Ngày bán:';

  @override
  String get customerLabel => 'Khách hàng:';

  @override
  String get phoneLabel => 'Số điện thoại:';

  @override
  String get tableLabel => 'Bàn phục vụ:';

  @override
  String get statusLabel => 'Trạng thái:';

  @override
  String get noteLabel => 'Ghi chú:';

  @override
  String itemsCount(int count) {
    return '$count món';
  }

  @override
  String get all => 'Tất cả';

  @override
  String get highestValue => 'Giá trị cao nhất';

  @override
  String get lowestValue => 'Giá trị thấp nhất';

  @override
  String get searchLabel => 'Tìm kiếm';

  @override
  String get productImage => 'Ảnh sản phẩm';

  @override
  String stockLabel(int count) {
    return 'Tồn kho: $count';
  }

  @override
  String get madeToOrder => 'Chế biến';

  @override
  String get inStock => 'Còn hàng';

  @override
  String get outOfStock => 'Hết hàng';

  @override
  String get actionsLabel => 'Thao tác';

  @override
  String get priceRange => 'Khoảng giá';

  @override
  String get fromPrice => 'Từ giá';

  @override
  String get toPrice => 'Đến giá';

  @override
  String get defaultSort => 'Mặc định';

  @override
  String get sortNameAZ => 'Tên: A - Z';

  @override
  String get sortNameZA => 'Tên: Z - A';

  @override
  String get sortPriceAsc => 'Giá tăng dần';

  @override
  String get sortPriceDesc => 'Giá giảm dần';

  @override
  String get quantityLabel => 'Số lượng';

  @override
  String get validationStockInvalid => 'Số lượng tồn kho không hợp lệ';

  @override
  String get addIncome => 'Thêm thu';

  @override
  String get addExpense => 'Thêm chi';

  @override
  String get editIncome => 'Sửa khoản thu';

  @override
  String get editExpense => 'Sửa khoản chi';

  @override
  String get addIncomeTitle => 'Thêm khoản thu';

  @override
  String get addExpenseTitle => 'Thêm khoản chi';

  @override
  String get income => 'Thu';

  @override
  String get expense => 'Chi';

  @override
  String get transactionFilter => 'Bộ lọc giao dịch';

  @override
  String get searchTransaction => 'Tìm giao dịch...';

  @override
  String get transactionType => 'Loại giao dịch';

  @override
  String get emptyTransactionMessage => 'Không tìm thấy giao dịch nào phù hợp';

  @override
  String get emptyTransactionList => 'Chưa có giao dịch nào';

  @override
  String get amountLabel => 'Số tiền (VND)';

  @override
  String get validationAmountRequired => 'Vui lòng nhập số tiền';

  @override
  String get validationAmountPositive => 'Số tiền phải lớn hơn 0';

  @override
  String get validationNoteRequired => 'Vui lòng nhập ghi chú';

  @override
  String get transactionCreatedSuccess => 'Tạo giao dịch thành công!';

  @override
  String get transactionUpdatedSuccess => 'Cập nhật giao dịch thành công!';

  @override
  String get transactionDeletedSuccess => 'Xóa giao dịch thành công!';

  @override
  String get confirmDeleteTransactionTitle => 'Xác nhận xóa';

  @override
  String confirmDeleteTransactionMessage(int id) {
    return 'Bạn có chắc chắn muốn xóa giao dịch $id này không?';
  }

  @override
  String get transactionTypeCol => 'Loại';

  @override
  String get transactionAmountCol => 'Số Tiền';

  @override
  String get transactionNoteCol => 'Ghi Chú';

  @override
  String get transactionDateCol => 'Ngày Tạo';

  @override
  String get incomeOnly => 'Chỉ khoản thu';

  @override
  String get expenseOnly => 'Chỉ khoản chi';

  @override
  String get productDetailTitle => 'Chi tiết sản phẩm';

  @override
  String get productCode => 'Mã sản phẩm';

  @override
  String get noDescription => 'Không có mô tả';

  @override
  String get dateCreated => 'Ngày tạo';

  @override
  String get dateUpdated => 'Cập nhật cuối';

  @override
  String get close => 'Đóng';

  @override
  String get timeFilter => 'Thời gian';

  @override
  String get specificDate => 'Ngày cụ thể';

  @override
  String get byMonth => 'Theo tháng';

  @override
  String get byQuarter => 'Theo quý';

  @override
  String get byYear => 'Theo năm';

  @override
  String get allTime => 'Tất cả thời gian';

  @override
  String get selectDate => 'Chọn ngày';

  @override
  String get selectMonth => 'Chọn tháng';

  @override
  String get selectYear => 'Chọn năm';

  @override
  String get selectQuarter => 'Chọn quý';

  @override
  String get quarter1 => 'Quý 1';

  @override
  String get quarter2 => 'Quý 2';

  @override
  String get quarter3 => 'Quý 3';

  @override
  String get quarter4 => 'Quý 4';

  @override
  String get back => 'Trở lại';

  @override
  String get cancelOrder => 'Hủy đơn hàng';

  @override
  String get pay => 'Thanh toán';

  @override
  String get confirmPayTitle => 'Xác nhận thanh toán';

  @override
  String get confirmPayMessage =>
      'Bạn có chắc chắn muốn thanh toán đơn hàng này không?';

  @override
  String get confirmCancelOrderTitle => 'Xác nhận hủy đơn';

  @override
  String get confirmCancelOrderMessage =>
      'Bạn có chắc chắn muốn hủy đơn hàng này không? Số lượng sản phẩm tồn kho sẽ được hoàn trả tương ứng.';

  @override
  String get orderStatusCompletedSuccess =>
      'Đơn hàng đã được thanh toán thành công!';

  @override
  String get orderStatusCancelledSuccess => 'Đơn hàng đã được hủy thành công!';
}
