import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/route_config/route_name.dart';
import 'package:moneybox_task/core/theme/app_colors.dart';
import 'package:moneybox_task/features/applicant_history/domain/entities/applicant_history_entity.dart';
import 'package:moneybox_task/features/applicant_history/presentation/bloc/applicant_history_bloc.dart';
// Import your Wizard Page and Entity for navigation
import '../../../../core/utils/utils.dart';
import '../widgets/applications_card.dart';

class ApplicationHistoryPage extends StatefulWidget {
  const ApplicationHistoryPage({super.key});

  @override
  State<ApplicationHistoryPage> createState() => _ApplicationHistoryPageState();
}

class _ApplicationHistoryPageState extends State<ApplicationHistoryPage> {
  @override
  void initState() {
    context.read<ApplicantHistoryBloc>().add(LoadHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MONEYBOXX",
          style: TextStyle(
            color: const Color(0xFF0A2472),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterChips(context),
          Expanded(
            child: BlocBuilder<ApplicantHistoryBloc, ApplicantHistoryState>(
              builder: (context, state) {
                if (state is HistoryLoading) {
                  return Utils.dashboardLoader(label: "Loading History...");
                } else if (state is HistoryError) {
                  return Center(child: Text(state.message));
                } else if (state is HistoryLoaded) {
                  if (state.filteredApplications.isEmpty) {
                    return const Center(child: Text("No applications found"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async =>
                        context.read<ApplicantHistoryBloc>().add(LoadHistory()),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.filteredApplications.length,
                      itemBuilder: (context, index) {
                        final app = state.filteredApplications[index];

                        final canSwipe =
                            !app.isLocalDraft &&
                            (app.status.toLowerCase() == 'pending' ||
                                app.status.toLowerCase() == 'under_review');

                        if (!canSwipe) {
                          return ApplicationCard(
                            app: app,
                            onTap: () => _handleCardTap(context, app),
                          );
                        }

                        return Dismissible(
                          key: Key(app.id),
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.background,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Approve",
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 2. Swipe Left -> Reject (Red)
                          secondaryBackground: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: AppColors.background,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.cancel_outlined,
                                  color: AppColors.background,
                                ),
                              ],
                            ),
                          ),
                          // 3. Confirmation Dialog
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              // Swiped Right -> Approve
                              return await Utils.showConfirmationDialog(
                                context,
                                title: "Approve Application?",
                                content:
                                    "Are you sure you want to approve ${app.businessName}?",
                                confirmText: "Approve",
                                confirmColor: AppColors.success,
                              );
                            } else {
                              return await Utils.showConfirmationDialog(
                                context,
                                title: "Reject Application?",
                                content:
                                    "Are you sure you want to reject ${app.businessName}?",
                                confirmText: "Reject",
                                confirmColor: AppColors.error,
                              );
                            }
                          },
                          onDismissed: (direction) {
                            Utils.showSnackBar(
                              direction == DismissDirection.startToEnd
                                  ? "Application Approved"
                                  : "Application Rejected",
                              context,
                              backgroundColor:
                                  direction == DismissDirection.startToEnd
                                  ? AppColors.success
                                  : AppColors.error,
                            );
                          },
                          child: ApplicationCard(
                            app: app,
                            onTap: () => _handleCardTap(context, app),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleCardTap(BuildContext context, ApplicationHistoryEntity app) {
    context.pushNamed(RouteName.applicationDetail, extra: app);
  }

  Widget _buildFilterChips(BuildContext context) {
    final filters = ["All", "Draft", "Approved", "Pending", "Rejected"];
    return BlocBuilder<ApplicantHistoryBloc, ApplicantHistoryState>(
      builder: (context, state) {
        String active = 'All';
        if (state is HistoryLoaded) active = state.activeFilter;

        return SizedBox(
          height: 60,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final filter = filters[index];
              final isActive = active == filter;
              return ChoiceChip(
                label: Text(filter),
                selected: isActive,
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.background,
                labelStyle: TextStyle(
                  color: isActive
                      ? AppColors.background
                      : AppColors.textPrimary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isActive ? Colors.transparent : Colors.grey[300]!,
                  ),
                ),
                onSelected: (_) {
                  context.read<ApplicantHistoryBloc>().add(
                    FilterHistory(filter),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
