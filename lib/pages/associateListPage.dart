import 'package:flutter/material.dart';
import 'package:hivesmallassociateapp/model/sizeConfig.dart';
import 'package:hivesmallassociateapp/widgets/associateList.dart';
import 'package:provider/provider.dart';

import '../associateData.dart';
//MAIN PAGE TILL NOW
class AssociateListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    Provider.of<AssociateData>(context, listen: false).getAssociates();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 16,
        title: Text(
          'Associates',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: defaultSize * 1.6,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: AssociateList(
                  defaultSize: defaultSize,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        tooltip: "Add",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/AddAssociatePage');
        },
      ),
    );
  }
}
