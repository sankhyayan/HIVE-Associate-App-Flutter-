import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../associateData.dart';
import 'associateTile.dart';

class AssociateList extends StatelessWidget {
  final double defaultSize;
  AssociateList({required this.defaultSize});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<AssociateData>(context)
          .associateCount, //any changes is notified to this provider
      itemBuilder: (context, index) {
        return AssociateTile(
          tileIndex: index,
          defaultSize: defaultSize,
        );
      },
      padding: EdgeInsets.fromLTRB(
        defaultSize * .8,
        defaultSize * .6,
        defaultSize * .8,
        defaultSize * .4,
      ),
    );
  }
}
