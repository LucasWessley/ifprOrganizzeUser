import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:organizzeuser/global/global.dart';
import 'package:organizzeuser/screens/home_screen.dart';
import 'package:organizzeuser/utils/addEventSub.dart';

class SubscriptionsScreen extends StatefulWidget {
  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {

  String subscriptionId = DateTime.now().millisecondsSinceEpoch.toString();
  subscriptionsDetails() {
    saveSubscriptionsForUser({
      "subscriptions": sharedPreferences!.getString("uid"),
      "itemID": sharedPreferences!.getStringList("userCart"),
      "isSucess": true,
      "status": "normal",

    }).whenComplete((){
      saveSubscriptionsForModerator({
        "subscriptions": sharedPreferences!.getString("uid"),
        "itemIDs": sharedPreferences!.getStringList("userCart"),
        "isSucess": true,
        "status": "normal",
      }).whenComplete((){
        clearEvent;
        Fluttertoast.showToast(msg: "Parabéns! Inscrição confirmada!");
        Navigator.push(context, MaterialPageRoute(builder: (c) =>HomeScreen()));
        subscriptionId = "";
      });
    });

  }

  clearEvent(BuildContext context) {
    //LOCAL
    sharedPreferences!.setStringList("userCart", ["initialValue"]);
//Server
    List<String>? empthEventList = sharedPreferences!.getStringList("userCart");
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({"userCart": empthEventList}).then((value) {});

    separateEventIdsFromUsers();
  }
  separateEventIdsFromUsers() {
    List<String>? userEventList = sharedPreferences!.getStringList("userCart");
    List<String> eventsIDsList = [];
    for (int i = 1; i < userEventList!.length; i++) {
      String event = userEventList[i].toString();
      var lastCharacterPositionOfEventBeforeColor = event.lastIndexOf(":");
      String getIdEvent =
      event.substring(0, lastCharacterPositionOfEventBeforeColor);
      eventsIDsList.add(getIdEvent);
    }
    print("IDS: ============= ");
    print(eventsIDsList);
    return userEventList;
  }



  saveSubscriptionsForUser(Map<String, dynamic> subscriptionsMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("subscriptions")
        .doc(subscriptionId)
        .set(subscriptionsMap);
  }

  saveSubscriptionsForModerator(Map<String, dynamic> subscriptionsMap) async {
    await FirebaseFirestore.instance
        .collection("subscriptions")
        .doc(subscriptionId)
        .set(subscriptionsMap).whenComplete(() {

      //send push notification

      Fluttertoast.showToast(msg: "Inscrição Confirmada!");

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

      subscriptionId="";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
     child: ElevatedButton(
       child: Text('Confirmar Inscrição.'),
       onPressed: (){
         subscriptionsDetails();
         Navigator.push(context, MaterialPageRoute(builder: (c)=> HomeScreen()));
       },
     ),
    );
  }
}
