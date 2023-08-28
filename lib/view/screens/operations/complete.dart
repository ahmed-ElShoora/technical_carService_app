import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:tecnical/controller/home/homeController.dart';
import 'package:tecnical/view/screens/home/profile_screen.dart';
import 'package:tecnical/view/screens/home/wallet_screen.dart';
import 'package:tecnical/view/screens/operations/waiting.dart';
import '../../../controller/operation/operation_controller.dart';
import '../../wedgits/custome_text.dart';
import '../home/home_screen.dart';
import 'cancell.dart';
import 'containue.dart';

class CompleteScreen extends StatelessWidget {
  OperationController controller = Get.put(OperationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1C74BC),
          actions: [
            FutureBuilder(
                future: controller.getDataUser(),
                builder: (context,AsyncSnapshot snapshot) {
                  if(snapshot.hasData)
                  {
                    var data = snapshot.data;
                    return Row(
                      children: [
                        CustomText(
                          text: 'مرحبا '+data['data']['name'].toString(),
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff4EA8F1),
                            shape: BoxShape.circle,
                          ),
                          height: 30,
                          width: 30,
                          child: ClipOval(
                            child: Image.network(
                              'https://cars-ksa.tech/' + data['data']['photo'],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
            )
          ]
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/pattern-background.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(ContainueScreen());
                        },
                        child: CustomText(
                          text: 'جارية',
                          color: Colors.black,
                          alignmentText: TextAlign.center,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(WaitingScreen());
                        },
                        child: CustomText(
                          text: 'قيد الانتظار',
                          color: Colors.black,
                          alignmentText: TextAlign.center,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(CancellScreen());
                        },
                        child: CustomText(
                          text: 'مرفوضه',
                          color: Colors.black,
                          alignmentText: TextAlign.center,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xff1C74BC),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.to(CompleteScreen());
                        },
                        child: CustomText(
                          text: 'مكتملة',
                          color: Colors.black,
                          alignmentText: TextAlign.center,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: FutureBuilder(
                      future: controller.getDataPage(3),
                      builder: (context,AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          var data = snapshot.data;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context,int index) {
                              int price = int.parse(data[index]['price']).toInt();
                              double price_kesma = (price/100) as double;
                              var tec_price = price_kesma*30;
                              return GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                                      ),
                                      builder: (context)=>Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(30),
                                          child: Column(
                                            children: [
                                              Center(
                                                  child:
                                                  CustomText(
                                                    text: 'تفاصيل رصيد الفاتورة',
                                                    color: Color(0xff1C74BC),
                                                    fontSize: 25,
                                                    fontweight: FontWeight.normal,
                                                  )
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: data[index]['id'].toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'رقم الفاتورة',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: data[index]['category_name'].toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'اسم العميل',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: data[index]['category_price'].toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'سعر الكشف عن الخدمة',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: data[index]['price'].toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'سعر الاصلاح',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: tec_price.toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'نسبة الفني 30 بالمئة',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: data[index]['day_work'].toString(),
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.center,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        width: double.infinity/2,
                                                        child: CustomText(
                                                          text: 'عدد ايام العمل',
                                                          color: Color(0xff202020),
                                                          fontSize: 20,
                                                          fontweight: FontWeight.normal,
                                                          alignment: Alignment.topRight,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16,left: 16,bottom: 16),
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  height: 175,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.0, 0.75),
                                          color: Color(0xff777777),
                                          blurRadius: 2.0,
                                        ),
                                      ]
                                  ),
                                  child: Column(
                                    children: [
                                      CustomText(text: 'رقم الخدمه '+data[index]['id'].toString(),alignment: Alignment.topLeft,fontSize: 17,fontweight: FontWeight.normal,),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            CustomText(
                                              text: data[index]['category_name'].toString(),
                                              fontweight: FontWeight.normal,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xff4EA8F1),
                                                shape: BoxShape.circle,
                                              ),
                                              height: 70,
                                              width: 70,
                                              child: ClipOval(
                                                child: Image.network(
                                                  'https://cars-ksa.tech/'+data[index]['category_image'].toString(),
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (BuildContext context, Widget child,
                                                      ImageChunkEvent? loadingProgress) {
                                                    if (loadingProgress == null) return child;
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        value: loadingProgress.expectedTotalBytes != null
                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                            loadingProgress.expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              text: Moment.parse(data[index]['created_at']).format("dd-MM-yyyy").toString(),
                                              fontSize: 17,
                                              fontweight: FontWeight.normal,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(Icons.calendar_month_outlined,),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff1C74BC),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.white,),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.wallet,color: Colors.white,),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.white,),
              label: ''
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch(index){
            case 0 :
              Get.offAll(HomeScreen());
              break;
            case 1 :
              Get.offAll(WalletScreen());
              break;
            case 2 :
              Get.offAll(ProfileScreen());
              break;
          }
        },
      ),
    );
  }
}
