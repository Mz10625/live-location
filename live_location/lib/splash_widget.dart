import 'package:flutter/material.dart';
import 'package:live_location/ActiveVehiclesScreen.dart';
import 'dart:async';

import 'package:live_location/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}
bool? isLoggedIn;

class _SplashWidgetState extends State<SplashWidget> {

  Future<void> loggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  void initState() {
    super.initState();
    loggedIn();

    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => isLoggedIn! ? const ActiveVehiclesScreen() :const Login(),
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 201,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/icon1.png')
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: RichText(
                        textScaler: MediaQuery.of(context).textScaler,
                        text:const TextSpan(
                          children: [
                            TextSpan(
                              text: 'App',
                              style: TextStyle( fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black87,),
                            ),
                            TextSpan(
                              text: 'Name',
                              style: TextStyle( fontSize: 30,fontWeight: FontWeight.bold,color: Color.fromARGB(
                                  255, 188, 60, 51)),
                            )
                          ],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
