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
  String get menuOrders => 'Orders';

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
  String get orderConfirmedSuccess => 'Order confirmed (saved as draft)!';

  @override
  String get customer => 'Customer';

  @override
  String get retailCustomer => 'Walk-in';

  @override
  String get table => 'Table';

  @override
  String get selectTable => 'Select Table';

  @override
  String get discount => 'Discount';

  @override
  String get enterDiscount => 'Enter discount amount';

  @override
  String get note => 'Note';

  @override
  String get enterNote => 'Enter order note';

  @override
  String get orderCode => 'Order ID';

  @override
  String get orderTime => 'Time';

  @override
  String get finalAmount => 'Due';

  @override
  String get actions => 'Details';

  @override
  String get emptyOrdersMessage => 'No orders found.';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusCompleted => 'Completed';

  @override
  String get orderStatusCancelled => 'Cancelled';

  @override
  String get searchOrdersPlaceholder => 'Search orders...';

  @override
  String get searchFieldLabel => 'Search phone, table, ID...';

  @override
  String orderDetailTitle(int id) {
    return 'Order Details #$id';
  }

  @override
  String get orderDetailProducts => 'Product List';

  @override
  String get orderDate => 'Date:';

  @override
  String get customerLabel => 'Customer:';

  @override
  String get phoneLabel => 'Phone:';

  @override
  String get tableLabel => 'Table:';

  @override
  String get statusLabel => 'Status:';

  @override
  String get noteLabel => 'Note:';

  @override
  String itemsCount(int count) {
    return '$count items';
  }

  @override
  String get all => 'All';

  @override
  String get highestValue => 'Highest Value';

  @override
  String get lowestValue => 'Lowest Value';

  @override
  String get searchLabel => 'Search';

  @override
  String get productImage => 'Product Image';

  @override
  String stockLabel(int count) {
    return 'Stock: $count';
  }

  @override
  String get madeToOrder => 'Made to order';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get actionsLabel => 'Actions';

  @override
  String get priceRange => 'Price Range';

  @override
  String get fromPrice => 'From Price';

  @override
  String get toPrice => 'To Price';

  @override
  String get defaultSort => 'Default';

  @override
  String get sortNameAZ => 'Name: A - Z';

  @override
  String get sortNameZA => 'Name: Z - A';

  @override
  String get sortPriceAsc => 'Price Ascending';

  @override
  String get sortPriceDesc => 'Price Descending';

  @override
  String get quantityLabel => 'Quantity';

  @override
  String get validationStockInvalid => 'Invalid stock quantity';

  @override
  String get addIncome => 'Add Income';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get editIncome => 'Edit Income';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get addIncomeTitle => 'Add Income';

  @override
  String get addExpenseTitle => 'Add Expense';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get transactionFilter => 'Transaction Filter';

  @override
  String get searchTransaction => 'Search transactions...';

  @override
  String get transactionType => 'Transaction Type';

  @override
  String get emptyTransactionMessage => 'No matching transactions found';

  @override
  String get emptyTransactionList => 'No transactions yet';

  @override
  String get amountLabel => 'Amount (VND)';

  @override
  String get validationAmountRequired => 'Please enter amount';

  @override
  String get validationAmountPositive => 'Amount must be greater than 0';

  @override
  String get validationNoteRequired => 'Please enter note';

  @override
  String get transactionCreatedSuccess => 'Transaction created successfully!';

  @override
  String get transactionUpdatedSuccess => 'Transaction updated successfully!';

  @override
  String get transactionDeletedSuccess => 'Transaction deleted successfully!';

  @override
  String get confirmDeleteTransactionTitle => 'Confirm Delete';

  @override
  String confirmDeleteTransactionMessage(int id) {
    return 'Are you sure you want to delete transaction $id?';
  }

  @override
  String get transactionTypeCol => 'Type';

  @override
  String get transactionAmountCol => 'Amount';

  @override
  String get transactionNoteCol => 'Note';

  @override
  String get transactionDateCol => 'Created Date';

  @override
  String get incomeOnly => 'Income Only';

  @override
  String get expenseOnly => 'Expense Only';

  @override
  String get productDetailTitle => 'Product Details';

  @override
  String get productCode => 'Product Code';

  @override
  String get noDescription => 'No description';

  @override
  String get dateCreated => 'Created Date';

  @override
  String get dateUpdated => 'Last Updated';

  @override
  String get close => 'Close';

  @override
  String get timeFilter => 'Time Filter';

  @override
  String get specificDate => 'Specific Date';

  @override
  String get byMonth => 'By Month';

  @override
  String get byQuarter => 'By Quarter';

  @override
  String get byYear => 'By Year';

  @override
  String get allTime => 'All Time';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectMonth => 'Select Month';

  @override
  String get selectYear => 'Select Year';

  @override
  String get selectQuarter => 'Select Quarter';

  @override
  String get quarter1 => 'Quarter 1';

  @override
  String get quarter2 => 'Quarter 2';

  @override
  String get quarter3 => 'Quarter 3';

  @override
  String get quarter4 => 'Quarter 4';

  @override
  String get back => 'Back';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String get pay => 'Pay';

  @override
  String get confirmPayTitle => 'Confirm Payment';

  @override
  String get confirmPayMessage =>
      'Are you sure you want to pay for this order?';

  @override
  String get confirmCancelOrderTitle => 'Confirm Cancellation';

  @override
  String get confirmCancelOrderMessage =>
      'Are you sure you want to cancel this order? Product stock will be refunded accordingly.';

  @override
  String get orderStatusCompletedSuccess => 'Order paid successfully!';

  @override
  String get orderStatusCancelledSuccess => 'Order cancelled successfully!';
}
