import 'package:flutter/material.dart';
import '../../../../domain/entities/customer_table_entity.dart';

class CustomerTablesDesktopView extends StatelessWidget {
  final List<CustomerTableEntity> tables;

  const CustomerTablesDesktopView({super.key, required this.tables});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Giao diện quản lý Bàn (Desktop) - Sẽ triển khai sau'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
