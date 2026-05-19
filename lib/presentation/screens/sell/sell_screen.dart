import 'package:flutter/material.dart';
import 'package:quan_ly_ban_hang/l10n/app_localizations.dart';

import '../../widgets/empty_data_widget.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Center(
      child: EmptyDataWidget(
        icon: Icons.point_of_sale,
        message: 'Màn hình ${l10n.btnSell} đang được xây dựng.',
      ),
    );
  }
}
