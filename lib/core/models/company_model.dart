class CompanyModel {
  final String id;
  final String companyName;
  final String description;
  final String industry;
  final String address;
  final String companyEmail;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final String numberOfEmployees;
  final List<String> HRs;
  final bool approvedByAdmin;

  CompanyModel({
    required this.id,
    required this.companyName,
    required this.description,
    required this.industry,
    required this.address,
    required this.companyEmail,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.numberOfEmployees,
    required this.HRs,
    required this.approvedByAdmin,
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
      'numberOfEmployees': numberOfEmployees,
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
      numberOfEmployees: json['numberOfEmployees'] ?? '',
      HRs: List<String>.from(json['HRs'] ?? []),
      approvedByAdmin: json['approvedByAdmin'] ?? false,
    );
  }

}
