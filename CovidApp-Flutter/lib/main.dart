import 'package:CovidApp/app/respositories/data_repository.dart';
import 'package:CovidApp/app/services/api.dart';
import 'package:CovidApp/app/services/api_service.dart';
import 'package:CovidApp/app/ui/dashborad.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(API.sandbox()),
      ),
      child: MaterialApp(
        title: 'Covid19-App',
        theme: ThemeData.dark(),
        home: Dashboard(),
      ),
    );
  }
}
