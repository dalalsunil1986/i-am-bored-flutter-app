import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String apiURL = "https://www.boredapi.com/api/activity";

  Map boredActivity;
  bool isLoaded = false;

  @override
  void initState() {
    getBoredActivity();
    super.initState();
  }

  void getBoredActivity() async {
    setState(() {
      isLoaded = false;
    });
    var response = await http.get(apiURL);
    print(response.body);
    setState(() {
      boredActivity = jsonDecode(response.body);
      isLoaded = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded==true? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              boredActivity["activity"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30
              ),
            ),

            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                getBoredActivity();
              },
              child: Text(
                "Suggest me an another activity",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              color: Color(0xFF4f47de),
            ),
          ],
        ),
      ):Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}