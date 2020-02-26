import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  StreamController<ConnectivityResult> connectionStreamController =
  StreamController<ConnectivityResult>();

  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = new StreamController.broadcast();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult data,) {
      // add connectivity changes  to stream
      connectionStreamController.add(data);

    }
    );
  }

  Future<bool> checkConnection() async {
    bool hasConnection = false;
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("hasConTRUE"+result.isNotEmpty.toString());
        hasConnection = true;
      } else {
        print("hasCon"+"");
        print("hasConFALSE"+result.isNotEmpty.toString());

        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
      print("hasCon"+"EXCEPTION");

    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
  bool getConnectionValue(connectionResult) {
    String status;
    bool isConnect;

    switch (connectionResult) {
      case ConnectivityResult.mobile:
        print("mobile");
        status = "mob";
        isConnect=true;
        break;
      case ConnectivityResult.wifi:
        print("wifi");
        status = "wifi";
        isConnect=true;
        break;
      case ConnectivityResult.none:
        print("none network");
        status = "none network";
        isConnect=false;
        break;
    }
    return isConnect;
  }

}
