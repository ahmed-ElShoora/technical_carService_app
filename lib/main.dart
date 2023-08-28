import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tecnical/view/screens/errorConectionScreen.dart';
import 'package:tecnical/view/screens/home/home_screen.dart';
import 'package:tecnical/view/screens/intro/intro_screen.dart';

import 'controller/mainController.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TecnicalAPP());
}

class TecnicalAPP extends StatelessWidget {
  MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Car Service',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Obx((){
          if(controller.connectivityStatus.value != 0){
            return controller.login_status.value ? HomeScreen() : IntroScreen();
          }else{
            return ErrorConectionScreen();
          }
        })
      ),
    );
  }
}