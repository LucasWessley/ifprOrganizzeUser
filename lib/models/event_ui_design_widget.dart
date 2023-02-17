import 'package:flutter/material.dart';
import 'package:organizzeuser/models/event_details_screen.dart';
import 'package:organizzeuser/models/event_model.dart';

class EventUiDesignWidget extends StatefulWidget {
  Event_Model? model;
  BuildContext? context;

  EventUiDesignWidget({this.model, this.context});

  @override
  State<EventUiDesignWidget> createState() => _EventUiDesignWidgetState();
}

class _EventUiDesignWidgetState extends State<EventUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 8,
      child: SizedBox(
        height: 270,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => EventDetailsScreen(
                                model: widget.model,
                              )));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.model!.itemName.toString().toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Data: ' + widget.model!.itemDateStart.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(

                    child: Text(
                      'Local: ' + widget.model!.itemLocal.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
