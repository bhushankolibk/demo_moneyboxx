import 'package:flutter/material.dart';

import '../../domain/entities/applicant_history_entity.dart';

class TimelineSectionWidget extends StatelessWidget {
  final ApplicationHistoryEntity app;

  const TimelineSectionWidget({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return _buildTimelineSection(app);
  }

  Widget _buildTimelineSection(ApplicationHistoryEntity app) {
    final steps = ["Pending", "Under Review", "Approved", "Disbursed"];
    int currentStepIndex = 0;

    final status = app.status.toLowerCase();
    if (status.contains('pending')) {
      currentStepIndex = 1;
    } else if (status.contains('review')) {
      currentStepIndex = 2;
    } else if (status.contains('approved')) {
      currentStepIndex = 3;
    } else if (status.contains('disbursed')) {
      currentStepIndex = 4;
    } else if (status.contains('rejected')) {
      currentStepIndex = -1; // Special case
    }

    if (currentStepIndex == -1) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(Icons.cancel, color: Colors.red),
            SizedBox(width: 12),
            Text(
              "Application Rejected",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Application Status",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            children: List.generate(steps.length, (index) {
              final isCompleted = index < currentStepIndex;
              final isCurrent = index == currentStepIndex - 1;

              return Expanded(
                child: Column(
                  children: [
                    // Line + Circle
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index == 0
                                ? Colors.transparent
                                : (isCompleted || isCurrent
                                      ? Colors.green
                                      : Colors.grey[300]),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          width: isCurrent ? 24 : 16,
                          height: isCurrent ? 24 : 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted || isCurrent
                                ? Colors.green
                                : Colors.grey[300],
                            border: isCurrent
                                ? Border.all(
                                    color: Colors.green.shade100,
                                    width: 4,
                                  )
                                : null,
                          ),
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index == steps.length - 1
                                ? Colors.transparent
                                : (index + 1 < currentStepIndex
                                      ? Colors.green
                                      : Colors.grey[300]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: isCompleted || isCurrent
                            ? Colors.black87
                            : Colors.grey,
                        fontWeight: isCompleted || isCurrent
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
