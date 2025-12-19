import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://gist.githubusercontent.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl, ParseErrorLogger? errorLogger}) =
      _ApiService;

  @GET(
    "rishimalgwa/4d3d4d0e8e270f4ba8af64a3d4099e5c/raw/bd7d9bf50692d284500523ac97f46b93da97aa9f/gistfile1.txt",
  )
  Future<dynamic> getDashboardStats();

  @GET(
    "rishimalgwa/d8edc5edadb4e1e06cec67c8748c1939/raw/b266e383cbb321b02554180639f8e2f8e52b865a/gistfile1.txt",
  )
  Future<dynamic> getApplications();
}
