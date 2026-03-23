import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/coms/com_service.dart';
import '../../../../core/models/error_alert.dart';
import '../../../../core/utils/app_theme.dart';

class AlertDebugTab extends ConsumerWidget {
  const AlertDebugTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.of(context);
    final alertList = ref.watch(errorProvider);

    if (alertList.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: theme.textSecondary.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'No active alerts received.',
              style: TextStyle(
                color: theme.textSecondary,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.cardBorderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table Header
            _buildTableHeader(theme),
            // Table Body
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: ListView.separated(
                  itemCount: alertList.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: theme.dividerColor),
                  itemBuilder: (context, index) {
                    return _buildTableRow(theme, alertList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader(AppThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: theme.appBarAccent.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 3, child: _headerText('DATE / TIME', theme)),
          Expanded(flex: 2, child: _headerText('SOURCE', theme)),
          Expanded(flex: 2, child: _headerText('TYPE', theme)),
          Expanded(flex: 5, child: _headerText('MESSAGE', theme)),
        ],
      ),
    );
  }

  Widget _headerText(String text, AppThemeData theme) {
    return Text(
      text,
      style: TextStyle(
        color: theme.appBarAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildTableRow(AppThemeData theme, ErrorAlert alert) {
    final timeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.transparent,
      child: Row(
        children: [
          // Datetime
          Expanded(
            flex: 3,
            child: Text(
              timeFormat.format(alert.timestamp),
              style: TextStyle(
                color: theme.textSecondary,
                fontSize: 13,
                fontFamily: 'monospace',
              ),
            ),
          ),
          // Source
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getSourceColor(alert.sourceID).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  alert.sourceID.toUpperCase(),
                  style: TextStyle(
                    color: _getSourceColor(alert.sourceID),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ),
          // Type
          Expanded(
            flex: 2,
            child: Text(
              alert.alertType,
              style: TextStyle(
                color: theme.textOnSurface,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          // Message
          Expanded(
            flex: 5,
            child: Text(
              alert.message,
              style: TextStyle(
                color: theme.textOnSurface,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSourceColor(String source) {
    switch (source.toLowerCase()) {
      case 'rover':
        return const Color(0xFF3498DB);
      case 'tablet pair':
        return const Color(0xFF9B59B6);
      case 'boom':
        return const Color(0xFFE67E22);
      case 'stick':
        return const Color(0xFF1ABC9C);
      case 'bucket':
        return const Color(0xFFE74C3C);
      default:
        return const Color(0xFFBDC3C7);
    }
  }
}
