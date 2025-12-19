# moneybox_task

A new Flutter project.

## Getting Started


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## About this app

moneybox_task is a Flutter sample app that demonstrates network integration and code generation for API clients using Retrofit (retrofit.dart) with Dio and JSON (json_serializable). It includes a generated API runner so HTTP clients and model serialization are generated at build time.

## Setup: dependencies

Add the following to your pubspec.yaml.

Dependencies:
- dio
- retrofit

Dev dependencies:
- build_runner
- retrofit_generator

Example (pubspec.yaml snippet)
```yaml
dependencies:
    flutter:
        sdk: flutter
    dio: any
    retrofit: any

dev_dependencies:
    build_runner: any
    retrofit_generator: any
```

(Use specific versions as appropriate for your project; `any` is shown for clarity.)

## Creating an API client (example)

1. Create an API interface file, e.g. lib/api/rest_client.dart:

```dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: "https://api.example.com/")
abstract class RestClient {
    factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

    @GET("/items")
    Future<List<Item>> getItems();

    @GET("/items/{id}")
    Future<Item> getItem(@Path("id") String id);
}
```


## Generate the runner and model code

Run code generation to produce the runner (generated implementation) and model serialization:

- One-time build:
    flutter pub run build_runner build --delete-conflicting-outputs

- Continuous watch during development:
    flutter pub run build_runner watch --delete-conflicting-outputs

This creates files like:
- lib/api/rest_client.g.dart

## Using the generated client

Initialize Dio and the generated client where needed:

```dart
final dio = Dio(); // configure interceptors/timeouts as needed
final client = RestClient(dio);

final items = await client.getItems();
```

## Tips and common issues

- Ensure `part 'file.g.dart';` matches filenames exactly.
- If you update annotations or models, re-run build_runner.
- Use `--delete-conflicting-outputs` when encountering generated file conflicts.
- For null-safety, use non-nullable types and `required` where appropriate.
- Configure Dio interceptors for logging, authentication, and error handling.

## Troubleshooting

- "Missing generated file" error: run build_runner and check that part declarations match.
- Conflicting-outputs error: add `--delete-conflicting-outputs`.
- Version mismatches: pin compatible versions for retrofit/dio/json_serializable if build fails.

That’s all you need to add Retrofit code generation (runner) and required setup for this Flutter project. Replace example baseUrl, endpoints, and models with your app-specific values.