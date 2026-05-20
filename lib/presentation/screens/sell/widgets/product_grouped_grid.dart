import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/category_entity.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../bloc/sell/sell_bloc.dart';
import '../../../bloc/sell/sell_event.dart';
import 'pos_product_item.dart';

class ProductGroupedGrid extends StatelessWidget {
  final List<ProductEntity> products;
  final List<CategoryEntity> categories;
  final int crossAxisCount;
  final double childAspectRatio;
  final double bottomPadding;

  const ProductGroupedGrid({
    super.key,
    required this.products,
    required this.categories,
    this.crossAxisCount = 6,
    this.childAspectRatio = 0.85,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Prepare Category Map for quick lookup
    final categoryMap = {for (var c in categories) c.id: c};
    final unknownCategory = CategoryEntity(
      id: -1,
      storeId: -1,
      name: 'Khác',
      description: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // 2. Group Products
    final Map<CategoryEntity, List<ProductEntity>> grouped = {};
    for (var product in products) {
      final category = categoryMap[product.categoryId] ?? unknownCategory;
      if (!grouped.containsKey(category)) {
        grouped[category] = [];
      }
      grouped[category]!.add(product);
    }

    // 3. Sort Categories based on original order (or just by ID)
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) => a.key.id.compareTo(b.key.id));

    // 4. Render using CustomScrollView and Slivers for maximum performance
    return CustomScrollView(
      slivers: [
        ...sortedEntries.expand((entry) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12, left: 16, right: 16),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.key.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${entry.value.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = entry.value[index];
                    return PosProductItem(
                      product: product,
                      onTap: () {
                        context.read<SellBloc>().add(SellEvent.addProductToOrder(product));
                        
                        // Show snackbar on mobile
                        if (crossAxisCount < 6) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text('Đã thêm ${product.name}'),
                               duration: const Duration(milliseconds: 500),
                             ),
                           );
                        }
                      },
                    );
                  },
                  childCount: entry.value.length,
                ),
              ),
            ),
          ];
        }),
        // Add bottom padding sliver
        SliverPadding(padding: EdgeInsets.only(bottom: bottomPadding)),
      ],
    );
  }
}
