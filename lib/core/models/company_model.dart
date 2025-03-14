class CompanyModel {
  final String? id;
  final String companyName;
  final String description;
  final String industry;
  final String address;
  final String companyEmail;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final int maxEmployees;
  final int minEmployees;
  final List<String> HRs;
  final bool? approvedByAdmin;
   String? coverImage;
   String? profileImage;
  final String? role;
  CompanyModel({
     this.id,
    required this.companyName,
    required this.description,
    required this.industry,
    required this.address,
    required this.companyEmail,
     this.createdBy,
     this.createdAt,
     this.updatedAt,
    required this.maxEmployees,
    required this.minEmployees,
    required this.HRs,
     this.approvedByAdmin,
    this.role,
    this.coverImage,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'description': description,
      'industry': industry,
      'address': address,
      'companyEmail': companyEmail,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'numberOfEmployees': {
        'from': minEmployees,
        'to': maxEmployees,
      },
      'HRs': HRs,
      'approvedByAdmin': approvedByAdmin,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['_id'] ?? '',
      companyName: json['companyName'] ?? '',
      description: json['description'] ?? '',
      industry: json['industry'] ?? '',
      address: json['address'] ?? '',
      companyEmail: json['companyEmail'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      coverImage: json['coverPic']?["secure_url"] ,
      profileImage: json['logo']?["secure_url"],
      maxEmployees: json['numberOfEmployees']?['to'] ?? 0,
      minEmployees: json['numberOfEmployees']?['from'] ?? 0,
      HRs: List<String>.from(json['HRs'] ?? []),
      approvedByAdmin: json['approvedByAdmin'] ?? false,
      role: json['userRole'] ,
    );
  }

}
