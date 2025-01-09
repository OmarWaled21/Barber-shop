class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? branchLocation;
  final String? branchGovern;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.branchLocation,
    this.branchGovern,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'branch_govern': branchGovern,
      'branch_location': branchLocation,
    };
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      branchGovern: json['branch_govern'],
      branchLocation: json['branch_location'],
    );
  }
}
