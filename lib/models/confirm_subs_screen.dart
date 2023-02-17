import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/global.dart';
import '../screens/home_screen.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
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
        // cartMethods.clearCart(context);
        Fluttertoast.showToast(msg: "Parabéns! Inscrição confirmada!");
        Navigator.push(context, MaterialPageRoute(builder: (c) =>HomeScreen()));
        subscriptionId = "";
      });
    });

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              subscriptionsDetails();
            },
            child: Text('Confirmar Inscrição'),
          ),
        ],
      ),
    );
  }
}
