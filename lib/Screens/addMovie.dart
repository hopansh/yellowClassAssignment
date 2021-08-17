import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../helpers/dbHelper.dart";

class AddMovie extends StatefulWidget {
  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final _formKey = new GlobalKey<FormState>();
  String _title = "";
  String _director = "";
  // String _des = "";
  final dbHelper = DbHelper.instance;
  _submit() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('form is valid');

      //Insert
      Map<String, dynamic> row = {
        DbHelper.colTitle: _title,
        DbHelper.colDirector: _director
      };
      final id = await dbHelper.insert(row);
      print('inserted row id: $id');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Add Movie",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      validator: (input) => input.trim().isEmpty
                          ? "Please enter Movie Name"
                          : null,
                      onChanged: (input) => _title = input.toString(),
                      initialValue: _title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          labelText: "Movie Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      validator: (input) => input.trim().isEmpty
                          ? "Please enter Director's Name"
                          : null,
                      onChanged: (input) => _director = input.toString(),
                      initialValue: _director,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                          labelText: "Director's Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.deepOrange,
                    ),
                    width: double.infinity,
                    child: TextButton(
                      child: Text("   Add Movie   ",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                      onPressed: _submit,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
