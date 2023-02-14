import 'dart:async';

import 'package:delivery_by_bike_sellers/Authentication/signin_screen.dart';
import 'package:delivery_by_bike_sellers/uploadScreens/menus_upload_screen.dart';
import 'package:delivery_by_bike_sellers/widgets/card_design_widget.dart';
import 'package:delivery_by_bike_sellers/widgets/my_drawer.dart';
import 'package:delivery_by_bike_sellers/widgets/progress_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'global/global.dart';
import 'models/menus_model.dart';
import 'models/sellers_model.dart';

// LatLng SOURCE_LOCATION = LatLng(sharedPreferences!.getDouble("lat")!, sharedPreferences!.getDouble("lng")!);
LatLng SOURCE_LOCATION = LatLng(30, 39);
LatLng DEST_LOCATION = LatLng(39.7866393, 30.509036);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
          ),
          title: Text(
            sharedPreferences!.getString("name")!,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenusUploadScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        drawer: const MyDrawer(),
        body:  SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(

            children: [
              Container(
                 alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20, top: 20),
                child:
                    const Text(
                      'My Menus',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold,), //textAlign: TextAlign.start,
                    ),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("sellers").doc(sharedPreferences!.getString('uid')).collection("menus").orderBy("publishedDate", descending: true)
                              .snapshots(),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? Padding(
                                    padding: EdgeInsets.all(0),
                                    child: linearProgress(),
                                  )
                                : Container(
                                    padding: EdgeInsets.only(top: 15, bottom: 40),

                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                        shrinkWrap: true, //important
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          Menus model = Menus.fromJson(
                                              snapshot.data!.docs[index].data());
                                          return CardDesignWidget(
                                            model: model,
                                            context: context,
                                          );
                                        }),
                                  );
                          }),
              ),
            ],
          ),
        ),
    );


  }
}

class MenuUploadScreen {}
