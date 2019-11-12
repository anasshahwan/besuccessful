import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class QuoteBrain {


     Future getQOD() async {

      var firestore = Firestore.instance;
      QuerySnapshot qn =  await firestore.collection('quote_of_day').getDocuments();
     return qn.documents;
    }
}