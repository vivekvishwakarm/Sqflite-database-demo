import 'package:flutter/material.dart';
import 'package:sqflite_database_demo/Data/local/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> allNotes = [];
  DbHelper? dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = DbHelper.getInstance;
    getNotes();
  }

  void getNotes() async {
    allNotes = await dbRef!.getAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data Base UI"),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
        itemCount: allNotes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${allNotes[index][DbHelper.COLUMN_NOTE_SNO]}'),
                  title: Text(allNotes[index][DbHelper.COLUMN_NOTE_TITLE]),
                  subtitle: Text(allNotes[index][DbHelper.COLUMN_NOTE_DECS]),
                );
              },
            )
          : const Center(
              child: Text("No Note yet"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbRef!.addNote(mTitle: "Title", mDesc: "I am boss");
          getNotes();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

