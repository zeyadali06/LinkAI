import 'package:linkai/core/models/company_model.dart';

class JobModel {
  String id;
  String title;
  CompanyModel company;
  String experience;
  List<dynamic> technicalSkills;
  List<dynamic> softSkills;
  String description;
  String createdAt;
  String workingTime;
  String workLocation;

  JobModel({
    required this.id,
    required this.title,
    required this.company,
    required this.experience,
    required this.technicalSkills,
    required this.description,
    required this.createdAt,
    required this.workingTime,
    required this.workLocation,
    required this.softSkills,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'experience': experience,
      'technicalSkills': technicalSkills,
      'softSkills': softSkills,
      'description': description,
      'createdAt': createdAt,
      'workingTime': workingTime,
      'workLocation': workLocation,
    };
  }

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? '',
      title: json['jobTitle'] ?? '',
      company: CompanyModel.fromJson(json['companyId']),
      experience: json['seniorityLevel'] ?? '',
      technicalSkills: json['technicalSkills'] ?? [],
      softSkills: json['softSkills'] ?? [],
      description: json['jobDescription'] ?? '',
      createdAt: json['createdAt'] ?? '',
      workingTime: json['workingTime'] ?? '',
      workLocation: json['jobLocation'] ?? '',
    );
  }
}
