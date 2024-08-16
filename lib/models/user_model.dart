class UserModel {
  final String id;
  final String? email;
  final String? name;
  final DateTime? createdAt;
  final Map<String, dynamic>? metadata;

  UserModel({
    required this.id,
    this.email,
    this.name,
    this.createdAt,
    this.metadata,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['UserModel_metadata']?['name'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      metadata: json['UserModel_metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'created_at': createdAt?.toIso8601String(),
      'UserModel_metadata': metadata,
    };
  }
}