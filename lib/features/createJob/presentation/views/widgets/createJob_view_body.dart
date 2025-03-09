import 'package:flutter/material.dart';
import 'my_textfield.dart';
import 'my_dropdown.dart';

class CreateJobViewBody extends StatefulWidget {
  const CreateJobViewBody({super.key});

  @override
  _CreateJobViewBodyState createState() => _CreateJobViewBodyState();
}

class _CreateJobViewBodyState extends State<CreateJobViewBody> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedExperience;
  String? selectedTechnicalSkill;
  String? selectedWorkingTime;
  String? selectedWorkLocation;

  final List<String> experienceLevels = [
    "Entry Level, 0-1 Years Of Experience",
    "Junior, 1-3 Years Of Experience",
    "Senior, 3-5 Years Of Experience",
    "Team Lead, 5+ Years Of Experience"
  ];

  final List<String> technicalSkills = [
    "JavaScript",
    "React",
    "Node.js",
    "Flutter",
    "Django",
    "Python",
    "Angular",
    "Swift",
    "Kotlin"
  ];

  final List<String> workingTimes = ["Full Time", "Part Time", "Internship"];
  final List<String> workLocations = ["On-Site", "Remote", "Hybrid"];

  void postJob() {
    titleController.clear();
    companyController.clear();
    locationController.clear();
    descriptionController.clear();
    setState(() {
      selectedExperience = null;
      selectedTechnicalSkill = null;
      selectedWorkingTime = null;
      selectedWorkLocation = null;
    });
  }

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
                MyTextField(
                    controller: titleController, labelText: "Job Title"),
                const SizedBox(height: 12),
                MyTextField(
                    controller: companyController, labelText: "Company Name"),
                const SizedBox(height: 12),
                MyTextField(
                    controller: locationController,
                    labelText: "Company Location"),
                const SizedBox(height: 12),
                MyDropdown(
                  label: "Experience Level",
                  items: experienceLevels,
                  selectedValue: selectedExperience,
                  onChanged: (value) =>
                      setState(() => selectedExperience = value),
                ),
                const SizedBox(height: 12),
                MyDropdown(
                  label: "Technical Skills",
                  items: technicalSkills,
                  selectedValue: selectedTechnicalSkill,
                  onChanged: (value) =>
                      setState(() => selectedTechnicalSkill = value),
                ),
                const SizedBox(height: 12),
                MyDropdown(
                  label: "Working Time",
                  items: workingTimes,
                  selectedValue: selectedWorkingTime,
                  onChanged: (value) =>
                      setState(() => selectedWorkingTime = value),
                ),
                const SizedBox(height: 12),
                MyDropdown(
                  label: "Work Location",
                  items: workLocations,
                  selectedValue: selectedWorkLocation,
                  onChanged: (value) =>
                      setState(() => selectedWorkLocation = value),
                ),
                const SizedBox(height: 12),
                MyTextField(
                    controller: descriptionController,
                    labelText: "Job Description",
                    maxLines: 5),
                const SizedBox(height: 80),
              ],
            ),
          ),
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
                onPressed: postJob,
                child: const Text(
                  "Post Job",
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
