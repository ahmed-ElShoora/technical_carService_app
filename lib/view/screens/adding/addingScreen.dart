
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';
import 'package:tecnical/view/wedgits/custom_button.dart';
import 'package:tecnical/view/wedgits/custome_text.dart';
import 'package:tecnical/view/wedgits/custome_text_form_faild.dart';


import '../../../controller/adding/addingController.dart';
import '../../wedgits/Custome_field.dart';

class AddingScreen extends StatelessWidget {

  final String id;
  AddingScreen({super.key, required this.id});
  AddingController controller = Get.put(AddingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1C74BC),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomText(
                    text: ': اعمال اليد ',
                    color: Color(0xff1C74BC),
                    fontSize: 22,
                    fontweight: FontWeight.bold,
                    //alignmentText: TextAlign.right,
                    alignment: Alignment.topRight,
                  ),
                ),
                Obx((){
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.MController.length,
                      itemBuilder: (context,int index){
                        if(controller.MController.length>1){
                          return Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          controller.MController.removeAt(index);
                                        },
                                        child: Icon(Icons.close_sharp),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CustomField(
                                        hint: 'السعر',
                                        textInputType: TextInputType.number,
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.pMa?.add(value);
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),

                                    Expanded(
                                      flex: 8,
                                      child: CustomField(
                                        textInputType: TextInputType.text,
                                        hint: 'اسم الخدمه',
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.tMa?.add(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          );
                        }else{
                          return Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: CustomField(
                                        textInputType: TextInputType.number,
                                        hint: 'السعر',
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.pMa?.add(value);
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),

                                    Expanded(

                                      flex: 3,
                                      child: CustomField(
                                        textInputType: TextInputType.text,
                                        hint: 'اسم الخدمه',
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.tMa?.add(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          );
                        }
                      }
                  );
                }),
                GestureDetector(
                  onTap: (){
                    controller.MController.add(
                      TextEditingController(),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CustomText(
                      text: '+ اضافة ',
                      color: Color(0xff1C74BC),
                      fontSize: 22,
                      fontweight: FontWeight.bold,
                      //alignmentText: TextAlign.right,
                      alignment: Alignment.topRight,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Switch(
                        onChanged: (val) => controller.toggle(),
                        value: controller.on.value),
                    ),
                    SizedBox(width: 15,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CustomText(
                        text: 'قسم القطع',
                        color: Color(0xff1C74BC),
                        fontSize: 22,
                        fontweight: FontWeight.bold,
                        //alignmentText: TextAlign.right,
                        alignment: Alignment.topRight,
                      ),
                    ),
                  ],
                ),
                Obx((){
                  if(controller.on.value){
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: controller.PController.length,
                        itemBuilder: (context,int index){
                          return Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: (){
                                          controller.PController.removeAt(index);
                                          if(controller.PController.length == 0){
                                            controller.on.value = false;
                                          }
                                        },
                                        child: Icon(Icons.close_sharp),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CustomField(
                                        hint: 'السعر',
                                        textInputType: TextInputType.number,
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.pPr?.add(value);
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),

                                    Expanded(
                                      flex: 8,
                                      child: CustomField(
                                        textInputType: TextInputType.text,
                                        hint: 'اسم القطعه',
                                        validator: (value){
                                          if (value == null || value.isEmpty) {
                                            return 'هذا الحقل اجباري';
                                          }
                                          return null;
                                        },
                                        //controller: controller.phone,
                                        textDire: TextDirection.ltr,
                                        textAlign: TextAlign.right,
                                        onSaved: (value){
                                          controller.tPr?.add(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          );
                        }
                    );
                  }else{
                    return Container();
                  }
                }),
                Obx((){
                  if(controller.on.value){
                    return GestureDetector(
                      onTap: (){
                        controller.PController.add(
                          TextEditingController(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomText(
                          text: '+ اضافة ',
                          color: Color(0xff1C74BC),
                          fontSize: 22,
                          fontweight: FontWeight.bold,
                          //alignmentText: TextAlign.right,
                          alignment: Alignment.topRight,
                        ),
                      ),
                    );
                  }else{
                    return Container();
                  }
                }),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomText(
                    text: 'عدد ايام العمل',
                    color: Color(0xff1C74BC),
                    fontSize: 22,
                    fontweight: FontWeight.bold,
                    //alignmentText: TextAlign.right,
                    alignment: Alignment.topRight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomField(
                    textInputType: TextInputType.number,
                    hint: 'عدد ايام العمل',
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'هذا الحقل اجباري';
                      }
                      return null;
                    },
                    //controller: controller.phone,
                    textDire: TextDirection.ltr,
                    textAlign: TextAlign.right,
                    onSaved: (value){
                      controller.day_work=value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.grey.shade50,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                        backgroundColor: MaterialStateProperty.all(Color(0xff1C74BC)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      ),
                      onPressed: (){
                        controller.selectMultipleImage();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.image),
                          SizedBox(
                            width: 100,
                          ),
                          CustomText(
                            text: 'ارفاق فواتير',
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomButton(
                    onPress: () async{
                      await controller.pushData(id);
                    },
                    text: 'ارسال',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
