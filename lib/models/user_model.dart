class UserModel {
  final String name;
  final String email;
  final String phone;
  final String? branchLocation;
  final String? branchId;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    this.branchLocation,
    this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'branch_id': branchId,
      'branch_location': branchLocation,
    };
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      name: 'name',
      email: 'email',
      phone: 'phone',
      branchId: 'branch_id',
      branchLocation: 'branch_location',
    );
  }
}
