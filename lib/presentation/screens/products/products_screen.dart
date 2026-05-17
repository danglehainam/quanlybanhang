import 'package:flutter/material.dart';

import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${AppLocalizations.of(context)!.menuProducts} Screen'),
    );
  }
}
