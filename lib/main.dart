import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivesmallassociateapp/pages/addAssociate.dart';
import 'package:hivesmallassociateapp/pages/associateListPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'associateData.dart';
import 'model/associate.dart';
void main() {
  Hive.registerAdapter(AssociateAdapter());
  runApp(AssociateApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

class AssociateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AssociateData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Associates',
        theme: ThemeData(primaryColor: Colors.purpleAccent),
        initialRoute: "/",
        routes: {
          "/": (context) => FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text("Error establishing hive"),
                    ),
                  );
                } else {
                  return AssociateListPage(
                  );
                }
              }
              else{
                return Scaffold();
              }
            },
            future: _initHive(),
          ),
          "/AddAssociatePage":(context)=>AddAssociatePage(defaultSize: 10),
        },
      ),
    );
  }
}
