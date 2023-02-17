import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:organizzeuser/global/global.dart';
import 'package:organizzeuser/utils/addEventSub.dart';

import 'card_subs.dart';

class MySubsScreen extends StatefulWidget {
  const MySubsScreen({Key? key}) : super(key: key);

  @override
  State<MySubsScreen> createState() => _MySubsScreenState();
}

separateItemIDs(itemID)
{
  //2367121:5
  List<String>? userCartList = List<String>.from(itemID);

  List<String> itemsIDsList = [];
  for(int i=1; i<userCartList.length; i++)
  {
    //2367121:5
    String item = userCartList[i].toString();
    var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(":");

    //2367121
    String getItemID = item.substring(0, lastCharacterPositionOfItemBeforeColon);
    itemsIDsList.add(getItemID);
  }

  return itemsIDsList;
}




class _MySubsScreenState extends State<MySubsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.green),
        ),
        title: Text('Minhas Inscrições'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(sharedPreferences!.getString("uid"))
              .collection("subscriptions")
              .where("status", isEqualTo: "normal")
              // .orderBy("orderTime", descending: true)
              .snapshots(),
          builder: (c, AsyncSnapshot dataSnapShot) {
            if(dataSnapShot.hasData)
            {
              return ListView.builder(
                itemCount: dataSnapShot.data.docs.length,
                // itemCount: 10,
                itemBuilder: (c, index)
                {
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("items")
                        // .where("itemID", whereIn: Inscricao().separateEventIdsFromUsers((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["itemID"]))
                        .where("orderBy", whereIn: (dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["uid"])
                        .orderBy("publishedDate", descending: true)
                        .get(),
                    builder: (c, AsyncSnapshot snapshot)
                    {
                      if(snapshot.hasData)
                      {
                        return SubsCard(
                          itemCount: snapshot.data.docs.length,
                          data: snapshot.data.docs,
                          subsId: dataSnapShot.data.docs[index].id,
                          // seperateQuantitiesList: Inscricao().separeteSubsIdsFromIds((dataSnapShot.data.docs[index].data() as Map<String, dynamic>)["productIDs"]),
                        );

                      }
                      else
                      {
                        return const Center(
                          child: Text(
                            "Não há dados aqui.",
                          ),
                        );
                      }
                    },
                  );
                },
              );
            } else {
              return Center(
                child: Text('Nada encontrado!'),
              );
            }
          }
      ),
    );
  }
}
