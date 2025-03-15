import 'package:flutter/material.dart';

class CreateJobViewBody extends StatefulWidget {
  const CreateJobViewBody({super.key});

  @override
  State<CreateJobViewBody> createState() => _CreateJobViewBodyState();
}

class _CreateJobViewBodyState extends State<CreateJobViewBody> {
  final List<String> experienceLevels = ["Entry Level, 0-1 Years Of Experience", "Junior, 1-3 Years Of Experience", "Senior, 3-5 Years Of Experience", "Team Lead, 5+ Years Of Experience"];
  final List<String> technicalSkills = ["JavaScript", "React", "Node.js", "Flutter", "Django", "Python", "Angular", "Swift", "Kotlin"];
  final List<String> workingTimes = ["Full Time", "Part Time", "Internship"];
  final List<String> workLocations = ["On-Site", "Remote", "Hybrid"];

  // late final GlobalKey<FormState> _formKey;
  // late AutovalidateMode _autovalidatemodel;
  // late final JobModel _jobModel;

  @override
  void initState() {
    // _formKey = GlobalKey<FormState>();
    // _autovalidatemodel = AutovalidateMode.disabled;
    // _jobModel = JobModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).iconTheme.color,
      ),
    );
    // return Scaffold(
    //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //   appBar: AppBar(
    //     forceMaterialTransparency: true,
    //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //     foregroundColor: Theme.of(context).iconTheme.color,
    //   ),
    //   body: Form(
    //     key: _formKey,
    //     autovalidateMode: _autovalidatemodel,
    //     child: Stack(
    //       children: [
    //         CustomScrollView(
    //           slivers: [
    //             SliverFillRemaining(
    //               hasScrollBody: false,
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 16),
    //                 child: Column(
    //                   spacing: 14,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const SizedBox(height: 6),
    //                     CustomTextField(
    //                       hintText: "Job Title",
    //                       onSaved: (value) {
    //                         _jobModel.title = value!;
    //                       },
    //                     ),
    //                     CustomTextField(
    //                       hintText: "Company Name",
    //                       onSaved: (value) {
    //                         _jobModel.company = value!;
    //                       },
    //                     ),
    //                     CustomTextField(
    //                       hintText: "Company Location",
    //                       onSaved: (value) {
    //                         _jobModel.company = value!;
    //                       },
    //                     ),
    //                     MyDropdown(
    //                       label: "Experience Level",
    //                       items: experienceLevels,
    //                       onChanged: (value) {
    //                         _jobModel.experience = value!;
    //                       },
    //                     ),
    //                     MyDropdown(
    //                       label: "Technical Skills",
    //                       items: technicalSkills,
    //                       onChanged: (value) {
    //                         _jobModel.technicalSkills.add(value!);
    //                       },
    //                     ),
    //                     MyDropdown(
    //                       label: "Working Time",
    //                       items: workingTimes,
    //                       onChanged: (value) {
    //                         _jobModel.workingTime = value!;
    //                       },
    //                     ),
    //                     MyDropdown(
    //                       label: "Work Location",
    //                       items: workLocations,
    //                       onChanged: (value) {
    //                         _jobModel.workLocation = value!;
    //                       },
    //                     ),
    //                     CustomTextField(
    //                       hintText: "Job Description",
    //                       maxLines: 5,
    //                       onSaved: (value) {
    //                         _jobModel.description = value!;
    //                       },
    //                     ),
    //                     const SizedBox(height: 100),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         Positioned(
    //           bottom: 20,
    //           left: 20,
    //           right: 20,
    //           child: CustomButton(
    //             onPressed: () {
    //               if (_formKey.currentState!.validate()) {
    //                 _formKey.currentState!.save();
    //               } else {
    //                 _autovalidatemodel = AutovalidateMode.always;
    //                 setState(() {});
    //               }
    //             },
    //             text: "Post Job",
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
