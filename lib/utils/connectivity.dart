import 'package:connectivity_wrapper/connectivity_wrapper.dart';

Future<bool> isNetworkAvailable () async {
  bool isConnected = await ConnectivityWrapper.instance.isConnected;
  return isConnected;
}