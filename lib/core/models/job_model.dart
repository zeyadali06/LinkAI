import 'package:linkai/core/models/company_model.dart';

class JobModel {
  String? id;
  String title;
  CompanyModel company;
  String experience;
  List<dynamic> technicalSkills;
  List<dynamic> softSkills;
  String description;
  String? createdAt;
  String workingTime;
  String workLocation;
  String jobCountry;

  JobModel({
    this.id,
    required this.title,
    required this.company,
    required this.experience,
    required this.technicalSkills,
    required this.description,
    this.createdAt,
    required this.workingTime,
    required this.workLocation,
    required this.softSkills,
    required this.jobCountry,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': title,
      'company': company,
      'seniorityLevel': experience,
      'technicalSkills': technicalSkills,
      'softSkills': softSkills,
      'jobDescription': description,
      'createdAt': createdAt,
      'workingTime': workingTime,
      'jobLocation': workLocation,
      'jobCountry': jobCountry,
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
      jobCountry: json['jobCountry'] ?? '',
    );
  }

  String getFullJobApplication() {
    return "Job Title: $title\n Job Description: $description\n Experience: $experience\n Technical Skills: $technicalSkills\n Soft Skills: $softSkills";
  }
}
