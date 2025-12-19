import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moneybox_task/core/di/dependency_container.dart';
import 'package:moneybox_task/core/route_config/route_name.dart';
import 'package:moneybox_task/features/applicant_history/presentation/pages/application_detail_page.dart';
import 'package:moneybox_task/features/applicant_history/presentation/pages/applications_history_page.dart';
import 'package:moneybox_task/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:moneybox_task/features/onboarding/presentation/splash_screen.dart';
import 'package:moneybox_task/features/onboarding/presentation/verify_otp_screen.dart';
import 'package:moneybox_task/features/add_applicant/presentation/bloc/add_applicant_bloc.dart';
import 'package:moneybox_task/features/add_applicant/presentation/pages/new_loan_applicant_page.dart';

import '../../features/applicant_history/domain/entities/applicant_history_entity.dart';
import '../../features/applicant_history/presentation/bloc/applicant_history_bloc.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/onboarding/presentation/login_page.dart';

class AppRoute {
  AppRoute._();

  static GoRouter route = GoRouter(
    initialLocation: RouteName.initial,
    routes: [
      GoRoute(
        path: RouteName.initial,
        builder: (context, state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: RouteName.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: RouteName.otp,
        name: RouteName.otp,
        builder: (context, state) {
          final phoneNumber = state.uri.queryParameters['phone'];

          return OtpVerificationPage(phoneNumber: phoneNumber ?? "");
        },
      ),

      GoRoute(
        path: RouteName.dashboard,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => DashboardBloc(getDashboardStats: sl()),
            child: const DashboardPage(),
          );
        },
      ),

      GoRoute(
        path: RouteName.newLoan,
        name: RouteName.newLoan,
        builder: (context, state) {
          return BlocProvider(
            create: (context) =>
                AddApplicationBloc(saveDraft: sl(), getLastDraft: sl()),
            child: NewLoanApplicationPage(),
          );
        },
      ),

      GoRoute(
        path: RouteName.applicantHistory,
        name: RouteName.applicantHistory,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ApplicantHistoryBloc(getAllApplications: sl()),
            child: const ApplicationHistoryPage(),
          );
        },
      ),

      GoRoute(
        path: RouteName.applicationDetail,
        name: RouteName.applicationDetail,
        builder: (context, state) {
          final application = state.extra as ApplicationHistoryEntity;

          return ApplicationDetailsPage(application: application);
        },
      ),
    ],
  );
}
