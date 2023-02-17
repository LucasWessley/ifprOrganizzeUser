import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:organizzeuser/screens/subscriptions_screen.dart';
import 'package:organizzeuser/utils/addEventSub.dart';

import '../global/global.dart';
import '../models/event_model.dart';
import '../splashScreen/my_splash_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  Event_Model? model;
  BuildContext? context;


  EventDetailsScreen({this.model});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  Inscricao inscri = Inscricao();
  // deleteEvent() {
  //   FirebaseFirestore.instance
  //       .collection("moderators")
  //       .doc(sharedPreferences!.getString("uid"))
  //       .collection("categories")
  //       .doc(widget.model!.catID)
  //       .collection("items")
  //       .doc(widget.model!.itemID)
  //       .delete()
  //       .then((value) {
  //     FirebaseFirestore.instance
  //         .collection("items")
  //         .doc(widget.model!.itemID)
  //         .delete();
  //
  //     Fluttertoast.showToast(msg: "Evento foi excluído!");
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  //   });
  // }

  realizarInscricao(){
    // checar se e o evento está ok

    // adicionar às inscricões


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green),
        ),
        title: Text(
          widget.model!.itemName.toString().toUpperCase(),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     deleteEvent();
      //   },
      //   label: Text("Deletar evento"),
      //   icon: Icon(
      //     Icons.delete,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.red,
      // ),
      body: ListView(
        children: [
          Column(
            children: [
              Image.network(
                widget.model!.thumbnailUrl.toString(),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                      child: Text(
                        widget.model!.itemName.toString().toUpperCase() + ":",
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        "Descrição: " +
                            widget.model!.itemDescription.toString(),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 10,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Text(
                      "Início: \n" + widget.model!.itemDateStart.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Text(
                      "Final: \n" + widget.model!.itemDateEnd.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  "Local: " + widget.model!.itemLocal.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  "Horário: " + widget.model!.itemHour.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0,right: 15.0),
            child: ElevatedButton(
              onPressed: () {

                inscri.addEventToSub(
                  widget.model!.itemID.toString(),
                  context,);
                Navigator.push(context, MaterialPageRoute(builder: (c)=> SubscriptionsScreen(
                  
                ))

                );


                 realizarInscricao();
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Increver-me'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
