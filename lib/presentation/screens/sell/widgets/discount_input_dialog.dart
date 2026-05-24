import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quan_ly_ban_hang/core/utils/currency_utils.dart';
import 'package:quan_ly_ban_hang/presentation/widgets/app_formatters.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';
import '../../../../../l10n/app_localizations.dart';

class DiscountInputDialog extends StatefulWidget {
  final int initialDiscount;
  final int totalAmount;

  const DiscountInputDialog({
    super.key, 
    required this.initialDiscount,
    required this.totalAmount,
  });

  @override
  State<DiscountInputDialog> createState() => _DiscountInputDialogState();
}

class _DiscountInputDialogState extends State<DiscountInputDialog> {
  late final TextEditingController _controller;
  bool _isPercentage = false;
  int _calculatedAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculatedAmount = widget.initialDiscount;
    _controller = TextEditingController(
        text: widget.initialDiscount > 0
            ? AppFormatters.formatCurrency(widget.initialDiscount).replaceAll('đ', '').replaceAll('₫', '').trim()
            : '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateCalculation(String value) {
    if (value.isEmpty) {
      setState(() {
        _calculatedAmount = 0;
      });
      return;
    }

    if (_isPercentage) {
      final percent = double.tryParse(value) ?? 0;
      setState(() {
        _calculatedAmount = (widget.totalAmount * (percent / 100)).round();
      });
    } else {
      setState(() {
        _calculatedAmount = CurrencyUtils.parseCurrency(value);
      });
    }
  }

  void _submit() {
    if (_isPercentage) {
      final percent = double.tryParse(_controller.text) ?? 0;
      Navigator.of(context).pop((isPercentage: true, value: percent, calculatedAmount: _calculatedAmount));
    } else {
      Navigator.of(context).pop((isPercentage: false, value: _calculatedAmount, calculatedAmount: _calculatedAmount));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppDialog(
      title: l10n.discount,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment<bool>(
                value: false,
                label: Text('VND (₫)'),
              ),
              ButtonSegment<bool>(
                value: true,
                label: Text('Phần trăm (%)'),
              ),
            ],
            selected: {_isPercentage},
            onSelectionChanged: (Set<bool> newSelection) {
              setState(() {
                _isPercentage = newSelection.first;
                _controller.clear();
                _calculatedAmount = 0;
              });
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _controller,
            labelText: _isPercentage ? 'Nhập % giảm giá (VD: 10)' : l10n.enterDiscount,
            keyboardType: TextInputType.number,
            inputFormatters: _isPercentage
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ]
                : [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
            textInputAction: TextInputAction.done,
            onChanged: _updateCalculation,
            onFieldSubmitted: () {
              _submit();
            },
          ),
          if (_isPercentage && _calculatedAmount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Tương đương: ${AppFormatters.formatCurrency(_calculatedAmount)}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text(l10n.save),
        ),
      ],
    );
  }
}
