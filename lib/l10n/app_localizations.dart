import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In vi, this message translates to:
  /// **'Quản Lý Bán Hàng'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In vi, this message translates to:
  /// **'Đăng nhập'**
  String get login;

  /// No description provided for @register.
  ///
  /// In vi, this message translates to:
  /// **'Đăng ký'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In vi, this message translates to:
  /// **'Đăng xuất'**
  String get logout;

  /// No description provided for @email.
  ///
  /// In vi, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận mật khẩu'**
  String get confirmPassword;

  /// No description provided for @userName.
  ///
  /// In vi, this message translates to:
  /// **'Tên của bạn'**
  String get userName;

  /// No description provided for @storeName.
  ///
  /// In vi, this message translates to:
  /// **'Tên cửa hàng'**
  String get storeName;

  /// No description provided for @rememberMe.
  ///
  /// In vi, this message translates to:
  /// **'Ghi nhớ đăng nhập'**
  String get rememberMe;

  /// No description provided for @createAccount.
  ///
  /// In vi, this message translates to:
  /// **'Tạo tài khoản'**
  String get createAccount;

  /// No description provided for @noAccountYet.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có tài khoản? '**
  String get noAccountYet;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In vi, this message translates to:
  /// **'Đã có tài khoản? '**
  String get alreadyHaveAccount;

  /// No description provided for @validationEmailRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập email'**
  String get validationEmailRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Email không hợp lệ'**
  String get validationEmailInvalid;

  /// No description provided for @validationPasswordRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập mật khẩu'**
  String get validationPasswordRequired;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu phải có ít nhất 6 ký tự'**
  String get validationPasswordTooShort;

  /// No description provided for @validationConfirmPasswordRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng xác nhận mật khẩu'**
  String get validationConfirmPasswordRequired;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In vi, this message translates to:
  /// **'Mật khẩu không khớp'**
  String get validationPasswordMismatch;

  /// No description provided for @validationNameRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên'**
  String get validationNameRequired;

  /// No description provided for @validationStoreNameRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên cửa hàng'**
  String get validationStoreNameRequired;

  /// No description provided for @home.
  ///
  /// In vi, this message translates to:
  /// **'Trang chủ'**
  String get home;

  /// No description provided for @welcomeUser.
  ///
  /// In vi, this message translates to:
  /// **'Xin chào, {name}!'**
  String welcomeUser(String name);

  /// No description provided for @owner.
  ///
  /// In vi, this message translates to:
  /// **'Chủ cửa hàng'**
  String get owner;

  /// No description provided for @employee.
  ///
  /// In vi, this message translates to:
  /// **'Nhân viên'**
  String get employee;

  /// No description provided for @menuOverview.
  ///
  /// In vi, this message translates to:
  /// **'Tổng quan'**
  String get menuOverview;

  /// No description provided for @menuProducts.
  ///
  /// In vi, this message translates to:
  /// **'Sản phẩm'**
  String get menuProducts;

  /// No description provided for @menuCategories.
  ///
  /// In vi, this message translates to:
  /// **'Danh mục'**
  String get menuCategories;

  /// No description provided for @menuTransactions.
  ///
  /// In vi, this message translates to:
  /// **'Giao dịch'**
  String get menuTransactions;

  /// No description provided for @menuOrders.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng'**
  String get menuOrders;

  /// No description provided for @menuPartners.
  ///
  /// In vi, this message translates to:
  /// **'Đối tác'**
  String get menuPartners;

  /// No description provided for @menuCashbook.
  ///
  /// In vi, this message translates to:
  /// **'Sổ quỹ'**
  String get menuCashbook;

  /// No description provided for @menuReports.
  ///
  /// In vi, this message translates to:
  /// **'Báo cáo'**
  String get menuReports;

  /// No description provided for @btnSell.
  ///
  /// In vi, this message translates to:
  /// **'Bán hàng'**
  String get btnSell;

  /// No description provided for @switchDesktop.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện Desktop'**
  String get switchDesktop;

  /// No description provided for @switchMobile.
  ///
  /// In vi, this message translates to:
  /// **'Giao diện Mobile'**
  String get switchMobile;

  /// No description provided for @filterAndSearch.
  ///
  /// In vi, this message translates to:
  /// **'Bộ lọc & Tìm kiếm'**
  String get filterAndSearch;

  /// No description provided for @searchCategory.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm danh mục...'**
  String get searchCategory;

  /// No description provided for @searchByName.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm theo tên...'**
  String get searchByName;

  /// No description provided for @sortBy.
  ///
  /// In vi, this message translates to:
  /// **'Sắp xếp theo'**
  String get sortBy;

  /// No description provided for @newest.
  ///
  /// In vi, this message translates to:
  /// **'Mới nhất'**
  String get newest;

  /// No description provided for @oldest.
  ///
  /// In vi, this message translates to:
  /// **'Cũ nhất'**
  String get oldest;

  /// No description provided for @emptyCategoryMessage.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có danh mục nào.\nHãy thêm danh mục mới để quản lý dễ dàng hơn.'**
  String get emptyCategoryMessage;

  /// No description provided for @retry.
  ///
  /// In vi, this message translates to:
  /// **'Thử lại'**
  String get retry;

  /// No description provided for @addCategory.
  ///
  /// In vi, this message translates to:
  /// **'Thêm danh mục'**
  String get addCategory;

  /// No description provided for @addCategoryTitle.
  ///
  /// In vi, this message translates to:
  /// **'Thêm danh mục mới'**
  String get addCategoryTitle;

  /// No description provided for @categoryName.
  ///
  /// In vi, this message translates to:
  /// **'Tên danh mục'**
  String get categoryName;

  /// No description provided for @categoryDescription.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả'**
  String get categoryDescription;

  /// No description provided for @cancel.
  ///
  /// In vi, this message translates to:
  /// **'Hủy'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In vi, this message translates to:
  /// **'Lưu'**
  String get save;

  /// No description provided for @validationCategoryNameRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập tên danh mục'**
  String get validationCategoryNameRequired;

  /// No description provided for @editCategory.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật danh mục'**
  String get editCategory;

  /// No description provided for @edit.
  ///
  /// In vi, this message translates to:
  /// **'Sửa'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In vi, this message translates to:
  /// **'Xóa'**
  String get delete;

  /// No description provided for @deleteCategoryConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa danh mục'**
  String get deleteCategoryConfirmTitle;

  /// No description provided for @deleteCategoryConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa danh mục này không? Thao tác này không thể hoàn tác.'**
  String get deleteCategoryConfirmMessage;

  /// No description provided for @categoryCreatedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Tạo danh mục thành công!'**
  String get categoryCreatedSuccess;

  /// No description provided for @categoryUpdatedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật danh mục thành công!'**
  String get categoryUpdatedSuccess;

  /// No description provided for @categoryDeletedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Xóa danh mục thành công!'**
  String get categoryDeletedSuccess;

  /// No description provided for @productName.
  ///
  /// In vi, this message translates to:
  /// **'Tên sản phẩm'**
  String get productName;

  /// No description provided for @price.
  ///
  /// In vi, this message translates to:
  /// **'Giá bán'**
  String get price;

  /// No description provided for @description.
  ///
  /// In vi, this message translates to:
  /// **'Mô tả sản phẩm'**
  String get description;

  /// No description provided for @status.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái'**
  String get status;

  /// No description provided for @selectCategory.
  ///
  /// In vi, this message translates to:
  /// **'Chọn danh mục'**
  String get selectCategory;

  /// No description provided for @unassignedCategory.
  ///
  /// In vi, this message translates to:
  /// **'Chưa phân loại'**
  String get unassignedCategory;

  /// No description provided for @addProduct.
  ///
  /// In vi, this message translates to:
  /// **'Thêm sản phẩm'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật sản phẩm'**
  String get editProduct;

  /// No description provided for @deleteProductConfirmTitle.
  ///
  /// In vi, this message translates to:
  /// **'Xóa sản phẩm'**
  String get deleteProductConfirmTitle;

  /// No description provided for @deleteProductConfirmMessage.
  ///
  /// In vi, this message translates to:
  /// **'Bạn có chắc chắn muốn xóa sản phẩm này không?'**
  String get deleteProductConfirmMessage;

  /// No description provided for @productCreatedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Tạo sản phẩm thành công!'**
  String get productCreatedSuccess;

  /// No description provided for @productUpdatedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Cập nhật sản phẩm thành công!'**
  String get productUpdatedSuccess;

  /// No description provided for @productDeletedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Xóa sản phẩm thành công!'**
  String get productDeletedSuccess;

  /// No description provided for @emptyProductMessage.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có sản phẩm nào. Hãy bấm nút Thêm để bắt đầu!'**
  String get emptyProductMessage;

  /// No description provided for @validationRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập thông tin này'**
  String get validationRequired;

  /// No description provided for @validationPriceRequired.
  ///
  /// In vi, this message translates to:
  /// **'Vui lòng nhập giá bán hợp lệ'**
  String get validationPriceRequired;

  /// No description provided for @searchProduct.
  ///
  /// In vi, this message translates to:
  /// **'Tìm sản phẩm...'**
  String get searchProduct;

  /// No description provided for @addOrder.
  ///
  /// In vi, this message translates to:
  /// **'Thêm đơn'**
  String get addOrder;

  /// No description provided for @orderNumber.
  ///
  /// In vi, this message translates to:
  /// **'Đơn #{number}'**
  String orderNumber(int number);

  /// No description provided for @completeOrder.
  ///
  /// In vi, this message translates to:
  /// **'Hoàn thành'**
  String get completeOrder;

  /// No description provided for @confirmOrder.
  ///
  /// In vi, this message translates to:
  /// **'Xác nhận'**
  String get confirmOrder;

  /// No description provided for @emptyOrderMessage.
  ///
  /// In vi, this message translates to:
  /// **'Chưa có món nào.'**
  String get emptyOrderMessage;

  /// No description provided for @cart.
  ///
  /// In vi, this message translates to:
  /// **'Giỏ hàng'**
  String get cart;

  /// No description provided for @totalAmount.
  ///
  /// In vi, this message translates to:
  /// **'Tổng cộng'**
  String get totalAmount;

  /// No description provided for @checkout.
  ///
  /// In vi, this message translates to:
  /// **'Thanh toán'**
  String get checkout;

  /// No description provided for @draftOrders.
  ///
  /// In vi, this message translates to:
  /// **'Đơn hàng đang phục vụ'**
  String get draftOrders;

  /// No description provided for @orderCompletedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã hoàn thành đơn hàng!'**
  String get orderCompletedSuccess;

  /// No description provided for @orderConfirmedSuccess.
  ///
  /// In vi, this message translates to:
  /// **'Đã xác nhận đơn hàng (lưu nháp)!'**
  String get orderConfirmedSuccess;

  /// No description provided for @customer.
  ///
  /// In vi, this message translates to:
  /// **'Khách'**
  String get customer;

  /// No description provided for @retailCustomer.
  ///
  /// In vi, this message translates to:
  /// **'Khách lẻ'**
  String get retailCustomer;

  /// No description provided for @table.
  ///
  /// In vi, this message translates to:
  /// **'Bàn'**
  String get table;

  /// No description provided for @selectTable.
  ///
  /// In vi, this message translates to:
  /// **'Chọn bàn'**
  String get selectTable;

  /// No description provided for @discount.
  ///
  /// In vi, this message translates to:
  /// **'Giảm'**
  String get discount;

  /// No description provided for @enterDiscount.
  ///
  /// In vi, this message translates to:
  /// **'Nhập giảm giá'**
  String get enterDiscount;

  /// No description provided for @note.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú'**
  String get note;

  /// No description provided for @enterNote.
  ///
  /// In vi, this message translates to:
  /// **'Nhập ghi chú'**
  String get enterNote;

  /// No description provided for @orderCode.
  ///
  /// In vi, this message translates to:
  /// **'Mã ĐH'**
  String get orderCode;

  /// No description provided for @orderTime.
  ///
  /// In vi, this message translates to:
  /// **'Thời gian'**
  String get orderTime;

  /// No description provided for @finalAmount.
  ///
  /// In vi, this message translates to:
  /// **'Phải trả'**
  String get finalAmount;

  /// No description provided for @actions.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết'**
  String get actions;

  /// No description provided for @emptyOrdersMessage.
  ///
  /// In vi, this message translates to:
  /// **'Không tìm thấy đơn hàng nào.'**
  String get emptyOrdersMessage;

  /// No description provided for @orderStatusPending.
  ///
  /// In vi, this message translates to:
  /// **'Chờ thanh toán'**
  String get orderStatusPending;

  /// No description provided for @orderStatusCompleted.
  ///
  /// In vi, this message translates to:
  /// **'Đã hoàn thành'**
  String get orderStatusCompleted;

  /// No description provided for @orderStatusCancelled.
  ///
  /// In vi, this message translates to:
  /// **'Đã huỷ'**
  String get orderStatusCancelled;

  /// No description provided for @searchOrdersPlaceholder.
  ///
  /// In vi, this message translates to:
  /// **'Tìm đơn hàng...'**
  String get searchOrdersPlaceholder;

  /// No description provided for @searchFieldLabel.
  ///
  /// In vi, this message translates to:
  /// **'Nhập SĐT, Tên bàn, ID...'**
  String get searchFieldLabel;

  /// No description provided for @orderDetailTitle.
  ///
  /// In vi, this message translates to:
  /// **'Chi tiết đơn hàng #{id}'**
  String orderDetailTitle(int id);

  /// No description provided for @orderDetailProducts.
  ///
  /// In vi, this message translates to:
  /// **'Danh sách sản phẩm'**
  String get orderDetailProducts;

  /// No description provided for @orderDate.
  ///
  /// In vi, this message translates to:
  /// **'Ngày bán:'**
  String get orderDate;

  /// No description provided for @customerLabel.
  ///
  /// In vi, this message translates to:
  /// **'Khách hàng:'**
  String get customerLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số điện thoại:'**
  String get phoneLabel;

  /// No description provided for @tableLabel.
  ///
  /// In vi, this message translates to:
  /// **'Bàn phục vụ:'**
  String get tableLabel;

  /// No description provided for @statusLabel.
  ///
  /// In vi, this message translates to:
  /// **'Trạng thái:'**
  String get statusLabel;

  /// No description provided for @noteLabel.
  ///
  /// In vi, this message translates to:
  /// **'Ghi chú:'**
  String get noteLabel;

  /// No description provided for @itemsCount.
  ///
  /// In vi, this message translates to:
  /// **'{count} món'**
  String itemsCount(int count);

  /// No description provided for @all.
  ///
  /// In vi, this message translates to:
  /// **'Tất cả'**
  String get all;

  /// No description provided for @highestValue.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị cao nhất'**
  String get highestValue;

  /// No description provided for @lowestValue.
  ///
  /// In vi, this message translates to:
  /// **'Giá trị thấp nhất'**
  String get lowestValue;

  /// No description provided for @searchLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tìm kiếm'**
  String get searchLabel;

  /// No description provided for @productImage.
  ///
  /// In vi, this message translates to:
  /// **'Ảnh sản phẩm'**
  String get productImage;

  /// No description provided for @stockLabel.
  ///
  /// In vi, this message translates to:
  /// **'Tồn kho: {count}'**
  String stockLabel(int count);

  /// No description provided for @madeToOrder.
  ///
  /// In vi, this message translates to:
  /// **'Chế biến'**
  String get madeToOrder;

  /// No description provided for @inStock.
  ///
  /// In vi, this message translates to:
  /// **'Còn hàng'**
  String get inStock;

  /// No description provided for @outOfStock.
  ///
  /// In vi, this message translates to:
  /// **'Hết hàng'**
  String get outOfStock;

  /// No description provided for @actionsLabel.
  ///
  /// In vi, this message translates to:
  /// **'Thao tác'**
  String get actionsLabel;

  /// No description provided for @priceRange.
  ///
  /// In vi, this message translates to:
  /// **'Khoảng giá'**
  String get priceRange;

  /// No description provided for @fromPrice.
  ///
  /// In vi, this message translates to:
  /// **'Từ giá'**
  String get fromPrice;

  /// No description provided for @toPrice.
  ///
  /// In vi, this message translates to:
  /// **'Đến giá'**
  String get toPrice;

  /// No description provided for @defaultSort.
  ///
  /// In vi, this message translates to:
  /// **'Mặc định'**
  String get defaultSort;

  /// No description provided for @sortNameAZ.
  ///
  /// In vi, this message translates to:
  /// **'Tên: A - Z'**
  String get sortNameAZ;

  /// No description provided for @sortNameZA.
  ///
  /// In vi, this message translates to:
  /// **'Tên: Z - A'**
  String get sortNameZA;

  /// No description provided for @sortPriceAsc.
  ///
  /// In vi, this message translates to:
  /// **'Giá tăng dần'**
  String get sortPriceAsc;

  /// No description provided for @sortPriceDesc.
  ///
  /// In vi, this message translates to:
  /// **'Giá giảm dần'**
  String get sortPriceDesc;

  /// No description provided for @quantityLabel.
  ///
  /// In vi, this message translates to:
  /// **'Số lượng'**
  String get quantityLabel;

  /// No description provided for @validationStockInvalid.
  ///
  /// In vi, this message translates to:
  /// **'Số lượng tồn kho không hợp lệ'**
  String get validationStockInvalid;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
