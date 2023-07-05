

import 'package:flutter/material.dart';
import 'package:servicio_asistencia/login/login_google.dart';
import 'package:servicio_asistencia/theme/AppTheme.dart';

bool shouldUseFirestoreEmulator = false;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UPeU",
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: MainLogin(),
    );
  }
}