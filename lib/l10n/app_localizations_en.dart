// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Sales Management';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Logout';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get userName => 'Your name';

  @override
  String get storeName => 'Store name';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get createAccount => 'Create account';

  @override
  String get noAccountYet => 'Don\'t have an account? ';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get validationEmailRequired => 'Please enter your email';

  @override
  String get validationEmailInvalid => 'Invalid email format';

  @override
  String get validationPasswordRequired => 'Please enter your password';

  @override
  String get validationPasswordTooShort =>
      'Password must be at least 6 characters';

  @override
  String get validationConfirmPasswordRequired =>
      'Please confirm your password';

  @override
  String get validationPasswordMismatch => 'Passwords do not match';

  @override
  String get validationNameRequired => 'Please enter your name';

  @override
  String get validationStoreNameRequired => 'Please enter store name';

  @override
  String get home => 'Home';

  @override
  String welcomeUser(String name) {
    return 'Hello, $name!';
  }

  @override
  String get owner => 'Store Owner';

  @override
  String get employee => 'Employee';

  @override
  String get menuOverview => 'Overview';

  @override
  String get menuProducts => 'Products';

  @override
  String get menuCategories => 'Categories';

  @override
  String get menuTransactions => 'Transactions';

  @override
  String get menuPartners => 'Partners';

  @override
  String get menuCashbook => 'Cashbook';

  @override
  String get menuReports => 'Reports';

  @override
  String get btnSell => 'Sell';

  @override
  String get switchDesktop => 'Desktop View';

  @override
  String get switchMobile => 'Mobile View';

  @override
  String get filterAndSearch => 'Filter & Search';

  @override
  String get searchCategory => 'Search categories...';

  @override
  String get searchByName => 'Search by name...';

  @override
  String get sortBy => 'Sort by';

  @override
  String get newest => 'Newest';

  @override
  String get oldest => 'Oldest';

  @override
  String get emptyCategoryMessage =>
      'No categories found.\nPlease add a new category to manage them easily.';

  @override
  String get retry => 'Retry';

  @override
  String get addCategory => 'Add Category';

  @override
  String get addCategoryTitle => 'Add New Category';

  @override
  String get categoryName => 'Category Name';

  @override
  String get categoryDescription => 'Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get validationCategoryNameRequired => 'Please enter a category name';

  @override
  String get editCategory => 'Update Category';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteCategoryConfirmTitle => 'Delete Category';

  @override
  String get deleteCategoryConfirmMessage =>
      'Are you sure you want to delete this category? This action cannot be undone.';

  @override
  String get categoryCreatedSuccess => 'Category created successfully!';

  @override
  String get categoryUpdatedSuccess => 'Category updated successfully!';

  @override
  String get categoryDeletedSuccess => 'Category deleted successfully!';

  @override
  String get productName => 'Product Name';

  @override
  String get price => 'Price';

  @override
  String get description => 'Description';

  @override
  String get status => 'Status';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get unassignedCategory => 'Unassigned';

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Update Product';

  @override
  String get deleteProductConfirmTitle => 'Delete Product';

  @override
  String get deleteProductConfirmMessage =>
      'Are you sure you want to delete this product?';

  @override
  String get productCreatedSuccess => 'Product created successfully!';

  @override
  String get productUpdatedSuccess => 'Product updated successfully!';

  @override
  String get productDeletedSuccess => 'Product deleted successfully!';

  @override
  String get emptyProductMessage =>
      'No products yet. Click Add to get started!';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationPriceRequired => 'Please enter a valid price';

  @override
  String get searchProduct => 'Search products...';

  @override
  String get addOrder => 'Add Order';

  @override
  String orderNumber(int number) {
    return 'Order #$number';
  }

  @override
  String get completeOrder => 'Complete';

  @override
  String get confirmOrder => 'Confirm';

  @override
  String get emptyOrderMessage => 'No items yet.';

  @override
  String get cart => 'Cart';

  @override
  String get totalAmount => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get draftOrders => 'Active Orders';

  @override
  String get orderCompletedSuccess => 'Order completed successfully!';

  @override
  String get orderConfirmedSuccess => 'Order saved as pending!';
}
