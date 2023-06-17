import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tracker_flutter/servies/database.dart';
import 'package:time_table_tracker_flutter/widgets/primary_button.dart';
import 'package:time_table_tracker_flutter/widgets/primary_input.dart';
import 'package:time_table_tracker_flutter/widgets/snackbar.dart';

import '../utils/colors.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void getDateFromUser() async {
    DateTime? _picker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );

    setState(() {
      _selectedDate = _picker;
    });
  }

  void getStartTimeFromUser() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        _startTime = time;
      });
    }
  }

  void getEndTimeFromUser() async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        _endTime = time;
      });
    }
  }

  void addTask() async {
    if (_subjectController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _startTime != null &&
        _endTime != null) {
      final bool addTaskStatus = await Database().addTask(
          _subjectController.text,
          _descriptionController.text,
          _selectedDate!,
          _startTime!,
          _endTime!);
      if (addTaskStatus) {
      showSnackBar(context, "Task Successfully Created");

        goBack();
      } else {
        showSnackBar(context, "Something went wrong");
      }
    } else {
      showSnackBar(context, "Subject and Description are required");
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kBlackColor),
          title: const Text(
            "Add Task",
            style: TextStyle(
              fontSize: 18,
              color: kBlackColor,
            ),
          ),
          actions: const [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.account_circle,
                size: 35,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                PrimaryInput(
                    controller: _subjectController, placeholder: "Subject"),
                const SizedBox(
                  height: 16,
                ),
                PrimaryInput(
                    controller: _descriptionController,
                    placeholder: "Description"),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryInput(
                  onTap: getDateFromUser,
                  controller: null,
                  placeholder: _selectedDate != null ? DateFormat.yMMMMd().format(_selectedDate!) : "Date",
                  readOnly: true,
                  postfixIcon: Icons.date_range,
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryInput(
                        onTap: getStartTimeFromUser,
                        placeholder: _startTime != null
                            ? "${_startTime!.hour} : ${_startTime!.minute}"
                            : "Start Time",
                        readOnly: true,
                        postfixIcon: Icons.date_range,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: PrimaryInput(
                        onTap: getEndTimeFromUser,
                        placeholder: _endTime != null
                            ? "${_endTime!.hour} : ${_endTime!.minute}"
                            : "End Time",
                        readOnly: true,
                        postfixIcon: Icons.date_range,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                  prefixIcon: Icons.done,
                  title: "Create",
                  onTap: addTask,
                )
              ],
            ),
          ),
        ));
  }
}
