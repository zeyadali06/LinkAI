class JobModel {
  String title;
  String company;
  String companyLocation;
  String experience;
  String technicalSkills;
  String description;
  String timeAgo;
  String workingTime;
  String workLocation;

  JobModel({
    required this.title,
    required this.company,
    required this.companyLocation,
    required this.experience,
    required this.technicalSkills,
    required this.description,
    required this.timeAgo,
    required this.workingTime,
    required this.workLocation,
  });

  factory JobModel.init() {
    return JobModel(
      title: '',
      company: '',
      companyLocation: '',
      experience: '',
      technicalSkills: '',
      description: '',
      timeAgo: '',
      workingTime: '',
      workLocation: '',
    );
  }
}
