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
}
