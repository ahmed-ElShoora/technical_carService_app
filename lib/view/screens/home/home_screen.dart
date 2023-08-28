import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tecnical/controller/home/homeController.dart';
import 'package:tecnical/model/Ad.dart';
import 'package:tecnical/view/screens/home/profile_screen.dart';
import 'package:tecnical/view/screens/home/wallet_screen.dart';
import 'package:tecnical/view/screens/operations/cancell.dart';
import 'package:tecnical/view/screens/operations/complete.dart';
import 'package:tecnical/view/screens/operations/containue.dart';
import 'package:tecnical/view/screens/operations/waiting.dart';
import 'package:tecnical/view/wedgits/custom_button.dart';
import '../../wedgits/custome_text.dart';
import '../notify/notify.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff1C74BC),
          leading: GestureDetector(
            onTap: (){
              //notify page
              Get.to(NotifyScreen());
            },
              child: Icon(Icons.notification_important_rounded)
          ),
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern-background.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: FutureBuilder(
                      future: controller.getDataAds(),
                      builder: (context,AsyncSnapshot snapShot){
                        if(snapShot.hasData){
                          Ad data = snapShot.data;
                          return CarouselSlider.builder(
                            options: CarouselOptions(
                              height: 200,
                              aspectRatio: 16/9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration: Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                            itemCount: data.data!.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                              return Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xffD0E1F0),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 15.0),
                                              child: CustomText(
                                                text: data.data![itemIndex].title.toString(),
                                                color: Color(0xff1C74BC),
                                              ),
                                            ),
                                            //if(data.data![itemIndex].link.toString() != 'null'){
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 15.0),
                                                child: CustomButton(
                                                    text: 'المزيد',
                                                    onPress: () async{
                                                      await controller.funLaunchUrl(data.data![itemIndex].link.toString());
                                                    }
                                                ),
                                              )
                                            //}
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff4EA8F1),
                                          shape: BoxShape.circle,
                                        ),
                                        height: 125,
                                        width: 130,
                                        child: Image.network(
                                          'https://cars-ksa.tech/'+data.data![itemIndex].image.toString(),
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
                                    ],
                                  ),
                                ),
                              );
                            }
                          );
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10),child: CustomText(
                    text: 'طلباتي',
                    color: Color(0xff1C74BC),
                    alignment: Alignment.topRight,
                    fontSize: 20,
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                                color: Color(0xffFFFFFF),
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
