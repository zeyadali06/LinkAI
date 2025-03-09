import 'package:flutter/material.dart';

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
                textField(titleController, "Job Title"),

                const SizedBox(height: 12),

                // company name
                textField(companyController, "Company Name"),

                const SizedBox(height: 12),

                // company location
                textField(locationController, "Company Location"),

                const SizedBox(height: 12),

                // experience
                dropDown(
                  "Experience Level",
                  experienceLevels,
                  selectedExperience,
                  (value) => setState(() => selectedExperience = value),
                ),

                const SizedBox(height: 12),

                // tech skills
                dropDown(
                  "Technical Skills",
                  technicalSkills,
                  selectedTechnicalSkill,
                  (value) => setState(() => selectedTechnicalSkill = value),
                ),

                const SizedBox(height: 12),

                // working time
                dropDown(
                  "Working Time",
                  workingTimes,
                  selectedWorkingTime,
                  (value) => setState(() => selectedWorkingTime = value),
                ),

                const SizedBox(height: 12),

                // work location
                dropDown(
                  "Work Location",
                  workLocations,
                  selectedWorkLocation,
                  (value) => setState(() => selectedWorkLocation = value),
                ),

                const SizedBox(height: 12),

                // job desc
                textField(descriptionController, "Job Description",
                    maxLines: 5),

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
                onPressed: () {
                  postJob();
                },
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

  // text field widget
  Widget textField(TextEditingController controller, String labelText,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
    );
  }

  // drop down widget
  Widget dropDown(String label, List<String> items, String? selectedValue,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white38),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[900],
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // button pressed
  void postJob() {
    if (titleController.text.isEmpty ||
        companyController.text.isEmpty ||
        locationController.text.isEmpty ||
        selectedExperience == null ||
        selectedTechnicalSkill == null ||
        selectedWorkingTime == null ||
        selectedWorkLocation == null ||
        descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill out all fields"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Job Posted Successfully!"),
        backgroundColor: Colors.green,
      ),
    );

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
}
