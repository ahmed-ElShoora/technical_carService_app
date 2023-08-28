
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnical/view/screens/home/home_screen.dart';

import '../../const.dart';


class ArriveMapController extends GetxController{
  @override
  var token = ''.obs;
  Completer<GoogleMapController> googleMapController = Completer();
  List<LatLng> polylineCoordinates = [];
  Future getPolylines(lat,lng,lating, lnging) async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyAppLGSB3pKXVHg5sbSjlpo6gDjpc8lllE',
      PointLatLng(lating, lnging),
      PointLatLng(lat, lng),
    );
    if(result.points.isNotEmpty){
      result.points.forEach((PointLatLng point) => polylineCoordinates.add(
        LatLng(point.latitude, point.longitude),
      ),);
    }
  }

  arrives(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/arrive-order-'+id);
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    Get.offAll(HomeScreen());
  }

  endOrder(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/end-order-'+id);
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    print(jsonDecode(response_data.body));
    Get.offAll(HomeScreen());
  }
}