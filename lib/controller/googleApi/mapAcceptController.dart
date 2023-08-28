
import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnical/view/screens/home/home_screen.dart';

import '../../const.dart';


class MapAcceptController extends GetxController{
  @override

  var token = ''.obs;
  // var lat;
  // var lng;
  //Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  late Position cl;
  // late double lat;
  // late double lng;
  void onInit() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       token.value = pref.getString('token')!;
    //     }
    // );
    //cl = await getPostion();
    // print(cl.latitude);
    // print(cl.longitude);
    super.onInit();
  }
  
  Future<dynamic> getDistbe(lat,lng) async{
    cl = await getPostion();
    //print(cl.latitude.toString()+' '+ cl.longitude.toString()+' '+ lat.toString()+' '+ lng.toString());
    double one_cal = await Geolocator.distanceBetween(cl.latitude, cl.longitude, lat, lng);
    double result = one_cal/1000;
    return result;
  }

  Future getPostion() async{
    bool services;
    LocationPermission permission;
    services = await Geolocator.isLocationServiceEnabled();
    if(services == false){
      Get.defaultDialog(title: 'خدمة تحديدالمواقع غير مفعله',middleText: '');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.defaultDialog(title: 'الصلاحيات اجبارية',middleText: '');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      Get.defaultDialog(title:'Location permissions are permanently denied, we cannot request permissions.',middleText: '');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition().then((value) => value);
  }



  Completer<GoogleMapController> googleMapController = Completer();

  decline(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/re-tec-one');
    http.Response response_data = await http.post(url,headers: {
    'api_password': api_password,
    'auth_token': token.value.toString()
    },body: {
      'id': id,
      'type': 'false'
    });
    Get.offAll(HomeScreen());
  }

  accept(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/re-tec-one');
    http.Response response_data = await http.post(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    },body: {
      'id': id,
      'type': 'true'
    });
    Get.offAll(HomeScreen());
  }

  dataPhoneClient(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/get-phone-client-'+id);
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    return jsonDecode(response_data.body)['data'];
  }
}