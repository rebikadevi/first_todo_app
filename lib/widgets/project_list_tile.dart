import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_todo_app/app/providers.dart';
import 'package:flutter_todo_app/models/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:flutter_todo_app/services/firestore_service.dart';
import 'package:flutter_todo_app/utils/snackbars.dart';

class ProductListTile extends ConsumerStatefulWidget {
  final Todo list;
  final Function()? onPressed;
  final Function() onDelete;

  const ProductListTile(
      {required this.list, required this.onDelete, this.onPressed, Key? key})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListTileState();
}

class _ProductListTileState extends ConsumerState<ProductListTile> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (c) => widget.onDelete(),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              // label: 'Delete',
            )
          ],
        ),
        child: SafeArea(
            child: StreamBuilder<List<Todo>>(
                stream: ref.read(databaseProvider)!.getList(),
                builder: (context, snapshot) {
                  if (widget.list.isDone = !widget.list.isDone) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.onPressed != null) widget.onPressed!();
                      },
                      child: Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.only(left: 6.0),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              offset: const Offset(10, 20),
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.grey.withOpacity(.05)),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width / 1.05,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.merge(
                                              new Border(
                                                  left: BorderSide(
                                                      color: Colors.red,
                                                      width: 3)),
                                              new Border(
                                                  left: BorderSide(
                                                      color: Colors.red,
                                                      width: 3)),
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              width: 13,
                                              height: 45,
                                            ),
                                            Text(widget.list.title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 209, 209, 209),
                                                  // color: false
                                                  //     ? Color.fromARGB(
                                                  //         255, 209, 209, 209)
                                                  //     : Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                )),
                                            new Spacer(),
                                            Text(
                                                DateFormat.jm().format(
                                                    widget.list.formatedDate!),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 209, 209, 209),
                                                  // color: false
                                                  //     ? Color.fromARGB(
                                                  //         255, 209, 209, 209)
                                                  //     : Colors.black,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 14,
                                                )),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            GFCheckbox(
                                              type: GFCheckboxType.circle,
                                              size: 28,
                                              inactiveBorderColor: Colors.green,
                                              activeBorderColor: Color.fromARGB(
                                                  50, 240, 65, 65),
                                              activeBgColor: Color.fromARGB(
                                                  73, 240, 65, 65),
                                              activeIcon: const Icon(
                                                Icons.check,
                                                size: 26,
                                                color: Color.fromARGB(
                                                    249, 255, 255, 255),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.list.isDone =
                                                      widget.list.isDone;
                                                });
                                                toggleTodoStatus(Todo(
                                                    id: widget.list.id,
                                                    formatedDate: widget
                                                        .list.formatedDate,
                                                    title: widget.list.title,
                                                    isDone:
                                                        widget.list.isDone));
                                              },
                                              autofocus: true,
                                              value: widget.list.isDone,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        if (widget.onPressed != null) widget.onPressed!();
                      },
                      child: Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.only(left: 6.0),
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              offset: const Offset(10, 20),
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.grey.withOpacity(.05)),
                        ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: screenSize.width / 1.05,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.merge(
                                              new Border(
                                                  left: BorderSide(
                                                      color: Colors.red,
                                                      width: 3)),
                                              new Border(
                                                  left: BorderSide(
                                                      color: Colors.red,
                                                      width: 3)),
                                            )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SizedBox(
                                              width: 13,
                                              height: 45,
                                            ),
                                            Text(widget.list.title,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  // color: false
                                                  //     ? Color.fromARGB(
                                                  //         255, 209, 209, 209)
                                                  //     : Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 12,
                                                )),
                                            new Spacer(),
                                            Text(
                                                DateFormat.jm().format(
                                                    widget.list.formatedDate!),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  // color: false
                                                  //     ? Color.fromARGB(
                                                  //         255, 209, 209, 209)
                                                  //     : Colors.black,
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 14,
                                                )),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            GFCheckbox(
                                              type: GFCheckboxType.circle,
                                              size: 28,
                                              inactiveBorderColor: Colors.green,
                                              activeBorderColor: Color.fromARGB(
                                                  50, 240, 65, 65),
                                              activeBgColor: Color.fromARGB(
                                                  73, 240, 65, 65),
                                              activeIcon: const Icon(
                                                Icons.check,
                                                size: 26,
                                                color: Color.fromARGB(
                                                    249, 255, 255, 255),
                                              ),

                                              // inactiveBgColor: GFColors.DANGER,
                                              onChanged: (value) {
                                                // _updateToggle();

                                                setState(() {
                                                  widget.list.isDone =
                                                      widget.list.isDone;
                                                  // !widget.list.isDone;
                                                });
                                                toggleTodoStatus(Todo(
                                                    id: widget.list.id,
                                                    formatedDate: widget
                                                        .list.formatedDate,
                                                    title: widget.list.title,
                                                    isDone:
                                                        widget.list.isDone));
                                              },
                                              // autofocus: true,
                                              value: widget.list.isDone,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    // FirestoreService.updateTodo(todo);
    // FirestoreService.toogleTodoStatus(String id);

    if (todo.isDone = !todo.isDone) {
      openIconSnackBar(
        context,
        " ${todo.title} is Pending...........",
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    } else {
      openIconSnackBar(
        context,
        " ${todo.title} is Completed",
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    }

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String id, bool isDone) {
    todo.title = title;
    // FirestoreService.updateTodo(todo);
  }
}
