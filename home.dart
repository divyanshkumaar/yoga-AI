import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';


import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_tts/flutter_tts.dart';

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/config.json');
}


  @override
  Widget build(BuildContext context) {
    FlutterTts flutterTts = new FlutterTts();
    flutterTts.speak("Welcome Back Divyansh. Are you ready for your session?");
    return Scaffold(
        backgroundColor: Color(0xff7F84BE),
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text(
                "Current level: 0/10",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: "Arial"),
              ),
              Image.asset(
                'assets/lola.gif',
              ),
              Text(
                "Welcome back, Divyansh.",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                    fontFamily: "Arial"),
              ),
              ButtonTheme(
                  minWidth: 180.0,
                  height: 50.0,
                  child: RaisedButton(
                      child: const Text("Begin"),
                      color: Colors.deepPurpleAccent,
                      onPressed: () => onSelect(posenet))),
              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,
                child: RaisedButton(
                    child: const Text("Enroll"),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      //I integrated 2 text to speech engines
                      FlutterTts flutterTts = new FlutterTts();
                      flutterTts.speak("Hello");
                      });
                      showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                              backgroundColor: Color(0xff7F84BE),
                              title: new Text("Monthly Fee: 100 USD"),
                              content: new Container(
                                  width: 300.0,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/lola.gif',
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'Card #'),
                                        ),
                                        TextFormField(
                                          decoration:
                                              InputDecoration(labelText: 'CVC'),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'MM/YY'),
                                        ),
                                        RaisedButton(
                                            child: const Text("Enroll"),
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            })
                                      ]))));
                      //  Navigator.pop(context);
                    }),
              ),
            ])));
  }
}

class SecondRoute extends StatelessWidget {
  @override

  // firebase login/signup code
  _validateAndSubmit() async {
    setState(() {
       _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
        }
        if (userId.length > 0 && userId != null) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff7F84BE),
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/lola.gif',
              ),
              new Container(
                width: 300.0,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                ),
              ),
              new Container(
                width: 300.0,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,
                child: RaisedButton(
                    child: const Text("Sign up"),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              SizedBox(height: 10),
              ButtonTheme(
                minWidth: 180.0,
                height: 50.0,
                child: RaisedButton(
                    child: const Text("Go Back"),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
            ]),
      ),
    );
  }
}


}
