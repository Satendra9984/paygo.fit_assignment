import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paygo_fit/src/home/data/models/center_details_model.dart';

class RemoteDataSource {
  RemoteDataSource();

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<List<CenterDetails>> getNearbyCentersList() {
    return _firebaseFirestore
        .collection('centers')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((QueryDocumentSnapshot doc) {
        return CenterDetails.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

// Function to add a CenterDetails instance to Firestore
  Future<void> addCenterDetails(CenterDetails centerDetails) async {
    try {
      // Reference to the Firestore collection
      final CollectionReference centersCollection =
          FirebaseFirestore.instance.collection('centers');

      // Add the CenterDetails instance to Firestore
      await centersCollection.add(centerDetails.toJson());

      debugPrint('Center added successfully');
    } catch (e) {
      debugPrint('Failed to add center: $e');
    }
  }
}
