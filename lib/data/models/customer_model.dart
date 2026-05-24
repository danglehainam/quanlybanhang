import '../../domain/entities/customer_entity.dart';
import '../datasources/local/app_database.dart';

class CustomerModel {
  CustomerModel._();

  static CustomerEntity fromEntity(CustomerEntity entity) {
    return entity;
  }

  static CustomerEntity toEntity(Customer customer) {
    return CustomerEntity(
      id: customer.id,
      storeId: customer.storeId,
      name: customer.name,
      phone: customer.phone,
      createdAt: DateTime.fromMillisecondsSinceEpoch(customer.createdAt, isUtc: true),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(customer.updatedAt, isUtc: true),
    );
  }

  static CustomersCompanion toCompanion(CustomerEntity entity) {
    return CustomersCompanion.insert(
      storeId: entity.storeId,
      name: entity.name,
      phone: entity.phone,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
    );
  }
}
