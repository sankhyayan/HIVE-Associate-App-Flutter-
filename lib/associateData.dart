//THIS FILE IS THE DATABASE HELPER OF THIS PROJECT

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivesmallassociateapp/utils.dart';
import 'model/associate.dart';

class AssociateData extends ChangeNotifier{//creating a class to notify any changes made to the Hive box "associateBox"
  static const String _boxName="associateBox";
  List<Associate> _associateList =[];//updated list of associates
  late Associate activeAssociate;//storing our chosen associate

  void getAssociates()async{//get the list of associated
    var box=await Hive.openBox<Associate>(_boxName);
    _associateList=box.values.toList();
    notifyListeners();
  }

  Associate getAssociate(index){//get associate by index from the list
    return _associateList[index];
  }

  void addAssociate(Associate associate)async{//add associate
    var box=await Hive.openBox<Associate>(_boxName);
    await box.add(associate);
    _associateList=box.values.toList();
    notifyListeners();
  }

  void deleteAssociate(key)async{//delete associate
    var box=await Hive.openBox<Associate>(_boxName);
    await box.delete(key);
    _associateList=box.values.toList();
    Log.info("Deleted user with key"+key.toString());
    notifyListeners();
  }

  void editAssociate({required Associate associate,required int associateKey})async{//edit associate
    var box=await Hive.openBox<Associate>(_boxName);
    await box.put(associateKey, associate);
    _associateList=box.values.toList();
    activeAssociate=box.get(associateKey)!;
    Log.info("edited "+associate.name);
    notifyListeners();
  }

  void setActiveAssociate(key)async{//setting our selected associate
    var box=await Hive.openBox<Associate>(_boxName);
    activeAssociate=box.get(key)!;
    notifyListeners();
  }

  Associate getActiveAssociate(){//getting our selected associate
    return activeAssociate;
  }

  int get associateCount{
    return _associateList.length;
  }
}