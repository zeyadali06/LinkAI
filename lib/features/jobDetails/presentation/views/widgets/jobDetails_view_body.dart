import 'package:flutter/material.dart';
import 'package:linkai/features/home/presentation/views/widgets/jobTag.dart';

class JobdetailsViewBody extends StatelessWidget {
  final String title;
  final String company;
  final String companyLocation;
  final String experience;
  final String technicalSkills;
  final String description;
  final String timeAgo;
  final String workingTime;
  final String workLocation;

  const JobdetailsViewBody({
    super.key,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // job title

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                // company name and location

                Text(
                  "$company - $companyLocation",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 15),
                const Divider(),

                // worklocation and workingtime

                const Text(
                  "Job Detials",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    JobTag(text: workingTime),
                    const SizedBox(width: 8),
                    JobTag(text: workLocation),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(),

                // experience

                const Text(
                  "Experience",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Text(
                  experience,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 15),
                const Divider(),

                // job desc

                const Text(
                  "Full Job Description",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 15),
                const Divider(),

                // tech skills
                const Text(
                  "Technical Skills",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  technicalSkills,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
          // button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Interview Now",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
