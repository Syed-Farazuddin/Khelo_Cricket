import 'package:crick_hub/core/toaster/toaster.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => Dio());

final baseServiceProvider = Provider<BaseService>((ref) {
  final dio = ref.watch(dioProvider);
  return BaseService(dio: dio);
});

class BaseService {
  BaseService({required this.dio}) {
    dio
      ..options.baseUrl = dotenv.env['BASE_URL']!
      ..options.connectTimeout = const Duration(minutes: 10)
      ..options.receiveTimeout = const Duration(minutes: 10);
    // ..interceptors.add();
  }
  final Dio dio;

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onRecieveProgress,
  }) async {
    try {
      final response = await dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onRecieveProgress,
      );
      return response;
    } catch (e) {
      debugPrint("get Method Error $e");
      final DioException exception = e as DioException;
      final response = exception.response?.data;
      Toaster.onError(message: response['message']);
      rethrow;
    }
  }

  Future<Response> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onRecieveProgress,
    dynamic body,
  }) async {
    try {
      final response = await dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onRecieveProgress,
      );
      return response;
    } catch (e) {
      debugPrint("get Method Error $e");
      final DioException exception = e as DioException;
      final response = exception.response?.data;
      Toaster.onError(message: response['message']);
      rethrow;
    }
  }

  Future<Response> put(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onRecieveProgress,
    dynamic body,
  }) async {
    try {
      final response = await dio.put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onRecieveProgress,
      );
      return response;
    } catch (e) {
      debugPrint("get Method Error $e");
      final DioException exception = e as DioException;
      final response = exception.response?.data;
      Toaster.onError(message: response['message']);
      rethrow;
    }
  }

  Future<Response> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onRecieveProgress,
  }) async {
    try {
      final response = await dio.delete(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } catch (e) {
      debugPrint("get Method Error $e");
      final DioException exception = e as DioException;
      final response = exception.response?.data;
      Toaster.onError(message: response['message']);
      rethrow;
    }
  }
}
