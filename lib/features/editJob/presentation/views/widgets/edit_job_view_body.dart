import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkai/core/models/job_model.dart';
import 'package:linkai/core/utils/app_styles.dart';
import 'package:linkai/core/widgets/custom_button.dart';
import 'package:linkai/core/widgets/custom_text_field.dart';
import 'package:linkai/core/widgets/snack_bar.dart';
import 'package:linkai/features/createJob/presentation/views/widgets/my_dropdown.dart';
import 'package:linkai/features/home/presentation/manager/jobs_cubit/jobs_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditJobViewBody extends StatefulWidget {
  final JobModel jobModel;
  const EditJobViewBody({super.key, required this.jobModel});

  @override
  State<EditJobViewBody> createState() => _EditJobViewBodyState();
}

class _EditJobViewBodyState extends State<EditJobViewBody> {
  final List<String> experienceLevels = ["fresh", "Junior", "Mid-Level", "Senior", "Team-Lead", "CTO"];
  final List<String> workingTimes = ["full-time", "part-time", "internship"];
  final List<String> workLocations = ["onsite", "remotely", "hybrid"];

  late final GlobalKey<FormState> _formKey;
  late AutovalidateMode _autovalidatemodel;
  late List<String> technicalSkills;
  late List<String> softSkills;

  final TextEditingController technicalSkillsController = TextEditingController();
  final TextEditingController softSkillsController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController jobDescriptionController = TextEditingController();
  final TextEditingController jobExperienceController = TextEditingController();
  final TextEditingController jobWorkingTimeController = TextEditingController();
  final TextEditingController jobWorkLocationController = TextEditingController();
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
    super.initState();
    _formKey = GlobalKey<FormState>();
    _autovalidatemodel = AutovalidateMode.disabled;

    // Initialize controllers with existing job data
    jobTitleController.text = widget.jobModel.title;
    jobDescriptionController.text = widget.jobModel.description;
    jobExperienceController.text = widget.jobModel.experience;
    jobWorkingTimeController.text = widget.jobModel.workingTime;
    jobWorkLocationController.text = widget.jobModel.workLocation;
    jobCountryController.text = widget.jobModel.jobCountry;

    // Initialize skills lists with existing data
    technicalSkills = List<String>.from(widget.jobModel.technicalSkills);
    softSkills = List<String>.from(widget.jobModel.softSkills);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<JobsCubit>();
    return BlocConsumer<JobsCubit, JobsState>(
      listener: (context, state) {
        if (state is JobUpdated) {
          showSnackBar(context, "Job updated successfully", backgroundColor: Colors.green);
          GoRouter.of(context).pop();
        }
        if (state is JobUpdatedError) {
          showSnackBar(context, state.message);
        }
        if (state is JobDeleted) {
          showSnackBar(context, "Job deleted successfully", backgroundColor: Colors.green);
          GoRouter.of(context).pop();
        }
        if (state is JobDeletedError) {
          showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is JobsLoading,
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidatemodel,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  CustomTextField(
                    hintText: "Job Title",
                    controller: jobTitleController,
                  ),
                  const SizedBox(height: 10),
                  MyDropdown(
                    label: "Experience Level",
                    items: experienceLevels,
                    value: jobExperienceController.text,
                    onChanged: (value) {
                      jobExperienceController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: technicalSkillsController,
                          hintText: 'Technical Skills',
                          keyboardType: TextInputType.text,
                          enableValidator: false,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        text: "Add",
                        fitWidth: false,
                        fontSize: 16,
                        onPressed: _addTechnicalSkill,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: technicalSkills
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
                            color: WidgetStatePropertyAll(Theme.of(context).inputDecorationTheme.fillColor!),
                            onDeleted: () {
                              setState(() {
                                technicalSkills.remove(skill);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 15),
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
                      CustomButton(
                        text: "Add",
                        fitWidth: false,
                        fontSize: 16,
                        onPressed: _addSoftSkill,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: softSkills
                        .map(
                          (skill) => Chip(
                            label: Text(skill),
                            color: WidgetStatePropertyAll(Theme.of(context).inputDecorationTheme.fillColor!),
                            onDeleted: () {
                              setState(() {
                                softSkills.remove(skill);
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Job Country",
                    controller: jobCountryController,
                  ),
                  const SizedBox(height: 10),
                  MyDropdown(
                    label: "Working Time",
                    items: workingTimes,
                    value: jobWorkingTimeController.text,
                    onChanged: (value) {
                      jobWorkingTimeController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyDropdown(
                    label: "Work Location",
                    items: workLocations,
                    value: jobWorkLocationController.text,
                    onChanged: (value) {
                      jobWorkLocationController.text = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Job Description",
                    maxLines: 5,
                    controller: jobDescriptionController,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final updatedJob = JobModel(
                          id: widget.jobModel.id,
                          title: jobTitleController.text,
                          experience: jobExperienceController.text,
                          technicalSkills: technicalSkills,
                          softSkills: softSkills,
                          workingTime: jobWorkingTimeController.text,
                          workLocation: jobWorkLocationController.text,
                          description: jobDescriptionController.text,
                          company: widget.jobModel.company,
                          jobCountry: jobCountryController.text,
                        );
                        BlocProvider.of<JobsCubit>(context).updateJob(updatedJob);
                      } else {
                        _autovalidatemodel = AutovalidateMode.always;
                        setState(() {});
                      }
                    },
                    text: "Update Job",
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Delete Job',
                    textColor: Colors.white,
                    buttonColor: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Delete Job',
                            style: AppStyles.semiBold18(context),
                          ),
                          content: Text(
                            'Are you sure you want to delete this Job?',
                            style: AppStyles.normal16(context),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => GoRouter.of(context).pop(),
                              child: Text(
                                'Cancel',
                                style: AppStyles.defaultStyle(context),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cubit.deleteJob(widget.jobModel);
                                GoRouter.of(context).pop();
                              },
                              child: Text(
                                'Delete',
                                style: AppStyles.defaultStyle(context, Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
