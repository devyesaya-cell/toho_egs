import 'package:flutter/material.dart';
import '../../../core/models/workfile.dart';

class WorkfileCard extends StatelessWidget {
  final WorkFile workfile;
  final VoidCallback? onTap;

  const WorkfileCard({Key? key, required this.workfile, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Progress calculation
    final total = workfile.totalSpot ?? 0;
    final done = workfile.spotDone ?? 0;
    final progress = total > 0 ? done / total : 0.0;
    final spacing = '${workfile.panjang}x${workfile.lebar}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      workfile.areaName ?? 'Unknown Area',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: workfile.status == 'Done'
                          ? Colors.green.withOpacity(0.1)
                          : Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      workfile.status ?? 'Open',
                      style: TextStyle(
                        color: workfile.status == 'Done'
                            ? Colors.green
                            : Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Contractor: ${workfile.contractor ?? '-'}',
                style: const TextStyle(fontSize: 12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Spacing: $spacing',
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Area: ${workfile.luasArea?.toStringAsFixed(2) ?? '0'} Ha',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Progress', style: TextStyle(fontSize: 11)),
                      Text(
                        '${(progress * 100).toStringAsFixed(1)}% ($done/$total)',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progress >= 1.0 ? Colors.green : Colors.blue,
                    ),
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
