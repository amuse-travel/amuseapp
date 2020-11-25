import 'dart:developer';

import 'package:amusetravel/repositories/reported_repository/reported_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportedRepositoryImpl extends ReportedRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> reportUser({String userName}) async {
    try {
      final CollectionReference _reported = _firestore.collection('reported');
      _reported.doc('users').update(
        <String, dynamic>{
          userName: 'reported',
        },
      );

      return true;
    } catch (e) {
      log('=====| reportUser |=====[ ${e.toString()}');
      return false;
    }
  }
}
