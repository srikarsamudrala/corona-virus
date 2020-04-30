import 'package:coronavirus/CountryReportPage.dart';
import 'package:coronavirus/countriesPage.dart';
import 'package:coronavirus/homePage.dart';
import 'package:coronavirus/preventionPage.dart';
import 'package:coronavirus/reportPage.dart';
import 'package:coronavirus/symptomsPage.dart';
import 'package:coronavirus/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coronavirus/login_page.dart';
import 'package:coronavirus/theme.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPage(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: ScrollBehaviors(),
          child: child,
        );
      },
      title: 'Covid Updates',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 0, 200, 1),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        '/reports': (context) => ReportPage(),
        '/symptoms': (context) => SymptomsPage(),
        '/prevention': (context) => PreventioPage(),
        '/countries': (context) => Countriespage(),
        '/countryReport': (context) => CountryReportPage(),
      },
    );
  }
}
