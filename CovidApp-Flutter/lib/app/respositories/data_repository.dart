import 'package:CovidApp/app/respositories/endpoint_data.dart';
import 'package:CovidApp/app/services/api.dart';
import 'package:CovidApp/app/services/api_service.dart';
import 'package:CovidApp/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;
  String _accessToken;

  Future<EndpointData> getEndpointData(Endpoint endPoint) async =>
      await _getDataRefereshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken, endPoint: endPoint),
      );

  Future<EndpointsData> getAllEndpointsData() async =>
      await _getDataRefereshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefereshingToken<T>(
      {Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endPoint: Endpoint.recovered),
    ]);
    return EndpointsData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        Endpoint.deaths: values[3],
        Endpoint.recovered: values[1],
      },
    );
  }
}
