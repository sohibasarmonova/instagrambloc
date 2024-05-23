import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngdemo17/bloc/splash/splash_bloc.dart';
import 'package:ngdemo17/bloc/splash/splash_event.dart';
import 'package:ngdemo17/bloc/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashBloc splashBloc;

  @override
  void initState() {
    super.initState();
    splashBloc = context.read<SplashBloc>();
    splashBloc.add(SplashWaitEvent());
    splashBloc.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state){
        if(state is SplashLoadedState){
          splashBloc.callNextPage(context);
        }
      },
      builder: (context, state){
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(193, 53, 132, 1),
                      Color.fromRGBO(131, 58, 180, 1),
                    ])),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Instagram",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontFamily: "Billabong"),
                    ),
                  ),
                ),
                Text(
                  "All rights reserved",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}