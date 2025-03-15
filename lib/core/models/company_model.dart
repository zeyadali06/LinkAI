class CompanyModel {
   String? id;
   String companyName;
   String description;
   String industry;
   String address;
   String companyEmail;
   String? createdBy;
   String? createdAt;
   String? updatedAt;
   int maxEmployees;
   int minEmployees;
   List<String> HRs;
   String? coverImage;
   String? profileImage;
   String? role;
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
    this.role,
    this.coverImage,
    this.profileImage,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'description': description,
      'industry': industry,
      'address': address,
      'companyEmail': companyEmail,
      'numberOfEmployees': {
        'from': minEmployees,
        'to': maxEmployees,
      },
      'HRs': HRs,
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
      role: json['userRole'] ,
    );
  }
  void setFrom(CompanyModel other) {
    id = other.id;
    companyName = other.companyName;
    description = other.description;
    companyEmail = other.companyEmail;
    address = other.address;
    industry = other.industry;
    profileImage = other.profileImage;
    coverImage = other.coverImage;
    minEmployees = other.minEmployees;
    maxEmployees = other.maxEmployees;
    HRs = other.HRs;
    createdAt = other.createdAt;
    createdBy = other.createdBy;
    updatedAt = other.updatedAt;
  }
  CompanyModel copyWith({
    String? id,
    String? companyName,
    String? description,
    String? companyEmail,
    String? address,
    String? industry,
    String? profileImage,
    String? coverImage,
    int? minEmployees,
    int? maxEmployees,
    List<String>? HRs,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      companyEmail: companyEmail ?? this.companyEmail,
      address: address ?? this.address,
      industry: industry ?? this.industry,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
      minEmployees: minEmployees ?? this.minEmployees,
      maxEmployees: maxEmployees ?? this.maxEmployees,
      HRs: HRs ?? this.HRs,
    );
  }
}
