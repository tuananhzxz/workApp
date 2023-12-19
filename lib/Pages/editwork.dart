import 'package:flutter/material.dart';
import 'package:workspace/Class/work.dart';
import 'package:workspace/Model/textfield.dart';
import 'package:workspace/Pages/workhome.dart';
import 'package:workspace/SQLite/database.dart';
import 'package:workspace/Values/app_color.dart';
import 'package:workspace/Values/app_font.dart';

class editWork extends StatefulWidget {
  const editWork({super.key, this.work});
  final Work? work;

  @override
  State<editWork> createState() => _editWorkState();
}

class _editWorkState extends State<editWork> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  final db = DatabaseW();

  @override
  void initState() {
    titleController.text = widget.work?.title ?? "";
    contentController.text = widget.work?.content ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: MyColor.backgroundcolor),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const workHome()));
                    },
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          delete(widget.work?.workId);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.save_as_rounded),
                        onPressed: () {
                          createWork(widget.work?.workId);
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  "ADD WORK",
                  style: MyFont.h3.copyWith(color: Colors.white),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      textfield(hint: "Enter title", textCTL: titleController),
                      textfield(
                          hint: "Enter content", textCTL: contentController),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Create work successful"),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Hope you have a nice working day"),
                Text("Thank you very much!")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const workHome()),
                  );
                },
                child: const Text("Ok"))
          ],
        );
      },
    );
  }

  createWork(int? id) async {
    if (id == null && titleController.text != "" || contentController.text != "") {
    
      var result = await db.createWork(
          Work(title: titleController.text, content: contentController.text));
      if (result > 0) {
        if (!mounted) return;
        _showMyDialog();
        // wo{rkList.add(Work(title: titleController.text, content: contentController.text));
      }
    } else {
      await db.updateWork(widget.work?.workId ?? 0, titleController.text,
          contentController.text);
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const workHome()));
      });
    }
  }

  delete(int? id) async {
    var res = await db.delateWork(id ?? 0);
    if (res > 0) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const workHome()));
      });
    }
  }
}
