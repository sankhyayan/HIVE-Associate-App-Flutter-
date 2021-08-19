import 'package:flutter/material.dart';
import 'package:hivesmallassociateapp/model/associate.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../associateData.dart';
import '../utils.dart';
import 'associateEdit.dart';

class AssociateView extends StatelessWidget {
  final double defaultSize;
  AssociateView({required this.defaultSize});

  @override
  Widget build(BuildContext context) {
    void _deleteConfirmation(currentAssociate) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Are you sure?',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('You are about to delete${currentAssociate.name}'),
                  SizedBox(
                    height: defaultSize,
                  ),
                  Text("This action cant be undone"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Log.debug("Deleting ${currentAssociate.name}");
                  Provider.of<AssociateData>(context, listen: false)
                      .deleteAssociate(currentAssociate.key);
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(Navigator.defaultRouteName),
                  );
                },
                child: Text(
                  "DELETE",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Log.debug("Cancelling");
                  Navigator.of(context).pop();
                },
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Consumer<AssociateData>(builder: (context, associateData, child) {
      Associate currentAssociate = associateData.getActiveAssociate();
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 16,
          title: Text(
            currentAssociate.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: defaultSize * 1.6,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Log.debug("Selected to edit");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AssociateEditPage(
                        currentAssociate: currentAssociate,
                        defaultSize: defaultSize,
                      );
                    },
                  ),
                );
              },
              icon: Icon(Icons.create),
              iconSize: defaultSize * 2.4,
              color: Colors.white,
              tooltip: "Edit",
            ),
            IconButton(
              onPressed: () {
                Log.debug("Selected to delete");
                _deleteConfirmation(currentAssociate);
              },
              icon: Icon(Icons.delete),
              iconSize: defaultSize * 2.4,
              color: Colors.red,
              tooltip: "Delete",
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(defaultSize * 1.6),
          child: Center(
            child: Column(
              children: [
                Container(
                  height: defaultSize * 3.6,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      Text(
                        currentAssociate.phone.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: defaultSize * 3.6,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Age",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      Text(
                        currentAssociate.age.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: defaultSize * 3.6,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Join Date",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      Text(
                        DateFormat("yyyy-MM-dd").format(currentAssociate.joinDate),

                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: defaultSize * 3.6,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Senior",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultSize * 1.6,
                        ),
                      ),
                      Switch(value: currentAssociate.isSenior, onChanged: (value){
                      },activeTrackColor: Colors.black,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
