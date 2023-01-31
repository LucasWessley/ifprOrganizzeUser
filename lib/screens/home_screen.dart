import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:organizzeuser/global/global.dart';
import 'package:organizzeuser/models/event_ui_design_widget.dart';
import 'package:organizzeuser/widgets/my_drawer.dart';

import '../models/event_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green),
        ),
        title: Text(
          "Organizze",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.all(6.0),
          //     child: SizedBox(
          //       height: MediaQuery.of(context).size.height * 0.3,
          //       width: MediaQuery.of(context).size.width,
          //       child: CarouselSlider(
          //         options: CarouselOptions(
          //           height: MediaQuery.of(context).size.height * 0.9,
          //           aspectRatio: 16 / 9,
          //           viewportFraction: 0.8,
          //           initialPage: 0,
          //           enableInfiniteScroll: true,
          //           reverse: true,
          //           autoPlay: true,
          //           autoPlayInterval: Duration(seconds: 3),
          //           autoPlayAnimationDuration: Duration(microseconds: 800),
          //           autoPlayCurve: Curves.fastOutSlowIn,
          //           enlargeCenterPage: true,
          //           scrollDirection: Axis.horizontal,
          //         ),
          //         items: itemsImageList.map((index) {
          //             return Builder(builder: (BuildContext c) {
          //               return Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 margin: EdgeInsets.symmetric(horizontal: 1),
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(40),
          //                   child: Image.asset(
          //                     index,
          //                     fit: BoxFit.fill,
          //                   ),
          //                 ),
          //               );
          //             });
          //           },
          //         ).toList(),
          //       ),
          //     ),
          //   ),
          // ),
      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot){
              if (dataSnapshot.hasData) {
                return SliverStaggeredGrid.countBuilder(
                    crossAxisCount: 1,
                    staggeredTileBuilder: (c) => const StaggeredTile.fit(1),
                    itemBuilder: (context, index) {
                      Event_Model model = Event_Model.fromJson(
                          dataSnapshot.data.docs[index].data() as Map<String, dynamic>);
                      return EventUiDesignWidget(
                          model: model,
                          context: context
                      );
                    },
          itemCount: dataSnapshot.data.docs.length,
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "sem novidades", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
