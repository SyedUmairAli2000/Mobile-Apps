import 'dart:io';

import 'package:CovidApp/app/respositories/data_repository.dart';
import 'package:CovidApp/app/respositories/endpoint_data.dart';
import 'package:CovidApp/app/services/api.dart';
import 'package:CovidApp/app/ui/cards.dart';
import 'package:CovidApp/app/ui/show_dialog.dart';
import 'package:CovidApp/app/ui/updated_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection error',
          content: 'Could not connect to the server. Please try again.',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unknwon error',
          content: 'Please contact the developers or try again later.',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases].date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19-App'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(children: <Widget>[
          LastUpdatedStatusText(text: formatter.lastUpdatedStatusText()),
          for (var endpoint in Endpoint.values)
            EndpointCards(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint].value
                    : null),
        ]),
      ),
    );
  }
}
