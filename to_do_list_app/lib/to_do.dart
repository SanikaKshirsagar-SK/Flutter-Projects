
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:to_do_list_app/to_do_model.dart';

// class ToDoApp extends StatefulWidget {
//   const ToDoApp({super.key});

//   @override
//   State<ToDoApp> createState() => _ToDoAppState();
// }

// class _ToDoAppState extends State<ToDoApp> {
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descController = TextEditingController();
//   TextEditingController dateController = TextEditingController();

//   List cardList = [
//     ToDoModelClass(
//       title: "Study",
//       description: "Deep Learning study...",
//       date: "10 July 2023",
//     ),
//     ToDoModelClass(
//       title: "To-do list app ",
//       description: "Make changes in app... ",
//       date: "10 July 2023",
//     ),
//   ];

//   var colorsList = [
//     const Color.fromRGBO(76, 71, 105, 1),
//     const Color.fromRGBO(59, 51, 85, 1),
//     const Color.fromRGBO(41, 36, 59, 1),
//     const Color.fromRGBO(37, 33, 54, 1)
//   ];

//   void showBottomSheet(bool doEdit, [ToDoModelClass? modelObj]) {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return Padding(
//               padding: EdgeInsets.only(
//                 left: 20,
//                 right: 20,
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "Create Task",
//                     style: GoogleFonts.quicksand(
//                         fontWeight: FontWeight.w900, fontSize: 25),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Title",
//                         style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w600, fontSize: 15),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       TextField(
//                         controller: titleController,
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         )),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "Description",
//                         style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w600, fontSize: 15),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       TextField(
//                         controller: descController,
//                         maxLines: 3,
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                         )),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         "Date",
//                         style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w600, fontSize: 15),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       TextField(
//                         controller: dateController,
//                         readOnly: true,
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10)),
//                             ),
//                             suffixIcon: Icon(
//                               Icons.calendar_month_rounded,
//                             )),
//                         onTap: () async {
//                           //pick date from datepicker
//                           DateTime? pickDate = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2023),
//                               lastDate: DateTime(2025));
//                           //format date into required format of date i.e. Y M D
//                           String dateFormat =
//                               DateFormat.yMMMd().format(pickDate!);
//                           setState(() {
//                             dateController.text = dateFormat;
//                           });
//                         },
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Container(
//                     height: 40,
//                     width: 350,
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(25)),
//                     child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             shape: const OvalBorder(),
//                             backgroundColor:
//                                 const Color.fromRGBO(2, 167, 177, 1)),
//                         onPressed: () {
//                           doEdit ? addTask(doEdit, modelObj) : addTask(doEdit);

//                           Navigator.of(context).pop();
//                         },
//                         child: Text("Submit",
//                           style: GoogleFonts.quicksand(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 25,
//                             color : Colors.white
//                           ),
//                         ),
//                     )
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                 ],
//               ));
//         });
//   }

//   void addTask(bool doEdit, [ToDoModelClass? modelObj]) {
//     if (titleController.text.trim().isNotEmpty &&
//         descController.text.trim().isNotEmpty &&
//         dateController.text.trim().isNotEmpty) {
//       if (!doEdit) {
//         setState(() {
//           cardList.add(ToDoModelClass(
//               title: titleController.text.trim(),
//               description: descController.text.trim(),
//               date: dateController.text.trim()));
//         });
//       } else {
//         setState(() {
//           modelObj?.title = titleController.text.trim();
//           modelObj?.description = descController.text.trim();
//           modelObj?.date = dateController.text.trim();
//         });
//       }
//     }
//     clearController();
//   }

//   void clearController() {
//     titleController.clear();
//     descController.clear();
//     dateController.clear();
//   }

//   void removeTask(ToDoModelClass modalObj) {
//     setState(() {
//       cardList.remove(modalObj);
//     });
//   }

//   void editTask(ToDoModelClass modelObj) {
//     titleController.text = modelObj.title;
//     descController.text = modelObj.description;
//     dateController.text = modelObj.date;
//     showBottomSheet(true, modelObj);
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: Text(
//           "To-Do List",
//           style: GoogleFonts.quicksand(
//             fontWeight: FontWeight.w900,
//             fontSize: 12,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color.fromRGBO(34, 30, 49, 1),
//       ),
//       body: ListView.builder(
//         itemCount: cardList.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 10,
//               horizontal: 10,
//             ),
//             child: Container(
//                 decoration: BoxDecoration(
//                   color: colorsList[index % colorsList.length],
//                   boxShadow: const [
//                     BoxShadow(
//                         offset: Offset(0, 10),
//                         color: Color.fromRGBO(119, 81, 68, 0.5),
//                         blurRadius: 5),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                               height: 80,
//                               width: 80,
//                               decoration: const BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Image.asset(
//                                     "assets/white.png",
//                                     fit: BoxFit.fill,
//                                   )),
//                           const SizedBox(width: 5),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   cardList[index].title,
//                                   style: GoogleFonts.quicksand(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text(
//                                   cardList[index].description,
//                                   style: GoogleFonts.quicksand(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Row(
//                           children: [
//                             Text(
//                               cardList[index].date,
//                               style: GoogleFonts.quicksand(
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 12,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const Spacer(),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 GestureDetector(
//                                   child: const Icon(
//                                     color: Colors.white,
//                                     size: 30,
//                                     Icons.edit_note_rounded,
//                                   ),
//                                   onTap: () {
//                                     editTask(cardList[index]);
//                                   },
//                                 ),
//                                 GestureDetector(
//                                   child: const Icon(                                                                                                                      
//                                     color:Colors.white,
//                                     size: 30,
//                                     Icons.delete_outline_outlined),
//                                   onTap: () {
//                                     removeTask(cardList[index]);
//                                   },
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           clearController();
//           showBottomSheet(false);
//         },
//         backgroundColor: const Color.fromRGBO(34, 30, 49, 1),
//         child: Text("Add",
//           style: GoogleFonts.quicksand(
//             fontWeight: FontWeight.w900,
//             fontSize: 12,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
