import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String company;
  final String companyLocation; // country , city , disctrict
  final String
      experience; // entry level , junior , senior OR number of years of experience
  final String technicalSkills;
  final String timeAgo;
  final String workingTime; // full time , part time , intern
  final String workLocation; // on-site , remote , hybrid

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
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    workingTime,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    workLocation,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            // Company & companyLocation
            Text(
              "$company - $companyLocation",
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            // Experience
            Text(
              experience,
              style: const TextStyle(color: Colors.white60),
            ),
            const SizedBox(height: 5),

            // technicalSkills
            Text(
              technicalSkills,
              style: const TextStyle(color: Colors.white),
            ),

            const SizedBox(height: 8),

            // Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timeAgo,
                  style: const TextStyle(color: Colors.white38),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
