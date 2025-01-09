class BranchModel {
  final String desc;
  final String govern;
  final double lat;
  final double lng;

  BranchModel({
    required this.desc,
    required this.govern,
    required this.lat,
    required this.lng,
  });

  factory BranchModel.fromJson(json) {
    return BranchModel(
      desc: json['desc'],
      govern: json['govern'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
