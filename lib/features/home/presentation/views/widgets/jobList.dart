import 'package:flutter/material.dart';
import 'package:linkai/features/home/presentation/views/widgets/jobCard.dart';

class JobsListPage extends StatelessWidget {
  const JobsListPage({super.key});

  final List<Map<String, String>> jobData = const [
    {
      "title": "Web & Mobile Apps Developer Expert",
      "company": "Microsoft",
      "companyLocation": "New Cairo, Cairo",
      "experience": "Entry Level - 1-3 Yrs of Exp",
      "technicalSkills": "JavaScript · HTML · CSS · Software Dev",
      "timeAgo": "16 days ago",
      "workingTime": "Part Time",
      "workLocation": "Hybrid",
    },
    {
      "title": "Senior Flutter Developer",
      "company": "Google",
      "companyLocation": "Alexandria",
      "experience": "Team Lead - 5+ Years of Exp",
      "technicalSkills": "Flutter · Dart · Firebase · UI/UX",
      "timeAgo": "5 days ago",
      "workingTime": "Internship",
      "workLocation": "Remote",
    },
    {
      "title": "Backend Developer",
      "company": "InnovateX",
      "companyLocation": "Berlin, Germany",
      "experience": "3-5 Years of Exp",
      "technicalSkills": "Node.js · Express · MongoDB · AWS",
      "timeAgo": "10 days ago",
      "workingTime": "Internship",
      "workLocation": "Remote",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobData.length,
      itemBuilder: (context, index) {
        final job = jobData[index];
        return JobCard(
          title: job["title"]!,
          company: job["company"]!,
          companyLocation: job["companyLocation"]!,
          experience: job["experience"]!,
          technicalSkills: job["technicalSkills"]!,
          timeAgo: job["timeAgo"]!,
          workingTime: job["workingTime"]!,
          workLocation: job["workLocation"]!,
        );
      },
    );
  }
}
