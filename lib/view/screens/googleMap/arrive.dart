import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tecnical/view/wedgits/custom_button.dart';
import 'package:tecnical/view/wedgits/custome_text.dart';

import '../../../controller/googleApi/arriveMapController.dart';
import '../../../controller/googleApi/mapAcceptController.dart';
import '../home/home_screen.dart';
import '../home/profile_screen.dart';
import '../home/wallet_screen.dart';

class ArriveMap extends StatelessWidget {

  final String id;
  final double lat;
  final double lng;
  final double lating;
  final double lnging;
  ArriveMap({super.key, required this.id, required this.lat, required this.lng, required this.lating, required this.lnging});

  ArriveMapController controller = Get.put(ArriveMapController());

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
        child: FutureBuilder(
          future: controller.getPolylines(lat,lng,lating, lnging),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Stack(
              children:[
                GoogleMap(
                mapType: MapType.terrain,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat,lng),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController _controller) {
                  controller.googleMapController.complete(_controller);
                },
                polylines: {
                  Polyline(
                    polylineId: PolylineId('route'),
                    points: controller.polylineCoordinates,
                    color: Color(0xff1C74BC),
                    width: 6
                  ),
                },
                markers: [
                  Marker(markerId: MarkerId('Client'),position: LatLng(lat,lng)),
                  Marker(markerId: MarkerId('2'),position: LatLng(lating,lnging)),
                ].toSet(),
              ),
                Container(
                  width: double.infinity,
                  height: 70,
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomButton(onPress: (){
                      controller.arrives(id);
                    },text: 'تم الوصول',),
                  ),
                ),
              ]
            );
          },
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
