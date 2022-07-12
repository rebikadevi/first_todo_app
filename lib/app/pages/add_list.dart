import 'package:flutter_todo_app/app/providers.dart';
import 'package:flutter_todo_app/models/list.dart';
import 'package:flutter_todo_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'dart:io';

class AddListPage extends ConsumerStatefulWidget {
  const AddListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddListPageState();
}

class _AddListPageState extends ConsumerState<AddListPage> {
  final titleTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomInputFieldFb1(
                  inputController: titleTextEditingController,
                  hintText: 'List Name',
                  labelText: 'ListName'),
              const SizedBox(height: 15),
              // ElevatedButton(
              //     onPressed: () async {
              //       final DateTime? createdTime = await showDatePicker(
              //         context: context,
              //         initialDate: DateTime(2020, 11, 17),
              //         firstDate: DateTime(2017, 1),
              //         lastDate: DateTime(2022, 7),
              //         helpText: 'Select a date',
              //       );
              //     },
              //     child: const Text('Select date')),
              ElevatedButton(
                  onPressed: () => _addList(), child: const Text("Add List")),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  _addList() async {
    final storage = ref.read(databaseProvider);

    if (storage == null) {
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }

    await storage.addList(Todo(
        title: titleTextEditingController.text, formatedDate: DateTime.now()));
    openIconSnackBar(
      context,
      "List added successfully",
      const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
    Navigator.pop(context);
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const CustomInputFieldFb1(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = Colors.indigo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
