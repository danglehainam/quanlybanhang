import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyUtils {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
  );

  /// Format số nguyên thành chuỗi tiền tệ (VD: 100000 -> "100.000 đ")
  static String formatCurrency(int amount) {
    return _currencyFormat.format(amount);
  }

  /// Format số nguyên thành chuỗi phân cách hàng nghìn (VD: 100000 -> "100.000")
  static String formatNumber(int amount) {
    return NumberFormat.decimalPattern('vi_VN').format(amount);
  }

  /// Parse chuỗi định dạng tiền tệ về số nguyên (VD: "100.000" -> 100000)
  static int parseCurrency(String formattedString) {
    if (formattedString.trim().isEmpty) return 0;
    // Bỏ tất cả các ký tự không phải là số (VD: dấu chấm, phẩy, chữ đ)
    final cleanString = formattedString.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleanString) ?? 0;
  }
}

/// Formatter tự động thêm dấu phân cách hàng nghìn khi người dùng nhập liệu
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Lấy chỉ số hiện tại để format
    final int selectionIndexFromRight = newValue.text.length - newValue.selection.end;
    
    // Xóa tất cả các ký tự không phải số
    final cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Format thành dạng 100.000
    final formatter = NumberFormat.decimalPattern('vi_VN');
    final int value = int.parse(cleanText);
    final String newText = formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length - selectionIndexFromRight,
      ),
    );
  }
}
