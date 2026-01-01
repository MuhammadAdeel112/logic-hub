import 'package:divine_employee_app/core/constants/app_constants.dart';
import 'package:divine_employee_app/view/jobs/presentation/provider/assigned_task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../models/assigned_jobs_model.dart';

class TasksWidet extends StatelessWidget {
  TasksWidet(
      {super.key, required this.jobId, required this.tasksForAssignedJobs});
  final bool isChecked = false;
  final List<Task> tasksForAssignedJobs;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    final taskforAssignedProvider =
        Provider.of<AssignedJobTaskProvider>(context);
    return Column(
      children: [
        Container(
            child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tasksForAssignedJobs
              .length, // Replace with the number of items you want in the list
          itemBuilder: (context, index) {
            Future.microtask(() {
              taskforAssignedProvider
                  .setCurrentTab(tasksForAssignedJobs.length);
            });
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: ShapeDecoration(
                  color: AppConstants.kcwhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: AppConstants.kShadows,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 21,
                            decoration: ShapeDecoration(
                              color: AppConstants.kcsecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4, right: 4, top: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Align text to the left
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.8,
                                  ),
                                  child: Text(
                                    tasksForAssignedJobs[index].title,
                                    style: AppConstants
                                        .kTextStyleSmallRegularBlack,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 16),
                        child: Column(
                          children: [
                            Checkbox(
                              activeColor: AppConstants.kcsecondaryColor,
                              value: taskforAssignedProvider.selectedTaskIds
                                  .contains(tasksForAssignedJobs[index].id),
                              onChanged: (value) {
                                taskforAssignedProvider.toggleTaskStatus(
                                    tasksForAssignedJobs[index].id);
                              },
                            ),
                            Text(
                              taskforAssignedProvider.selectedTaskIds
                                      .contains(tasksForAssignedJobs[index].id)
                                  ? 'Completed'
                                  : 'Pending',
                              style: AppConstants.kTextStyleSmallRegularBlack,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )),
      ],
    );
  }
}
