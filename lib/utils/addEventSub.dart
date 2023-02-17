import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:organizzeuser/global/global.dart';
import 'package:organizzeuser/screens/subscriptions_screen.dart';

class Inscricao {
  addEventToSub(String? itemID, BuildContext context) {
    //salvar local
    List<String>? tempList = sharedPreferences!.getStringList("userCart");

    tempList!.add(itemID.toString());

    print("tempList = ");
    print(tempList);

    // sharedPreferences!.setStringList("userCart",tempList);

    //save in server
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .update({
      "userCart": tempList,
    }).then((value) {

      Navigator.push(context, MaterialPageRoute(builder: (c)=> SubscriptionsScreen()));
      // Fluttertoast.showToast(msg: "Inscrito!");

      sharedPreferences!.setStringList("userCart", tempList);
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
    return itemsImageList;
  }

  separeteSubsIdsFromIds(itemID) {
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
    return itemsImageList;


  }

  separateSubsIdsFromUsers() {
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



}
