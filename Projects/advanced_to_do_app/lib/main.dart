import 'package:flutter/material.dart';
import 'package:advanced_to_do_app/to_do_model.dart';
import 'database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await createDB();
      await getTask();
    });
  }

  List cardList = [
    // ToDoModelClass(
    //   title: "Study",
    //   description: "Deep Learning study...",
    //   date: "July 10, 2023",
    // ),
    // ToDoModelClass(
    //   title: "To-do list app ",
    //   description: "Make changes in app... ",
    //   date: "July 10, 2023",
    // ),
    // ToDoModelClass(
    //   title: "Study",
    //   description: "Deep Learning study...",
    //   date: "July 10, 2023",
    // ),
    // ToDoModelClass(
    //   title: "To-do list app ",
    //   description: "Make changes in app... ",
    //   date: "1July 10, 2023",
    // ),
    // ToDoModelClass(
    //   title: "Study",
    //   description: "Deep Learning study...",
    //   date: "July 10, 2023",
    // ),
    // ToDoModelClass(
    //   title: "To-do list app ",
    //   description: "Make changes in app... ",
    //   date: "July 10, 2023",
    // ),
  ];

  var colorsList = [
    const Color.fromRGBO(76, 71, 105, 0.2),
    const Color.fromRGBO(59, 51, 85, 0.4),
    const Color.fromRGBO(41, 36, 59, 0.6),
    const Color.fromRGBO(37, 33, 54, 0.8)
  ];
  List<bool> isDone = [false];

  void showBottomSheet(bool doEdit, [ToDoModelClass? modelObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(30)),
        ),
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Create Task",
                    style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w900, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: const Color.fromRGBO(34, 30, 49, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(
                            hintText: "Enter Title..",
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 15, 1, 15),
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Description",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: const Color.fromRGBO(34, 30, 49, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: descController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: "Enter Description..",
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 1, 1, 15),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Date",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: const Color.fromRGBO(34, 30, 49, 1)),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: dateController,
                          readOnly: true,
                          decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 15, 1, 15),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 15, 1, 15),
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 15, 1, 15),
                                ),
                              ),
                              suffixIcon: const Icon(
                                Icons.calendar_month_rounded,
                              )),
                          onTap: () async {
                            //pick date from datepicker
                            DateTime? pickDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2025));
                            //format date into required format of date i.e. Y M D
                            String dateFormat =
                                DateFormat.yMMMd().format(pickDate!);
                            setState(() {
                              dateController.text = dateFormat;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 40,
                      width: 250,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color.fromARGB(255, 15, 1, 15),
                        ),
                        onPressed: () {
                          doEdit ? submitButton(doEdit, modelObj) : submitButton(doEdit);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Submit",
                          style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.white),
                        ),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ));
        });
  }

  void submitButton(bool doEdit, [ToDoModelClass? modelObj]) async {
    if (titleController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          insertData(ToDoModelClass(
              title: titleController.text.trim(),
              description: descController.text.trim(),
              date: dateController.text.trim()));
        });
      } else {
        setState(() async {
          modelObj!.title = titleController.text.trim();
          modelObj.description = descController.text.trim();
          modelObj.date = dateController.text.trim();
        });
        await getTask();
        print(await getTask());

        setState(() {});
      }
    }
    clearController();
  }

  void clearController() {
    titleController.clear();
    descController.clear();
    dateController.clear();
  }

  void removeTask(ToDoModelClass modalObj) {
    setState(() {
      cardList.remove(modalObj);
    });
  }

  void editTask(ToDoModelClass modelObj) {
    titleController.text = modelObj.title;
    descController.text = modelObj.description;
    dateController.text = modelObj.date;
    showBottomSheet(true, modelObj);
  }

  Future getTask() async {
    List listData = await getData();
    setState(() {
      cardList = listData;
    });
  }

  @override
  Widget build(BuildContext context) {
    getTask();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: Text(
      //     "To-Do List",
      //     style: GoogleFonts.quicksand(
      //       fontWeight: FontWeight.w900,
      //       fontSize: 25,
      //       color: Colors.white,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: const Color.fromARGB(255, 15, 1, 15),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45)),
                color: Color.fromARGB(255, 15, 1, 15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30, top: 60),
                    // color: const Color.fromARGB(255, 15, 1, 15),
                    child: Text(
                      "Hello..",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w900,
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    // color: const Color.fromARGB(255, 15, 1, 15),
                    child: Text(
                      "Sanika",
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                    ),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "DASHBOARD",
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              // color: Color.fromARGB(255, 15, 1, 45),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cardList.length,
                              itemBuilder: (context, index) {
                                isDone.add(false);
                                return Slidable(
                                  closeOnScroll: true,
                                  endActionPane: ActionPane(
                                      extentRatio: 0.2,
                                      motion: const DrawerMotion(),
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            const SizedBox(height: 5),
                                            GestureDetector(
                                              child: const Icon(
                                                color: Colors.black,
                                                size: 30,
                                                Icons.edit_note_rounded,
                                              ),
                                              onTap: () {
                                                editTask(cardList[index]);
                                                Slidable.of(context)?.close();
                                              },
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              child: const Icon(
                                                  color: Colors.black,
                                                  size: 30,
                                                  Icons
                                                      .delete_outline_outlined),
                                              onTap: () {
                                                removeTask(cardList[index]);
                                                Slidable.of(context)?.close();
                                              },
                                            ),
                                          ],
                                        ))
                                      ]),
                                  key: ValueKey(index),
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20, top: 20),
                                      decoration: BoxDecoration(
                                          color: colorsList[
                                              index % colorsList.length],
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(0, 10),
                                                color: Color.fromRGBO(
                                                    119, 81, 68, 0.5),
                                                blurRadius: 5),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.5))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      // color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          "assets/white.png",
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  // child: Image.asset(
                                                  //   "assets/check1.png",
                                                  //   fit: BoxFit.cover,
                                                  // )
                                                  // ),
                                                ),
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${cardList[index].title}",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          "${cardList[index].description}",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          "${cardList[index].date}",
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 40),
                                                  child: Checkbox(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      activeColor: Colors.green,
                                                      value: true,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          isDone[index] =!
                                                              isDone[index];
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clearController();
          showBottomSheet(false);
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 15, 1, 15),
        // child: Text(
        //   "Add",
        //   style: GoogleFonts.quicksand(
        //     fontWeight: FontWeight.w900,
        //     fontSize: 15,
        //     color: Colors.white,
        //   ),
        // ),
        child: const Icon(
          size: 50,
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
 