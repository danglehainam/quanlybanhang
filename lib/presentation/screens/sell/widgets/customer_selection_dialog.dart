import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../domain/entities/customer_entity.dart';
import '../../../../../domain/usecases/find_customer_by_phone_usecase.dart';
import '../../../../../domain/usecases/create_customer_usecase.dart';
import '../../../widgets/app_dialog.dart';
import '../../../widgets/app_text_field.dart';

class CustomerSelectionCubit extends Cubit<CustomerSelectionState> {
  final FindCustomerByPhoneUseCase findCustomerUseCase;
  final CreateCustomerUseCase createCustomerUseCase;

  CustomerSelectionCubit(this.findCustomerUseCase, this.createCustomerUseCase)
      : super(CustomerSelectionState());

  void searchCustomer(int storeId, String phone) async {
    if (phone.isEmpty) return;
    
    emit(state.copyWith(isLoading: true, isSearching: true, error: null));
    
    final result = await findCustomerUseCase(storeId, phone);
    
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message, isSearching: false)),
      (customer) {
        if (customer != null) {
          // Found customer
          emit(state.copyWith(
            isLoading: false, 
            isSearching: false,
            customer: customer, 
            isNewCustomer: false,
            searchedPhone: phone,
          ));
        } else {
          // Not found, need to create
          emit(state.copyWith(
            isLoading: false, 
            isSearching: false,
            customer: null,
            isNewCustomer: true,
            searchedPhone: phone,
          ));
        }
      },
    );
  }

  void createCustomer(int storeId, String phone, String name) async {
    emit(state.copyWith(isLoading: true, error: null));
    
    final result = await createCustomerUseCase(storeId: storeId, name: name, phone: phone);
    
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (customer) {
        emit(state.copyWith(
          isLoading: false,
          customer: customer,
          isActionSuccess: true,
        ));
      },
    );
  }
}

class CustomerSelectionState {
  final bool isLoading;
  final bool isSearching;
  final bool isNewCustomer;
  final bool isActionSuccess;
  final String? error;
  final CustomerEntity? customer;
  final String searchedPhone;

  CustomerSelectionState({
    this.isLoading = false,
    this.isSearching = false,
    this.isNewCustomer = false,
    this.isActionSuccess = false,
    this.error,
    this.customer,
    this.searchedPhone = '',
  });

  CustomerSelectionState copyWith({
    bool? isLoading,
    bool? isSearching,
    bool? isNewCustomer,
    bool? isActionSuccess,
    String? error,
    CustomerEntity? customer,
    String? searchedPhone,
  }) {
    return CustomerSelectionState(
      isLoading: isLoading ?? this.isLoading,
      isSearching: isSearching ?? this.isSearching,
      isNewCustomer: isNewCustomer ?? this.isNewCustomer,
      isActionSuccess: isActionSuccess ?? this.isActionSuccess,
      error: error,
      customer: customer ?? this.customer,
      searchedPhone: searchedPhone ?? this.searchedPhone,
    );
  }
}

class CustomerSelectionDialog extends StatefulWidget {
  const CustomerSelectionDialog({super.key});

  @override
  State<CustomerSelectionDialog> createState() => _CustomerSelectionDialogState();
}

class _CustomerSelectionDialogState extends State<CustomerSelectionDialog> {
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerSelectionCubit(getIt(), getIt()),
      child: BlocConsumer<CustomerSelectionCubit, CustomerSelectionState>(
        listener: (context, state) {
          if (state.isActionSuccess && state.customer != null) {
            Navigator.of(context).pop(state.customer);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return AppDialog(
            title: 'Chọn Khách Hàng',
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  controller: _phoneController,
                  labelText: 'Số điện thoại',
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: () {
                    context.read<CustomerSelectionCubit>().searchCustomer(1, _phoneController.text); // TODO: Replace with actual storeId
                  },
                ),
                const SizedBox(height: 16),
                if (state.isSearching) 
                  const Center(child: CircularProgressIndicator())
                else if (state.isNewCustomer) ...[
                  const Text('Khách hàng chưa có trong hệ thống.', style: TextStyle(color: Colors.orange)),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _nameController,
                    labelText: 'Tên khách hàng',
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: () {
                      _handleSave(context, state);
                    },
                  ),
                ] else if (state.customer != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.customer!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(state.customer!.phone, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
              ElevatedButton(
                onPressed: state.isLoading ? null : () {
                  if (state.isNewCustomer) {
                    _handleSave(context, state);
                  } else if (state.customer != null) {
                    Navigator.of(context).pop(state.customer);
                  } else {
                    context.read<CustomerSelectionCubit>().searchCustomer(1, _phoneController.text);
                  }
                },
                child: Text(state.isNewCustomer ? 'Lưu & Chọn' : (state.customer != null ? 'Chọn Khách' : 'Tìm Kiếm')),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleSave(BuildContext context, CustomerSelectionState state) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tên khách hàng'), backgroundColor: Colors.red),
      );
      return;
    }
    context.read<CustomerSelectionCubit>().createCustomer(
      1, // TODO: Replace with actual storeId
      state.searchedPhone,
      _nameController.text.trim(),
    );
  }
}
