import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';
import 'package:time_table_tracker_flutter/widgets/primary_button.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.subject,
    required this.startTime,
    required this.description,
    required this.endTime,
    required this.completed,
    required this.date,
    required this.onTaskDeleteTap,
    required this.onTaskCompleteTap,
  });
  final String subject;
  final String description;
  final String endTime;
  final String startTime;
  final String date;
  final bool completed;
  final VoidCallback onTaskDeleteTap;
  final VoidCallback onTaskCompleteTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: completed ? Colors.teal : kPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: const TextStyle(
                    fontSize: 26,
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.0),
                      )),
                      backgroundColor: kBackgroundColor,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 40),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PrimaryButton(
                                prefixIcon: completed ? Icons.close : Icons.done,
                                title: completed ? "In Progress" : "Complete",
                                onTap: onTaskCompleteTap,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PrimaryButton(
                                backgroundColor: Colors.red,
                                prefixIcon: Icons.delete,
                                title: "Delete",
                                onTap: onTaskDeleteTap,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              PrimaryButton(
                                backgroundColor: kSecondaryColor,
                                prefixIcon: Icons.close,
                                title: "Cancel",
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.settings,
                  color: kWhiteColor,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 20,
              color: kWhiteColor.withOpacity(0.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.calendar,
                color: kWhiteColor.withOpacity(0.5),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  color: kWhiteColor.withOpacity(0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: kWhiteColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      startTime,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kWhiteColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      color: kWhiteColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      endTime,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: kWhiteColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
          const SizedBox(height: 12,),
          Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FaIcon(
                      completed ? Icons.done : FontAwesomeIcons.barsProgress,
                      color: kWhiteColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(completed ? "Complete": "In Progress", style: const TextStyle(fontSize: 16, color: kWhiteColor),),
                  ],
                ),
        ],
      ),
    );
  }
}
