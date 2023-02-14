import 'package:delivery_by_bike_sellers/itemsScreen.dart';
import 'package:delivery_by_bike_sellers/models/menus_model.dart';
import 'package:flutter/material.dart';


class CardDesignWidget extends StatefulWidget {

  Menus? model;
  BuildContext? context;

  CardDesignWidget({this.model, this.context});

  @override
  _CardDesignWidgetState createState() => _CardDesignWidgetState();
}

class _CardDesignWidgetState extends State<CardDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemsScreen(model: widget.model)));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    //  Ink.image(image: AssetImage(sharedPreferences!.getString("photoUrl")!)),
                    // Image.asset('assets/slider/2.jpg')
                    Ink.image(
                      //image: const NetworkImage("assets/slider/2.jpg"),
                       image:  NetworkImage(widget.model!.thumbnailUrl!,),
                      height: 150,
                      fit: BoxFit.cover,
                      child: InkWell(
                        onTap: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ItemsScreen(model: widget.model)));

                          // should inkwell onTap inside copy paste

                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(12),
                      child: Text(
                       //  widget.model!.sellerName!,
                        ' ',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(0.1)
                          ])),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 20, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.model!.menuTitle!, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      Text(widget.model!.menuInfo! , style: TextStyle(fontSize: 11, ),),

                    ],
                  ),
                ),
                ButtonBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
