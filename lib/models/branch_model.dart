import 'package:cloud_firestore/cloud_firestore.dart';

class BranchModel {
  final String id;
  final String desc;
  final String govern;
  final double lat;
  final double lng;

  BranchModel({
    required this.id,
    required this.desc,
    required this.govern,
    required this.lat,
    required this.lng,
  });

  factory BranchModel.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BranchModel(
      id: doc.id,
      desc: data['desc'],
      govern: data['govern'],
      lat: data['lat'],
      lng: data['lng'],
    );
  }
}
