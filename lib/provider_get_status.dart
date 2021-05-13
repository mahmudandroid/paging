import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_solve_paging/appoment_status_model.dart';
import 'package:flutter_solve_paging/header.dart';
import 'package:http/http.dart' as http;


class ProviderGetStatus with ChangeNotifier {


  List<AppomentStatusModel> _item = [];


  List<AppomentStatusModel> get items {
    return [..._item];
  }



  Future<void> fetchStatusPage({int take ,int skip} ) async {

    Header header = new Header();
    var mheader = header.getHeaderToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI5MWRkNjVlMC0zOGJlLTRkMWMtOGFkYy1mZDE2NmU1YjBlYzEiLCJ1bmlxdWVfbmFtZSI6IjA5NjE2Njg2NjYiLCJyb2xlIjoiUGF0aWVudCIsIm5iZiI6MTYyMDk0Mjk0MiwiZXhwIjoxNjIxNTQ3NzQyLCJpYXQiOjE2MjA5NDI5NDJ9.ns5CSnZcODTcKV2bQL7DD8lGRLqhl8V7_ULZHiEoNiI');

    String url = "http://cliprzh-001-site2.ftempurl.com/api/Appoment/1/1";
    print("url");
    print(url);
    try {
      final response = await http.get(url + "/$take/$skip"  ,headers: mheader).catchError((onError){
        throw onError;
      });
      //print("i in fetchAndSetProducts");
      //print(response.body);

//      _item =[] ;

      if(response.statusCode ==  200 ){
        var body  =  jsonDecode(response.body) ;
//        List<FavoriteDoctorModel> list = [];
        AppomentStatusModel appomentStatusModel  ;
        body.forEach((e){
          appomentStatusModel  =  AppomentStatusModel.fromJson(e);
          _item.add(appomentStatusModel);
          notifyListeners();
        });
        // notifyListeners();
        //return _item ;
      }
      // notifyListeners();
    } catch (error) {
      //print("er er");
      //print(error);
      throw error;
    }
  }


  void deleteStatus(String appomentId) {
    _item.removeWhere((prod) => prod.id == appomentId);
    notifyListeners();
  }

}