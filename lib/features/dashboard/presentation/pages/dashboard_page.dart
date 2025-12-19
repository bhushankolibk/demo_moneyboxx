import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/route_config/route_name.dart';
import 'package:moneybox_task/core/utils/utils.dart';
import 'package:moneybox_task/features/dashboard/presentation/widgets/stats_widget.dart';
import 'package:moneybox_task/features/drawer/drawer.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/dashboard_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    if (!mounted) return;
    context.read<DashboardBloc>().add(LoadDashboardData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is DashboardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading) {
          return Utils.dashboardLoader(label: "Loading Dashboard...");
        } else if (state is DashboardLoaded) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: AppDrawer(),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<DashboardBloc>().add(LoadDashboardData());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 24),
                      StatsWidget(state: state),

                      const SizedBox(height: 24),
                      _buildQuickActionsGrid(),
                      const SizedBox(height: 24),
                      Text(
                        "Recent Applications",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildRecentApplicationsList(),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is DashboardError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 10),
                  Text("Failed to load dashboard"),
                  TextButton(
                    onPressed: () =>
                        context.read<DashboardBloc>().add(LoadDashboardData()),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "MONEYBOXX",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0A2472),
              ),
            ),
            Text(
              "Welcome back, Loan Officer",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },

          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/300'),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: const Color(0xFF00D2D3), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid() {
    final actions = [
      {"icon": Icons.add_circle_outline, "label": "New Loan"},
      {"icon": Icons.person, "label": "Applicants"},
      {"icon": Icons.calculate_outlined, "label": "Calculator"},
      {"icon": Icons.bar_chart_rounded, "label": "Reports"},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((item) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => _handleActionTap(context, item),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: _buildActionButton(item),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _handleActionTap(BuildContext context, Map<String, dynamic> item) {
    final label = item['label'] as String;
    switch (label) {
      case 'New Loan':
        context.pushNamed(RouteName.newLoan);
        break;
      case 'Applicants':
        context.pushNamed(RouteName.applicantHistory);
        break;
      case 'Calculator':
        context.pushNamed(RouteName.loanCalculator);
        break;
      case 'Reports':
        Navigator.of(context).pushNamed('/reports');
        break;

      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label clicked')));
    }
  }

  Widget _buildActionButton(Map<String, dynamic> item) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F8),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            item["icon"] as IconData,
            color: const Color(0xFF0A2472),
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item["label"] as String,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentApplicationsList() {
    // Mock Data for UI presentation
    final recentApps = [
      {
        "name": "Solar Innovations",
        "amount": "₹15L",
        "status": "Approved",
        "date": "18 Dec 2023",
      },
      {
        "name": "Craft Exports",
        "amount": "₹8L",
        "status": "Pending",
        "date": "15 Dec 2023",
      },
      {
        "name": "Tech Solutions",
        "amount": "₹25L",
        "status": "Under Review",
        "date": "12 Dec 2023",
      },
    ];

    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentApps.length,
        itemBuilder: (context, index) {
          final app = recentApps[index];
          final statusColor = _getStatusColor(app['status'] as String);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 40,
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                app['name'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: const Color(0xFF0A2472),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                app['date'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              app['amount'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                app['status'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: statusColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF00C853);
      case 'Pending':
        return const Color(0xFFFFAB00);
      case 'Rejected':
        return const Color(0xFFD32F2F);
      default:
        return Colors.blue;
    }
  }
}
