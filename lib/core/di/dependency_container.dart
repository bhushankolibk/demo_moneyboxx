import 'package:get_it/get_it.dart';
import 'package:moneybox_task/core/network/api_service.dart';
import 'package:moneybox_task/features/applicant_history/data/datasources/remote/applications_remote_data_source.dart';
import 'package:moneybox_task/features/applicant_history/data/repositories/applications_repository_impl.dart';
import 'package:moneybox_task/features/applicant_history/domain/repositories/applications_repository.dart';
import 'package:moneybox_task/features/applicant_history/domain/usecases/get_all_applications.dart';
import 'package:moneybox_task/features/applicant_history/presentation/bloc/applicant_history_bloc.dart';

import 'package:moneybox_task/features/dashboard/data/repositories/dashboard_stats_repository_impl.dart';
import 'package:moneybox_task/features/dashboard/domain/repositories/dasboard_stats_repository.dart';
import 'package:moneybox_task/features/dashboard/domain/usecases/get_dashboard_stats.dart';
import 'package:moneybox_task/features/add_applicant/data/datasources/local/add_applicant_local_datasource.dart';
import 'package:moneybox_task/features/add_applicant/data/datasources/local/add_applicant_local_datasource_impl.dart';
import 'package:moneybox_task/features/add_applicant/data/repositories/add_applicant_repository_impl.dart';
import 'package:moneybox_task/features/add_applicant/domain/repositories/add_applicant_repository.dart';
import 'package:moneybox_task/features/add_applicant/domain/usecases/add_applicant_usecase.dart';
import 'package:moneybox_task/features/add_applicant/domain/usecases/get_last_draft.dart';
import 'package:moneybox_task/features/add_applicant/presentation/bloc/add_applicant_bloc.dart';

import '../../features/applicant_history/data/datasources/remote/applications_remote_data_souce_impl.dart';
import '../../features/dashboard/data/datasources/remote/dasboard_stats_datasource.dart';
import '../../features/dashboard/data/datasources/remote/dashboard_stats_datasource_impl.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/add_applicant/domain/usecases/save_draft.dart';
import '../network/dio_client.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  sl.registerFactory<AddApplicationBloc>(
    () => AddApplicationBloc(saveDraft: sl(), getLastDraft: sl()),
  );

  sl.registerLazySingleton<AddApplicantLocalDatasource>(
    () => AddApplicantLocalDatasourceImpl(),
  );

  sl.registerLazySingleton<AddApplicantRepository>(
    () => AddApplicantRepositoryImpl(userLocalDatasource: sl()),
  );

  sl.registerLazySingleton<AddUserUsecase>(
    () => AddUserUsecase(repository: sl()),
  );

  sl.registerLazySingleton<GetLastDraft>(() => GetLastDraft(repository: sl()));

  sl.registerLazySingleton(() => SaveDraft(repository: sl()));

  sl.registerFactory(() => DashboardBloc(getDashboardStats: sl()));

  sl.registerLazySingleton(() => GetDashboardStats(sl()));

  sl.registerLazySingleton<DashboardStatsRepository>(
    () => DashboardStatsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<ApiService>(() => ApiService(sl<DioClient>().dio));

  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerFactory(() => ApplicantHistoryBloc(getAllApplications: sl()));

  sl.registerLazySingleton(() => GetAllApplications(sl()));

  sl.registerLazySingleton<ApplicationsRepository>(
    () => ApplicationsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<ApplicationsRemoteDataSource>(
    () => ApplicationsRemoteDataSourceImpl(apiService: sl()),
  );
}
