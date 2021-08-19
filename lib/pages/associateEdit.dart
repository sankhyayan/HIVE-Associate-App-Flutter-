import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hivesmallassociateapp/model/associate.dart';
import 'package:hivesmallassociateapp/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../associateData.dart';

class AssociateEditPage extends StatefulWidget {
  final Associate currentAssociate;
  final double defaultSize;
  AssociateEditPage(
      {required this.currentAssociate, required this.defaultSize});
  @override
  _AssociateEditPageState createState() => _AssociateEditPageState();
}

class _AssociateEditPageState extends State<AssociateEditPage> {
  String newName = "";
  int newPhone = 0;
  bool newSenior = false;
  int newAge = 0;
  DateTime newJoinDate = DateTime.now();

  void _editAssociate(context) {
    if (newName == "") {
      toastWidget(
          message: "Give entry a name", defaultSize: widget.defaultSize);
      return;
    }
    if (newName.length < 2) {
      toastWidget(
          message: "Give a longer name", defaultSize: widget.defaultSize);
      return;
    }
    Provider.of<AssociateData>(context, listen: false).editAssociate(
        associate: Associate(
          name: newName,
          age: newAge,
          phone: newPhone,
          isSenior: newSenior,
          joinDate: newJoinDate,
        ),
        associateKey: widget.currentAssociate.key);
    Navigator.pop(context);
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.currentAssociate.name;
    newName = widget.currentAssociate.name;

    _ageController.text = widget.currentAssociate.age.toString();
    newAge = widget.currentAssociate.age;

    _phoneController.text = widget.currentAssociate.phone.toString();
    newPhone = widget.currentAssociate.phone;

    newSenior = widget.currentAssociate.isSenior;

    newJoinDate = widget.currentAssociate.joinDate;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation: 16,
        title: Text(
          "Edit ${widget.currentAssociate.name}",
          style: TextStyle(
            fontSize: widget.defaultSize * 1.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _editAssociate(context);
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
                controller: _nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                onChanged: (value) {
                  setState(() {
                    newName = value;
                  });
                },
              ),
              SizedBox(
                height: widget.defaultSize,
              ),
              TextField(
                autofocus: true,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "Phone Number",
                ),
                onChanged: (value) {
                  setState(() {
                    newPhone = int.parse(value);
                  });
                },
              ),
              SizedBox(
                height: widget.defaultSize,
              ),
              TextField(
                autofocus: true,
                controller: _ageController,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  hintText: "Age",
                ),
                onChanged: (value) {
                  setState(() {
                    newAge = int.parse(value);
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
                    value: newSenior,
                    onChanged: (value) {
                      setState(() {
                        newSenior = value;
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
                          newJoinDate = date;
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
