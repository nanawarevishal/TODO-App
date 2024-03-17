
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/Component/BottomNavigationBar.dart';
import 'package:to_do_app/Controller/AddTaskController.dart';
import 'package:to_do_app/Services/AddTaskPageServices.dart';
import 'package:to_do_app/Utils/ColorsList.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State createState() => _CreateTaskState();
}

class _CreateTaskState extends State {
  final TextEditingController _taskGroupController = TextEditingController();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _subTaskController = TextEditingController();

  final AddTaskController _controller = Get.put(AddTaskController());

  final GlobalKey<FormState> _formKey = GlobalKey();

  String dropDownValue = "Daily Task";

  DateTime? pickedDate = DateTime.now();
  
  void addDate() async {
    pickedDate = (await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2025)));

    String formatedDate = DateFormat.yMMMd().format(pickedDate!);
    _startDateController.text =formatedDate;
  }

  void addEndDate() async {
    pickedDate = (await showDatePicker(
        context: context,
        firstDate: pickedDate!,
        lastDate: DateTime(2025)));

    String formatedDate = DateFormat.yMMMd().format(pickedDate!);
    _endDateController.text =formatedDate;
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
        
      );});
      String formatedTime = DateFormat("h:mm a").format(DateTime(2022, 1, 1, picked_s!.hour, picked_s.minute));
      _startTimeController.text = formatedTime;
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 235, 235),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
			key: _formKey,
			child: Column(
			  crossAxisAlignment: CrossAxisAlignment.start,
			  children: [
				Row(
				  children: [
					IconButton(
						onPressed: () {
						  Get.to(() => BottomNavBarState());
						},
						icon: const Icon(
						  Icons.arrow_circle_left_outlined,
						  size: 40,
						)
								),
					const Spacer(),
					const Text(
					  "Add Tasks",
					  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
					),
					const Spacer(),
					IconButton(
						onPressed: () {},
						icon: const Icon(
						  Icons.notification_add_sharp,
						  size: 35,
						))
				  ],
				),
				const SizedBox(
				  height: 10,
				),
				Container(
				  height: 90,
				  padding: const EdgeInsets.only(
					  top: 18, bottom: 18, left: 18, right: 8),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Container(
						width: 40,
						height: 40,
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(7),
							color: Utils.imageBackGroundColor[
								0 % Utils.imageBackGroundColor.length]),
						child: Image.asset(
						  Utils.imageUrl[0 % Utils.imageUrl.length],
						  width: 30,
						  height: 30,
						),
					  ),
					  const SizedBox(
						width: 20,
					  ),
					  Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
						  const Text(
							"Task Group",
							style: TextStyle(
								fontSize: 16, fontWeight: FontWeight.w700),
						  ),
						  Obx(() => Text(_controller.dropDownValue.value))
						],
					  ),
					  DropdownButton<String>(
						underline: const SizedBox(),
						onChanged: (String? newValue) {
						  _controller.dropDownValue.value = newValue!;
						  _taskGroupController.text = newValue;
						},
						items: const [
							DropdownMenuItem(
								value: "Work",
								child: Text("Work")
							),
							DropdownMenuItem(
								value: "Office Project",
								child: Text("Office Project")
							),
							DropdownMenuItem(
								value: "Personal Project",
								child: Text("Personal Project")
							),
							DropdownMenuItem(
							  value: "Daily Task", 
							  child: Text("Daily Task")
							),
						],
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "Task Name",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
							TextFormField(
							  controller: _taskNameController,
							  decoration: const InputDecoration(
								  hintText: "Enter the title",
								  enabledBorder: OutlineInputBorder(
									  borderSide:
										  BorderSide(color: Colors.transparent))),
								validator: (value){
									if(value == null || value.isEmpty){
										return "Please Enter title";
									}else{
										return null;
									}
								},
							)
						  ],
						),
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "Description",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
							SizedBox(
							  width: MediaQuery.of(context).size.width,
							  child: TextFormField(
								controller: _descriptionController,
								keyboardType: TextInputType.multiline,
								maxLines: 3,
								textInputAction: TextInputAction.newline,
								decoration: const InputDecoration(
									hintText: "Enter the description",
									enabledBorder: OutlineInputBorder(
										borderSide: BorderSide(
											color: Colors.transparent))),
									validator: (value){
										if(value == null || value.isEmpty){
											return "Please Enter description";
										}else{
											return null;
										}
									},
							  	),
							)
						  ],
						),
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					// crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "Start Date",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
							TextFormField(
							  readOnly: true,
							  controller: _startDateController,
							  decoration: const InputDecoration(
								  hintText: "Pick Start Date",
								  enabledBorder: OutlineInputBorder(
									  borderSide:
										  BorderSide(color: Colors.transparent)),
								  suffixIcon: Icon(Icons.date_range_outlined)),
			
								  onTap: (){
									addDate();
								  },
								validator: (value){
									if(value == null || value.isEmpty){
										return "Please Enter Start Date";
									}else{
										return null;
									}
								},
							)
						  ],
						),
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					// crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "End Date",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
							TextFormField(
							  readOnly: true,
							  controller: _endDateController,
							  decoration: const InputDecoration(
								  hintText: "Pick End Date",
								  enabledBorder: OutlineInputBorder(
									  borderSide:
										  BorderSide(color: Colors.transparent)),
								  suffixIcon: Icon(Icons.date_range_outlined)),
			
								  onTap: (){
									if(_startDateController.text==''){

									}
									else{
										addEndDate();
									}
								  },
								validator: (value){
									if(value == null || value.isEmpty){
										return "Please Enter End Date";
									}else{
										return null;
									}
								},
							)
						  ],
						),
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "Start Time",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
							TextFormField(
							  readOnly: true,
							  onTap: (){
								_selectTime(context);
							  },
							  controller: _startTimeController,
							  decoration: const InputDecoration(
								  hintText: "Pick Start Time",
								  enabledBorder: OutlineInputBorder(
									  borderSide:
										  BorderSide(color: Colors.transparent)),
								  suffixIcon: Icon(Icons.date_range_outlined)),

								validator: (value){
									if(value == null || value.isEmpty){
										return "Please Enter start time";
									}else{
										return null;
									}
								},
							)
						  ],
						),
					  ),
					],
				  ),
				),
				Container(
				  padding: const EdgeInsets.all(18),
				  margin: const EdgeInsets.only(bottom: 15),
				  decoration: BoxDecoration(
					  border: Border.all(
						  color: const Color.fromARGB(255, 227, 227, 227)),
					  color: Colors.white,
					  borderRadius: BorderRadius.circular(18)),
				  child: Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
					  Expanded(
						child: Column(
						  crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
							const Text(
							  "Add Subtask",
							  style: TextStyle(
								  fontSize: 16, fontWeight: FontWeight.w700),
							),
			
							Obx(() =>ListView.builder(
								padding: const EdgeInsets.all(3),
								shrinkWrap: true,
								physics: const ScrollPhysics(),
								itemCount: _controller.subTask.length,
								itemBuilder: (BuildContext context, int index) {
								  return Container(
									  margin: const EdgeInsets.only(bottom: 4),
									child: Text("${index+1}. ${_controller.subTask[index]}"),
								  );
								})
							  ),
			
							  const SizedBox(height: 8,),
							GestureDetector(
							  onTap: () {
								_subTaskController.clear();
								showDialog(
								  context: context,
								  builder: (BuildContext context) {
									return AlertDialog(
									  title: const Text('Enter Subtask'),
									  content: TextFormField(
									  controller: _subTaskController,
										keyboardType: TextInputType.multiline,
										maxLines: 3,
										textInputAction: TextInputAction.newline,
										decoration: const InputDecoration(
										  hintText: "Enter the subtask",
										  border: OutlineInputBorder(),
										),
										validator: (value){
											if(value == null || _controller.subTask.isEmpty){
												return "Please Enter subTask";
											}else{
												return null;
											}
										},
									  ),
									  actions: <Widget>[
										TextButton(
										  onPressed: () {
											Navigator.of(context)
												.pop(); // Close the dialog
										  },
										  child: const Text('Cancel'),
										),
										TextButton(
										  onPressed: () {
											_controller.subTask.add(_subTaskController.text);
											Navigator.of(context)
												.pop(); // Close the dialog
										  },
										  child: const Text('Submit'),
										),
									  ],
									);
								  },
								);
							  },
							  child: const SizedBox(
								child: Icon(Icons.add),
							  ),
							)
						  ],
						),
					  ),
					],
				  ),
				),
				GestureDetector(
					onTap: (){

						bool validate =  _formKey.currentState!.validate();
						if(validate){
							AddTaskService.addTask(taskGroupController: _taskGroupController, taskNameController: _taskNameController, descriptionController: _descriptionController, startDateController: _startDateController, endDateController: _endDateController, startTimeController: _startTimeController, controller: _controller);
							
							_taskGroupController.clear();
							_descriptionController.clear();
							_taskNameController.clear();
							_startDateController.clear();
							_endDateController.clear();
							_startTimeController.clear();
							_controller.subTask.clear();
						}

					},
					child: Center(
						child: Container(
							alignment: Alignment.center,
							height: 45,
							width: 300,
							decoration: BoxDecoration(
								color: const Color.fromARGB(255, 28, 5, 237),
								borderRadius: BorderRadius.circular(14)),
							child: const Text(
								"Add Task",
								style: TextStyle(
									fontSize: 18,
									fontWeight: FontWeight.w600,
									color: Colors.white),
							),
						),
					),
				),
			  ],
			),
		  ),
        ),
      ),
    );
  }
}
