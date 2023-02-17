import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'event_model.dart';

class SubsCard extends StatefulWidget
{
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? subsId;


  SubsCard({
    this.itemCount,
    this.data,
    this.subsId,

  });

  @override
  State<SubsCard> createState() => _SubsCardState();
}

class _SubsCardState extends State<SubsCard>
{
  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: Colors.black,
      elevation: 10,
      shadowColor: Colors.white54,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        height: widget.itemCount! * 125, //2*125
        child: ListView.builder(
          itemCount: widget.itemCount,
          itemBuilder: (context, index)
          {
            Event_Model model = Event_Model.fromJson(widget.data![index].data() as Map<String, dynamic>);
            return placedOrdersItemsDesignWidget(model, context, widget.subsId![index]);
          },
        ),
      ),
    );
  }
}


Widget placedOrdersItemsDesignWidget(Event_Model items, BuildContext context, itemQuantity)
{
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.transparent,
    child: Row(
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            items.thumbnailUrl.toString(),
            width: 120,
          ),
        ),

        const SizedBox(width: 10.0,),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 20,
                ),

                //title and price
                Row(
                  children: [

                    Expanded(
                      child: Text(
                        items.itemName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    // const Text(
                    //   "€ ",
                    //   style: TextStyle(
                    //     color: Colors.purpleAccent,
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),

                    // Text(
                    //   items.price.toString(),
                    //   style: const TextStyle(
                    //     color: Colors.purpleAccent,
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),

                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //x with quantity
                // Row(
                //   children: [
                //
                //     const Text(
                //       "x ",
                //       style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 14,
                //       ),
                //     ),
                //
                //     Text(
                //       itemQuantity,
                //       style: const TextStyle(
                //         color: Colors.grey,
                //         fontSize: 28,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //
                //   ],
                // ),

              ],
            ),
          ),
        ),

      ],
    ),
  );
}
