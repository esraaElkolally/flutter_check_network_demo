import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'connectivity_service.dart';

class ConnectionStatus extends StatefulWidget {
  @override
  _ConnectionStatusState createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  bool networkStatus;
  bool isConnectToNetwork = false;

//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("build");

    checkConnectionAutomatic();
    showAlertConnection();

    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
                child: Container(
              child: Text(
                  "is connect to network :" + isConnectToNetwork.toString()),
            )),
            new RaisedButton(
              child: new Text("Click  to check "),
              onPressed: () {
                checkIsNetworkConnected();
              },
            ),
          ],
        ),
      )),
    );
  }

  void showSnack(String msg) async {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void showAlertConnection() {
    print("teeeee" + isConnectToNetwork.toString() + "");
    if (isConnectToNetwork != null) {
      if (!isConnectToNetwork) {
        showSnack(isConnectToNetwork.toString());
      }
    }
  }

  void checkConnectionAutomatic() async {
    isConnectToNetwork = ConnectivityService()
        .getConnectionValue(Connectivity().checkConnectivity());
    var connectionResult = Provider.of<ConnectivityResult>(context);
    bool isConnect = ConnectivityService().getConnectionValue(connectionResult);
    setState(() {
      isConnectToNetwork = isConnect;
    });
  }

  void checkIsNetworkConnected() async {
    Connectivity connectivity = new Connectivity();
    var resultValue = await connectivity.checkConnectivity();
    bool isConnect = ConnectivityService().getConnectionValue(resultValue);
    if (isConnect) {
      sleep(Duration(seconds:5));
      getData();
    }else{
      print("You are not connected to internet");

    }
    // check poor connect
    bool x = await ConnectivityService().checkConnection();
    print(x.toString() + "teeest");

//    setState(() {
//      networkStatus = isConnect;
//    });
//    print("networkStatus" + networkStatus.toString());
  }

  @override
  void dispose() {
    super.dispose();
    ConnectivityService().connectionStreamController.close();
  }

  Future<String> getData() async {
    try{
      http.Response response = await http.get(
          Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
          headers: {"Accept": "application/json"});
      List data = json.decode(response.body);
      print(data[1]);
    }catch(_){
      print("You are not connected to internet");

    }

  }
}
