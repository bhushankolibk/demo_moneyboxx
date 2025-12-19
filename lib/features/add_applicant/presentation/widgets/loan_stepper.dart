import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LoanStepper extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const LoanStepper({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: List.generate(steps.length, (index) {
          // If it's not the last item, add a line after it
          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    _buildCircle(index),
                    const SizedBox(height: 8),
                    Text(
                      "${index + 1}. ${steps[index]}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: index <= currentStep
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: index <= currentStep
                            ? AppColors.primary
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
                if (index != steps.length - 1)
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        left: 4,
                        right: 4,
                      ),
                      height: 2,
                      color: index < currentStep
                          ? AppColors.primary
                          : Colors.grey[300],
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCircle(int index) {
    bool isActive = index == currentStep;
    bool isCompleted = index < currentStep;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive || isCompleted ? AppColors.primary : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive || isCompleted
              ? AppColors.primary
              : Colors.grey[300]!,
          width: 2,
        ),
      ),
      child: Center(
        child: isCompleted
            ? const Icon(Icons.check, color: Colors.white, size: 16)
            : Text(
                "${index + 1}",
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
