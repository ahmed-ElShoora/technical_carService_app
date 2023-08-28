import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tecnical/const.dart';
import 'package:tecnical/model/Category.dart';
import 'package:tecnical/view/screens/auth/login_screen.dart';
import 'package:tecnical/view/screens/auth/signUp_screen.dart';

class SignUpController extends GetxController{
  @override
  Future getCategory() async{
    final url = Uri.parse('https://cars-ksa.tech/api/get-category');
    http.Response response_category = await http.get(url,headers: {
      'api_password': api_password
    });
    if(response_category.statusCode==200)
    {
      try{
        var endData = Category.fromJson(jsonDecode(response_category.body));
        return endData.data;
      }catch(e)
      {
        //Get.snackbar("error", e.toString());
      }
    }
  }
  void onInit(){
    super.onInit();
  }

  RxBool obscureText = true.obs;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController town = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController password = new TextEditingController();

  late String gender;
  late String expert;
  late dynamic category_id;

  signUpForm(context) async{
    if (formKey.currentState!.validate()) {
      final url=Uri.parse('https://cars-ksa.tech/api/signup-tec');
      http.Response response = await http.post(url,headers: {
        'api_password': api_password
      },body: {
        'category_id': category_id.toString(),
        'exeperince':expert.toString(),
        'gender':gender.toString(),
        'name':name.text.toString(),
        'email':email.text.toString(),
        'phone':phone.text.toString(),
        'password':password.text.toString(),
        'town':town.text.toString(),
        'age':age.text.toString()
      });
      //print('ok');
      //print(jsonDecode(response.body));
      if(response.statusCode==200)
      {
        if(jsonDecode(response.body)['status'] == true){
          return Alert(
            context: context,
            type: AlertType.success,
            title: "تم التسجيل بنجاح",
            desc: "سيتم مراجعة البيانات ثم السماح لك بتسجيل الدخول",
            buttons: [
              DialogButton(
                child: Text(
                  "حسنا",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () => Get.to(LoginScreen()),
                width: 120,
              )
            ],
          ).show();
        }else{
          if(jsonDecode(response.body)['error-code'] == 6006){
            return Alert(
              context: context,
              type: AlertType.error,
              title: "خطأ بالبيانات",
              desc: "رقم الهاتف او الاميل مستخدم من قبل برحاء تعديل البيانات ثم المحاولة مجددا",
              buttons: [
                DialogButton(
                  child: Text(
                    "الانتقال لصفحة التسجيل",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Get.to(SignUpScreen()),
                  width: 120,
                )
              ],
            ).show();
          }else{
            return Alert(
              context: context,
              type: AlertType.error,
              title: "برجاء المحاولة في وقت اخر",
              desc: "حدث خطأ اثناء عملية التسجيل برجاء المحاولة مره اخري",
              buttons: [
                DialogButton(
                  child: Text(
                    "الانتقال لصفحة التسجيل",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Get.to(SignUpScreen()),
                  width: 120,
                )
              ],
            ).show();
          }
        }
      }else{
        return Alert(
          context: context,
          type: AlertType.error,
          title: "برجاء المحاولة في وقت اخر",
          desc: "حدث خطأ اثناء عملية التسجيل برجاء المحاولة مره اخري",
          buttons: [
            DialogButton(
              child: Text(
                "الانتقال لصفحة التسجيل",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Get.to(SignUpScreen()),
              width: 120,
            )
          ],
        ).show();
      }
    }
  }
}