import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/createJob/presentation/views/widgets/my_dropdown.dart';
import 'package:linkai/features/home/domain/repo/job_repo.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';

class CreateJobViewBody extends StatefulWidget {
  final CompanyModel companyModel;
  const CreateJobViewBody({super.key, required this.companyModel});

  @override
  State<CreateJobViewBody> createState() => _CreateJobViewBodyState();
}

class _CreateJobViewBodyState extends State<CreateJobViewBody> {
  final List<String> experienceLevels = [
    "fresh",
    "Junior",
    "Mid-Level",
    "Senior",
    "Team-Lead",
    "CTO"
  ];
  final List<String> technicalSkills = [];
  final List<String> softSkills = [];
  final List<String> workingTimes = ["full-time", "part-time", "internship"];
  final List<String> workLocations = ["onsite", "remotely", "hybrid"];

  late final GlobalKey<FormState> _formKey;
  late final JobRepo jobRepo;
  late AutovalidateMode _autovalidatemodel;
  final TextEditingController technicalSkillsController =
      TextEditingController();
  final TextEditingController softSkillsController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController jobExperienceController = TextEditingController();
  final TextEditingController jobWorkingTimeController =
      TextEditingController();
  final TextEditingController jobWorkLocationController =
      TextEditingController();
  final TextEditingController jobCountryController = TextEditingController();

  void _addTechnicalSkill() {
    if (technicalSkillsController.text.isNotEmpty) {
      setState(() {
        technicalSkills.add(technicalSkillsController.text);
        technicalSkillsController.clear();
      });
    }
  }

  void _addSoftSkill() {
    if (softSkillsController.text.isNotEmpty) {
      setState(() {
        softSkills.add(softSkillsController.text);
        softSkillsController.clear();
      });
    }
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _autovalidatemodel = AutovalidateMode.disabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobsCubit, JobsState>(
      listener: (context, state) {
        if (state is JobCreated) {
          GoRouter.of(context).pop();
        }
        if (state is JobsError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            title: const Text("Create Job"),
            centerTitle: true,
            forceMaterialTransparency: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Theme.of(context).iconTheme.color,
          ),
          body: Form(
            key: _formKey,
            autovalidateMode: _autovalidatemodel,
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: 14,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 6),
                            CustomTextField(
                              hintText: "Job Title",
                              controller: jobTitleController,
                            ),
                            MyDropdown(
                              label: "Experience Level",
                              items: experienceLevels,
                              onChanged: (value) {
                                jobExperienceController.text = value!;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                      controller: technicalSkillsController,
                                      hintText: 'Technical Skills',
                                      keyboardType: TextInputType.text,
                                      enableValidator: false),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _addTechnicalSkill,
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 8,
                              children: technicalSkills
                                  .map((skill) => Chip(
                                        label: Text(skill),
                                        onDeleted: () {
                                          setState(() {
                                            technicalSkills.remove(skill);
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    controller: softSkillsController,
                                    hintText: 'Soft Skills',
                                    keyboardType: TextInputType.text,
                                    enableValidator: false,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: _addSoftSkill,
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                            Wrap(
                              spacing: 8,
                              children: softSkills
                                  .map((skill) => Chip(
                                        label: Text(skill),
                                        onDeleted: () {
                                          setState(() {
                                            softSkills.remove(skill);
                                          });
                                        },
                                      ))
                                  .toList(),
                            ),
                            CustomTextField(
                              hintText: "Job Country",
                              controller: jobCountryController,
                            ),
                            MyDropdown(
                              label: "Working Time",
                              items: workingTimes,
                              onChanged: (value) {
                                jobWorkingTimeController.text = value!;
                              },
                            ),
                            MyDropdown(
                              label: "Work Location",
                              items: workLocations,
                              onChanged: (value) {
                                jobWorkLocationController.text = value!;
                              },
                            ),
                            CustomTextField(
                              hintText: "Job Description",
                              maxLines: 5,
                              controller: jobDescriptionController,
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final jobModel = JobModel(
                          title: jobTitleController.text,
                          experience: jobExperienceController.text,
                          technicalSkills: technicalSkills,
                          softSkills: softSkills,
                          workingTime: jobWorkingTimeController.text,
                          workLocation: jobWorkLocationController.text,
                          description: jobDescriptionController.text,
                          company: widget.companyModel,
                          jobCountry: jobCountryController.text,
                        );
                        BlocProvider.of<JobsCubit>(context).addJob(jobModel);
                      } else {
                        _autovalidatemodel = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text: "Post Job",
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
