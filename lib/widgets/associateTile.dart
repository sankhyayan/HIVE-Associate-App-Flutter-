import 'package:flutter/material.dart';
import 'package:hivesmallassociateapp/model/associate.dart';
import 'package:hivesmallassociateapp/pages/associateView.dart';
import 'package:provider/provider.dart';

import '../associateData.dart';

class AssociateTile extends StatelessWidget {
  final int tileIndex;
  final double defaultSize;
  AssociateTile({required this.tileIndex, required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return Consumer<AssociateData>(
      builder: (context, associateData, child) {
        Associate currentAssociate = associateData.getAssociate(tileIndex);
        return Container(
          decoration: BoxDecoration(
            color: tileIndex % 2 == 0 ? Colors.grey : Colors.white,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: Text(
                currentAssociate.name[0],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: defaultSize * 1.6,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              currentAssociate.name == "" ? "" : currentAssociate.name,
              style: TextStyle(
                fontSize: defaultSize * 1.6,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              currentAssociate.phone.toString() == ""
                  ? ""
                  : currentAssociate.phone.toString(),
              style: TextStyle(
                fontSize: defaultSize * 1.6,
              ),
            ),
            onTap: () {
              Provider.of<AssociateData>(context, listen: false)
                  .setActiveAssociate(currentAssociate.key);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssociateView(defaultSize: defaultSize),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
