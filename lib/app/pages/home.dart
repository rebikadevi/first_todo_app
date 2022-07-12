import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_todo_app/app/pages/add_list.dart';
import 'package:flutter_todo_app/app/providers.dart';
import 'package:flutter_todo_app/models/list.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_todo_app/utils/snackbars.dart';
import 'package:flutter_todo_app/widgets/project_list_tile.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        appBar: AppBar(title: Center(child: const Text('Todo List')), actions: [
          IconButton(
              onPressed: () => ref.read(firebaseAuthProvider).signOut(),
              icon: const Icon(Icons.menu))
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddListPage())),
        ),
        body: SafeArea(
          child: StreamBuilder<List<Todo>>(
            stream: ref.read(databaseProvider)!.getList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.data != null) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text("No List yet...."),
                      Lottie.asset("assets/anim/empty.json",
                          width: 200, repeat: false),
                    ]),
                  );
                }
                return Flexible(
                    child: SingleChildScrollView(
                        child: SizedBox(
                  height: 700,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final list = snapshot.data![index];
                        print(snapshot.data!.length);

                        bool isSameDate = true;
                        final String dateString =
                            snapshot.data![index].formatedDate.toString();

                        final DateTime date = DateTime.parse(dateString);
                        final item = snapshot.data![index];
                        if (index == 0) {
                          isSameDate = false;
                        } else {
                          final String prevDateString =
                              snapshot.data![index - 1].formatedDate.toString();
                          final DateTime prevDate =
                              DateTime.parse(prevDateString);
                          isSameDate = date.isSameDate(prevDate);
                        }
                        if (index == 0 || !(isSameDate)) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(date.formatDate()),
                                  ],
                                ),
                              ),
                              ProductListTile(
                                list: list,
                                onDelete: () async {
                                  openIconSnackBar(
                                      context,
                                      "Deleting item....",
                                      const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ));
                                  await ref
                                      .read(databaseProvider)!
                                      .deleteList(list.id!);
                                },
                              ),
                            ],
                          );
                        } else {
                          return ProductListTile(
                            list: list,
                            onDelete: () async {
                              openIconSnackBar(
                                  context,
                                  "Deleting item....",
                                  const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ));
                              await ref
                                  .read(databaseProvider)!
                                  .deleteList(list.id!);
                            },
                          );
                        }
                      }),
                )));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('MMMM dd, y');
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}
