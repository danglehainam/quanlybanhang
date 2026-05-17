import 'package:flutter/material.dart';
import '../../../../domain/entities/category_entity.dart';

class CategoriesMobileView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesMobileView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          title: const Text('Bộ lọc & Tìm kiếm', style: TextStyle(fontWeight: FontWeight.bold)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: 'newest',
                    decoration: const InputDecoration(
                      labelText: 'Sắp xếp theo',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'newest', child: Text('Mới nhất')),
                      DropdownMenuItem(value: 'oldest', child: Text('Cũ nhất')),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm theo tên...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(category.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(category.description ?? ''),
                trailing: const Icon(Icons.more_vert),
                onTap: () {
                  // Bottom sheet for options
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
