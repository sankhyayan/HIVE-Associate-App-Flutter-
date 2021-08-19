import 'package:flutter/material.dart';
import 'package:hivesmallassociateapp/model/associate.dart';
import 'package:hivesmallassociateapp/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../associateData.dart';

class AddAssociatePage extends StatefulWidget {
  final double defaultSize;

  const AddAssociatePage({required this.defaultSize});
  @override
  _AddAssociatePageState createState() => _AddAssociatePageState();
}

class _AddAssociatePageState extends State<AddAssociatePage> {
  String name = "";
  int phone = 0;
  bool senior = false;
  int age = 0;
  DateTime joined = DateTime.now();

  void _addAssociate(context) {
    if (name == "") {
      toastWidget(
          message: "Give entry a name", defaultSize: widget.defaultSize);
      return;
    }
    if (name.length < 2) {
      toastWidget(
          message: "Give a longer name", defaultSize: widget.defaultSize);
      return;
    }
    Provider.of<AssociateData>(context, listen: false).addAssociate(
      Associate(
        name: name,
        age: age,
        phone: phone,
        isSenior: senior,
        joinDate: joined,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation: 16,
        title: Text(
          "Add Associate",
          style: TextStyle(
            fontSize: widget.defaultSize * 1.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _addAssociate(context);
            },
            icon: Icon(Icons.save),
            iconSize: widget.defaultSize * 2.4,
            color: Colors.white,
            tooltip: "Save",
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(widget.defaultSize * 1.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: widget.defaultSize,
              ),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                ),
                onChanged: (value) {
                  setState(() {
                    phone = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: widget.defaultSize,
              ),
              TextField(
                autofocus: true,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  hintText: "Age",
                ),
                onChanged: (value) {
                  setState(() {
                   age = int.parse(value);
                  });
                },
              ),
              Row(
                children: [
                  Text(
                    "Is Senior",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.defaultSize * 1.6,
                    ),
                  ),
                  Switch(
                    value: senior,
                    onChanged: (value) {
                      setState(() {
                        senior = value;
                      });
                    },
                    activeTrackColor: Colors.purpleAccent,
                    activeColor: Colors.purple,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Join Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: widget.defaultSize * 1.6,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        setState(() {
                          joined = date;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    tooltip: "Tap to open date picker",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
