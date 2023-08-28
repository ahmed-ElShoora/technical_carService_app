
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnical/view/screens/home/home_screen.dart';

import '../../const.dart';


class AddingController extends GetxController{
  @override
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  List<XFile>? images = [];
  List<dynamic>? tMa = [];
  List<dynamic>? pMa = [];
  List<dynamic>? tPr = [];
  List<dynamic>? pPr = [];
  late dynamic day_work;
  int total_price = 0;

  var token = ''.obs;
  RxList MController = [TextEditingController(),].obs;
  RxList PController = [].obs;
  RxBool on = false.obs;
  void toggle(){
    if(on.value){
      on.value = false;
      PController.value.clear();
    }else{
      PController.value.add(
        TextEditingController(),
      );
      on.value = true;
    }
  }

  void selectMultipleImage() async{
    images = await _picker.pickMultiImage();
  }

  Future pushData(id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token')!;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final url_man=Uri.parse('https://cars-ksa.tech/api/add-invoice-order-1');
      final url_pro=Uri.parse('https://cars-ksa.tech/api/add-invoice-order-2');
      if(images != null) {
        for (var img = 0; img < images!.length; img++) {
          var headers = {
            'api_password': api_password,
            'auth_token': token.value.toString(),
            'id': id.toString(),
          };
          var request = http.MultipartRequest('POST', Uri.parse('https://cars-ksa.tech/api/add-invoice-order-3'));
          request.files.add(await http.MultipartFile.fromPath('image',images![img].path));
          request.headers.addAll(headers);

          http.StreamedResponse response_image = await request.send();
        }
      }
      for(var man = 0; man < tMa!.length;man++){

        http.Response response_man = await http.post(url_man,headers: {
          'api_password': api_password,
          'auth_token': token.value.toString()
        },body: {
          'id':id.toString(),
          'name':tMa![man].toString(),
          'price': pMa![man].toString()
        });
        total_price += int.parse(pMa![man]);
      }
      if(tPr != null) {
        for (var prod = 0; prod < tPr!.length; prod++) {
          http.Response response_pro = await http.post(url_pro, headers: {
            'api_password': api_password,
            'auth_token': token.value.toString()
          }, body: {
            'id': id.toString(),
            'name': tPr![prod].toString(),
            'price': pPr![prod].toString()
          });
          total_price += int.parse(pPr![prod]);
        }
      }
      final url=Uri.parse('https://cars-ksa.tech/api/add-invoice-order');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password,
        'auth_token': token.value.toString()
      },body: {
        'id':id.toString(),
        'day_work':day_work.toString(),
        'total_price': total_price.toString()
      });
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          Get.offAll(HomeScreen());
        }else{
          images?.clear();
          tMa?.clear();
          pMa?.clear();
          tPr?.clear();
          pPr?.clear();
        }
      }else{
        images?.clear();
        tMa?.clear();
        pMa?.clear();
        tPr?.clear();
        pPr?.clear();
      }
    }
  }
}