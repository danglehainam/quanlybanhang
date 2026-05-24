
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../domain/entities/order_entity.dart';
import '../../../../domain/entities/customer_entity.dart';
import '../../../../domain/entities/customer_table_entity.dart';
import '../../../../domain/usecases/find_customer_by_phone_usecase.dart';
import '../../../../domain/usecases/get_customer_tables_usecase.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/auth/auth_state.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';

import '../../../widgets/app_compact_text_field.dart';
import 'add_customer_quick_dialog.dart';

class PosDesktopOrderHeader extends StatefulWidget {
  final OrderEntity activeOrder;

  const PosDesktopOrderHeader({super.key, required this.activeOrder});

  @override
  State<PosDesktopOrderHeader> createState() => _PosDesktopOrderHeaderState();
}

class _PosDesktopOrderHeaderState extends State<PosDesktopOrderHeader> {
  final _phoneController = TextEditingController();
  final _discountController = TextEditingController();
  final _noteController = TextEditingController();

  final _findCustomerUseCase = getIt<FindCustomerByPhoneUseCase>();
  final _getTablesUseCase = getIt<GetCustomerTablesUseCase>();

  List<CustomerTableEntity> _tables = [];
  bool _isLoadingTables = true;
  bool _isCheckingCustomer = false;

  bool _isDiscountPercentage = false;

  @override
  void initState() {
    super.initState();
    _loadTables();
    _syncWithOrder();
  }

  @override
  void didUpdateWidget(covariant PosDesktopOrderHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeOrder != oldWidget.activeOrder) {
      _syncWithOrder();
    }
  }

  void _syncWithOrder() {
    // Note: To avoid overriding user input while typing, only sync if different.
    // However, it's safer to sync when order changes from outside.
    if (widget.activeOrder.customer != null && _phoneController.text.isEmpty) {
      _phoneController.text = widget.activeOrder.customer!.phone;
    } else if (widget.activeOrder.customer == null && !_phoneController.text.startsWith('0')) {
        // user is typing or something, we shouldn't wipe it out.
    }

    _isDiscountPercentage = widget.activeOrder.discountPercent != null;
    final discountVal = _isDiscountPercentage ? widget.activeOrder.discountPercent.toString() : widget.activeOrder.discount.toString();
    if (discountVal != '0' && _discountController.text.isEmpty) {
      _discountController.text = discountVal;
    }

    if (widget.activeOrder.note != null && _noteController.text != widget.activeOrder.note) {
      _noteController.text = widget.activeOrder.note!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _discountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _loadTables() async {
    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 1,
    );
    final stream = _getTablesUseCase.execute(storeId);
    stream.listen((eitherResult) {
      if (!mounted) return;
      eitherResult.fold(
        (failure) => setState(() => _isLoadingTables = false),
        (tables) {
          setState(() {
            _tables = tables.where((t) => t.status == 1).toList();
            _isLoadingTables = false;
          });
        },
      );
    });
  }

  Future<void> _checkCustomer() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;

    setState(() => _isCheckingCustomer = true);

    final authState = context.read<AuthBloc>().state;
    final storeId = authState.maybeMap(
      authenticated: (state) => state.user.storeId,
      orElse: () => 1,
    );

    final result = await _findCustomerUseCase(storeId, phone);
    
    if (!mounted) return;
    setState(() => _isCheckingCustomer = false);

    result.fold(
      (failure) {
        // Handle error
      },
      (customer) async {
        if (customer != null) {
          // Found
          context.read<SellBloc>().add(SellEvent.updateCustomer(customer));
        } else {
          // Not found -> open dialog
          final newCustomer = await showDialog<CustomerEntity>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AddCustomerQuickDialog(initialPhone: phone),
          );
          if (newCustomer != null && mounted) {
            context.read<SellBloc>().add(SellEvent.updateCustomer(newCustomer));
          }
        }
      },
    );
  }

  void _updateDiscount() {
    final val = double.tryParse(_discountController.text) ?? 0.0;
    if (_isDiscountPercentage) {
      int amount = (widget.activeOrder.totalAmount * val / 100).round();
      context.read<SellBloc>().add(SellEvent.updateDiscount(discountPercent: val, discountAmount: amount));
    } else {
      context.read<SellBloc>().add(SellEvent.updateDiscount(discountAmount: val.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    const inputStyle = TextStyle(fontSize: 13);
    const labelStyle = TextStyle(fontSize: 12, color: AppColors.textSecondary);

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Khách hàng
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('Khách:', style: labelStyle),
              ),
              SizedBox(
                width: 130,
                child: SizedBox(
                  height: 30,
                  child: AppCompactTextField(
                    controller: _phoneController,
                    hintText: 'SĐT...',
                    suffixIcon: widget.activeOrder.customer != null 
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _phoneController.clear();
                            context.read<SellBloc>().add(const SellEvent.updateCustomer(null));
                          },
                        )
                      : null,
                    onSubmitted: (_) => _checkCustomer(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (widget.activeOrder.customer == null)
                SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: _isCheckingCustomer ? null : _checkCustomer,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                    child: _isCheckingCustomer 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Tìm', style: inputStyle),
                  ),
                ),
              if (widget.activeOrder.customer != null)
                Expanded(
                  child: Text(
                    widget.activeOrder.customer!.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.primary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),

          // Row 2: Bàn
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('Bàn:', style: labelStyle),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: _isLoadingTables
                      ? const Align(alignment: Alignment.centerLeft, child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)))
                      : DropdownButtonFormField<CustomerTableEntity?>(
                          value: _tables.contains(widget.activeOrder.table) ? widget.activeOrder.table : null,
                          isExpanded: true,
                          isDense: true,
                          style: inputStyle.copyWith(color: AppColors.textPrimary),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                          hint: Text('Chọn bàn', style: inputStyle),
                          items: [
                            DropdownMenuItem<CustomerTableEntity?>(
                              value: null,
                              child: const Text('Chọn bàn', style: inputStyle),
                            ),
                            ..._tables.map((t) => DropdownMenuItem(
                                  value: t,
                                  child: Text(t.name, style: inputStyle),
                                )),
                          ],
                          onChanged: (table) {
                            context.read<SellBloc>().add(SellEvent.updateTable(table));
                          },
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Row 3: Giảm giá
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Text('Giảm:', style: labelStyle),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: AppCompactTextField(
                    controller: _discountController,
                    keyboardType: TextInputType.number,
                    hintText: '0',
                    onChanged: (_) => _updateDiscount(),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _isDiscountPercentage,
                    onChanged: (val) {
                      setState(() => _isDiscountPercentage = false);
                      _updateDiscount();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text('VND', style: inputStyle),
                  const SizedBox(width: 4),
                  Radio<bool>(
                    value: true,
                    groupValue: _isDiscountPercentage,
                    onChanged: (val) {
                      setState(() => _isDiscountPercentage = true);
                      _updateDiscount();
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const Text('%', style: inputStyle),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Row 4: Ghi chú
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Ghi chú:', style: labelStyle),
                ),
              ),
              Expanded(
                child: AppCompactTextField(
                  controller: _noteController,
                  hintText: 'Nhập ghi chú...',
                  maxLines: 2,
                  onChanged: (val) {
                    context.read<SellBloc>().add(SellEvent.updateNote(val.isEmpty ? null : val));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
