import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tecnical/view/wedgits/custom_button.dart';
import 'package:tecnical/view/wedgits/custome_text.dart';

import '../../../controller/googleApi/mapAcceptController.dart';
import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../home/wallet_screen.dart';

class AcceptGoogleScreen extends StatelessWidget {
  MapAcceptController controller = Get.put(MapAcceptController());
  final String id;
  final String name;
  final String image;
  final double lat;
  final double lng;
  final String text_desc;
  final String client_id;
  AcceptGoogleScreen({
    super.key,
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.image,
    required this.text_desc,
    required this.client_id
  });

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
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat,lng),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController _controller) {
                controller.googleMapController.complete(_controller);
              },
              markers: [
                Marker(markerId: MarkerId('1'),position: LatLng(lat,lng)),
                //Marker(markerId: MarkerId('2'),position: LatLng(controller.lat,controller.lng)),
              ].toSet(),
            ),
            Container(
              width: double.infinity,
              height: 290,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Color(0xffFFFFFF),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: name,
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
                                image,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder(
                            future: controller.getDistbe(lat, lng),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if(snapshot.hasData){
                                return CustomText(
                                  text: '${snapshot.data.toStringAsFixed(2)} Km',
                                );
                              }else{
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Icon(Icons.add_road,color: Color(0xff1C74BC),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FutureBuilder(
                            future: controller.dataPhoneClient(client_id),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if(snapshot.hasData){
                                return CustomText(
                                  text: '${snapshot.data.toString()}',
                                );
                              }else{
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          Icon(Icons.call_rounded,color: Color(0xff1C74BC),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: CustomButton(onPress: ()async{
                        var image_show;
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        image_show = prefs.getString('image_show');
                        if(image_show.toString() == 'null'){
                          return Alert(
                            context: context,
                            title: "وصف الطلب",
                            desc: text_desc,
                            buttons: [],
                          ).show();
                        }else{
                          return Alert(
                            context: context,
                            title: "وصف الطلب",
                            desc: text_desc,
                            buttons: [],
                            image: Container(
                              height: 250,
                              child: Image.network(
                                'https://cars-ksa.tech/'+image_show.toString(),
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
                          ).show();
                        }
                      },text: 'عرض بيانات الطلب',),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(onPress: (){
                            controller.decline(id);
                          },text: 'رفض',color: 0xffFFFFFF,text_colorl: 0xff1C74BC,),
                          CustomButton(onPress: (){
                            controller.accept(id);
                          },text: 'قبول',)
                        ],
                      ),
                    ),

                  ],
                ),
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
