import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_table_tracker_flutter/screens/add_task_screen.dart';
import 'package:time_table_tracker_flutter/servies/database.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';
import 'package:time_table_tracker_flutter/utils/text_styles.dart';
import 'package:time_table_tracker_flutter/widgets/primary_button.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:time_table_tracker_flutter/widgets/snackbar.dart';
import 'package:time_table_tracker_flutter/widgets/task_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDateTime = DateTime.now();
  Stream<QuerySnapshot>? tasks;

  @override
  void initState() {
    // TODO: implement initState
    getAllTask();
    super.initState();
  }

  void getAllTask() {
    setState(() {
      tasks = Database().getTasks(_selectedDateTime);
    });
    print("Tasking is comming.......,,,,.........");
    print(tasks);
  }

  void deleteTask(String docId) async {
    final bool deleteTaskStatus = await Database().deleteTask(docId);
    if (deleteTaskStatus) {
      showSnackBar(context, "Task Successfully Deleted");
    } else {
      showSnackBar(context, "Something went wrong");
    }
  }

  void makeTaskComplete(String docId , bool completeStatus) async {
    final Map taskCompleteStatus =
        await Database().updateTaskToComplete(docId, completeStatus);
    if (taskCompleteStatus['success']) {
      showSnackBar(context, taskCompleteStatus['msg']);
    } else {
            showSnackBar(context, taskCompleteStatus['err']);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TTracker",
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(
                        DateTime.now(),
                      ),
                      style: kSubHeadingTextStyle,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      "Today",
                      style: kHeadingTextStyle,
                    ),
                  ],
                ),
                PrimaryButton(
                  prefixIcon: Icons.add,
                  title: "Add",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddTaskScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectedTextColor: kWhiteColor,
                selectionColor: kPrimaryColor,
                
                dateTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                  // backgroundColor: Colors.white
                ),
                onDateChange: (value) {
                  setState(() {
                    _selectedDateTime = value;
                  });
                  getAllTask();
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: tasks,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: kPrimaryColor,
                      ),
                    );
                  }
                  if (snapshot.data!.docs.length == 0) {
                    return const Center(
                      child: Text(
                        "There are no Task for this timeline",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return TaskTile(
                        subject: snapshot.data!.docs[index]['subject'],
                        startTime: snapshot.data!.docs[index]['start_time'],
                        description: snapshot.data!.docs[index]['description'],
                        endTime: snapshot.data!.docs[index]['end_time'],
                        completed: snapshot.data!.docs[index]['completed'],
                        date: snapshot.data!.docs[index]['date'],
                        onTaskDeleteTap: () {
                          deleteTask(snapshot.data!.docs[index]['document_id']);
                          Navigator.pop(context);
                        },
                        onTaskCompleteTap: () {
                          makeTaskComplete(
                              snapshot.data!.docs[index]['document_id'], snapshot.data!.docs[index]['completed'] );
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
