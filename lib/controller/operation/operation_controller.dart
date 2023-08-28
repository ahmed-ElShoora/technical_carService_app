
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../const.dart';


class OperationController extends GetxController{
  @override

  var token = ''.obs;
  late Position cl;
  void onInit() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // prefs.then(
    //         (pref)
    //     {
    //       token.value = pref.getString('token')!;
    //     }
    // );
    super.onInit();
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

  getDataUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/get-data-tec');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    return jsonDecode(response_data.body);
  }

  getDataPage(num) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/data-home-tec');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    switch(num){
      case 1:
        return jsonDecode(response_data.body)['data']['waiting'];
      case 2:
        return jsonDecode(response_data.body)['data']['containe'];
      case 3:
        return jsonDecode(response_data.body)['data']['complete'];
      case 4:
        return jsonDecode(response_data.body)['data']['cancelled'];
    }
  }

}