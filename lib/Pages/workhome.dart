import 'package:flutter/material.dart';
import 'package:workspace/Class/work.dart';
import 'package:workspace/Model/textfield.dart';
import 'package:workspace/Pages/editwork.dart';
import 'package:workspace/SQLite/database.dart';
import 'package:workspace/Values/app_color.dart';
import 'package:workspace/Values/app_font.dart';

class workHome extends StatefulWidget {
  const workHome({super.key, this.work});
  final Work? work;

  @override
  State<workHome> createState() => _workHomeState();
}

class _workHomeState extends State<workHome> {
  final db = DatabaseW();

  List<Work> searchWorks = [];

  TextEditingController titleController = TextEditingController();

  // final db = DatabaseW();
  // List<Map<String, dynamic>> _allData = [];

  refreshData() async {
    final work = await db.getWork();
    setState(() {
      allData = work;
      searchWorks = allData;
    });
  }

  deleteWork(int? index) async {
    Work workDelete = searchWorks[index ?? 0];
    var res = await db.delateWork(workDelete.workId ?? 0);

    setState(() {
      if (res > 0) {
         refreshData();
    }
    });
  }

  cardClick(int index) async {
    setState(() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => editWork(
                    work: allData[index],
                  )));
    });
  }

  void searchWork(String searchText) async {
    setState(() {
      searchWorks = allData
          .where((work) =>
              work.content.toLowerCase().contains(searchText.toLowerCase()) ||
              work.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();

    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: MyColor.backgroundcolor,
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text("WorkSpace", style: MyFont.h3.copyWith(color: Colors.white)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    color: const Color.fromARGB(255, 241, 237, 202),
                    margin: const EdgeInsets.all(10),
                    child: textfield(
                      hint: "Search",
                      icon: Icons.search,
                      textCTL: titleController,
                      press: searchWork,
                    )),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: searchWorks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () {
                              cardClick(index);
                            },
                            title: RichText(
                              maxLines: 3,
                              text: TextSpan(
                                  text: searchWorks[index].title,
                                  style: MyFont.h5),
                            ),
                            subtitle: Text(searchWorks[index].content),
                            // subtitle: Text(work?.content),
                            trailing: IconButton(
                              onPressed: () {
                                deleteWork(index);
                              },
                              icon: const Icon(Icons.delete),
                              tooltip: "Remove",
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  trailing: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const editWork()),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
