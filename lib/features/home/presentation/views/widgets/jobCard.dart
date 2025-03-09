import 'package:flutter/material.dart';
import 'package:linkai/features/home/presentation/views/widgets/jobTag.dart';
import 'package:linkai/features/jobDetails/presentation/views/widgets/jobDetails_view_body.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String companyLocation;
  final String experience;
  final String technicalSkills;
  final String timeAgo;
  final String workingTime;
  final String workLocation;
  final String description;

  const JobCard({
    super.key,
    required this.title,
    required this.company,
    required this.companyLocation,
    required this.experience,
    required this.technicalSkills,
    required this.timeAgo,
    required this.workingTime,
    required this.workLocation,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to Job Details Page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobdetailsViewBody(
              title: title,
              company: company,
              companyLocation: companyLocation,
              experience: experience,
              technicalSkills: technicalSkills,
              description: description,
              timeAgo: timeAgo,
              workingTime: workingTime,
              workLocation: workLocation,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job Title & Tags (Work Type + Work Location)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  JobTag(text: workingTime),
                  const SizedBox(width: 5),
                  JobTag(text: workLocation),
                ],
              ),

              const SizedBox(height: 5),

              // Company & Location
              Text(
                "$company - $companyLocation",
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              // Experience
              Text(experience, style: const TextStyle(color: Colors.white60)),
              const SizedBox(height: 5),

              // Technical Skills
              Text(technicalSkills,
                  style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 8),

              // Time Ago
              Text(timeAgo, style: const TextStyle(color: Colors.white38)),
            ],
          ),
        ),
      ),
    );
  }
}
