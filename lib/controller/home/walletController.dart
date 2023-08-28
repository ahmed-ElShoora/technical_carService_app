
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnical/view/screens/intro/intro_screen.dart';

import '../../const.dart';
import '../../view/screens/home/home_screen.dart';

class WalletController extends GetxController{
  @override

  var token = ''.obs;
  void onInit() async{
    // Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    // await prefs.then(
    //         (pref)
    //     {
    //       token.value = pref.getString('token')!;
    //     }
    // );
    super.onInit();
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

  getDataShow() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    final url = Uri.parse('https://cars-ksa.tech/api/data-home-tec');
    http.Response response_data = await http.get(url,headers: {
      'api_password': api_password,
      'auth_token': token.value.toString()
    });
    return jsonDecode(response_data.body);
  }
}