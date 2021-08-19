import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "../helpers/dbHelper.dart";
import 'package:image_picker/image_picker.dart';

class AddMovie extends StatefulWidget {
  var colId;
  AddMovie({this.colId = -1});

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  final _formKey = new GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {'_id': null, 'title': '', 'director': ''};

  var _image;

  final ImagePicker _picker = ImagePicker();
  void _choose() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      setState(() {
        _image = pickedFile.path;
      });
    } catch (e) {}
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final colId = ModalRoute.of(context).settings.arguments;
      if (colId != null) {
        final res = await dbHelper.getMovie(colId);
        _titleController.text = res[0]['title'].toString();
        _directorController.text = res[0]['director'].toString();
        setState(() {
          _image = res[0]['poster'];
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final dbHelper = DbHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _submit() async {
      final form = _formKey.currentState;
      final colId = ModalRoute.of(context).settings.arguments;
      if (form.validate() && _image != null) {
        form.save();
        print('form is valid');
        //Insert
        Map<String, dynamic> row = {
          DbHelper.colTitle: _initValues['title'],
          DbHelper.colDirector: _initValues['director'],
          DbHelper.colId: colId,
          DbHelper.colPoster: _image
        };
        var type;
        print(_initValues);
        if (colId != null) {
          final id = await dbHelper.update(row);
          type = "Edited";
        } else {
          final id = await dbHelper.insert(row);
          type = "Added";
        }
        Navigator.of(context).pop(type);
      } else {
        _initValues['title'] = "";
        _initValues['director'] = "";
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                size: 40,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Add Movie",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Flexible(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              autofocus: true,
                              controller: _titleController,
                              validator: (input) => input.trim().isEmpty
                                  ? "Please enter Movie Name"
                                  : null,
                              onSaved: (value) {
                                _initValues = {
                                  "title": value,
                                  "director": _initValues['director'],
                                };
                              },
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "Movie Name",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              controller: _directorController,
                              validator: (input) => input.trim().isEmpty
                                  ? "Please enter Director's Name"
                                  : null,
                              onSaved: (value) {
                                _initValues = {
                                  "director": value,
                                  "title": _initValues['title'],
                                };
                              },
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                  labelText: "Director's Name",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  labelStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          _image != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.deepOrange)),
                                  margin: EdgeInsets.all(10),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(_image),
                                        height: 200,
                                        width: 120,
                                        fit: BoxFit.cover,
                                      ),
                                      InkWell(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _image = null;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                            size: 40,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.blueGrey,
                                  ),
                                  width: double.infinity,
                                  child: TextButton(
                                    child: Text("Upload Poster",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    onPressed: _choose,
                                  ),
                                ),
                          Text(
                            _image != null
                                ? "Poster Uploaded"
                                : "*Upload Movie Poster",
                            style: TextStyle(
                                color: _image != null
                                    ? Colors.green
                                    : Colors.deepOrange),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.deepOrange,
                            ),
                            width: double.infinity,
                            child: TextButton(
                              child: Text("    Add Movie    ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              onPressed: _submit,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
