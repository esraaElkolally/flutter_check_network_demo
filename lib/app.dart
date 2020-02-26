import 'package:flutter/material.dart';
import 'package:network_demo/check_connection/check_connect.dart';
import 'package:provider/provider.dart';

import 'check_connection/connection_status.dart';
import 'check_connection/connectivity_service.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider.controller(
      create: (context) => ConnectivityService().connectionStreamController,
      child: MaterialApp(
        title: "Cat box",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.brown
        ),
//        home: new Scaffold(body: CheckConnect()),
        home: new Scaffold(body: ConnectionStatus()),
      ),
    );
  }

}
