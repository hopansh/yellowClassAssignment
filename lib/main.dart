import 'package:binged_movies/Screens/addMovie.dart';
import 'package:binged_movies/Screens/detailedView.dart';
import 'package:binged_movies/Screens/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Binged Movies',
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepOrange,
            primaryColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
            canvasColor: Color(0xff1D1D28),
            splashColor: Colors.deepOrangeAccent,
            iconTheme: IconThemeData(color: Colors.white),
            primaryTextTheme: TextTheme(
                headline6: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
        initialRoute: "/",
        routes: {
          '/': (context) => Index(),
          '/add': (context) => AddMovie(),
          '/view': (context) => DetailedView(),
        });
  }
}
