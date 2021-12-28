import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/src/provider.dart';
import 'package:todo_taksu/models/todos.dart';
import 'package:todo_taksu/ui/shared/styles.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  ScrollPhysics _physics = BouncingScrollPhysics();

  @override
  Widget build(BuildContext context) {
    var todo = context.watch<TodoModel>();

    return ListView.builder(
        physics: _physics,
        itemCount: todo.allTasks.length,
        itemBuilder: (context, index) {
          if (todo.allTasks[index].date!.isBefore(DateTime.now())) {
            todo.allTasks[index].status == "overdue";
          }

          return Container(
            padding: EdgeInsets.fromLTRB(30, 22, 18, 22),
            margin: EdgeInsets.only(top: 5, bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
                color: softBlack, borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: (todo.allTasks[index].date!
                                .isBefore(DateTime.now()))
                            ? red
                            : (todo.allTasks[index].status == "open")
                                ? grey
                                : (todo.allTasks[index].status == "done")
                                    ? green
                                    : red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10),
                        child: Text(
                          (todo.allTasks[index].date!.isBefore(DateTime.now()))
                              ? "OVERDUE"
                              : (todo.allTasks[index].status == "open")
                                  ? "OPEN"
                                  : (todo.allTasks[index].status == "done")
                                      ? "DONE"
                                      : "OVERDUE",
                          style: TextStyle(
                              color: (todo.allTasks[index].status == "open")
                                  ? fontBlack : (todo.allTasks[index].status == "done") ?
                                  Colors.white : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        todo.deleteTodo(todo.allTasks[index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: darkBlack,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  todo.allTasks[index].title!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        DateFormat("dd MMM yyy HH:mm")
                            .format(todo.allTasks[index].date!),
                        // todo.allTasks[index].date.toString(),
                        // "Due date: \n21 October 2021 07:30PM",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                    (todo.allTasks[index].status == "done")
                        ? SizedBox()
                        : Container(
                            width: 91,
                            height: 38,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: purple,
                                elevation: 0,
                              ),
                              onPressed: () {
                                setState(() {
                                  print(todo.allTasks[index].status);
                                  todo.allTasks[index].status = "done";
                                  print(todo.allTasks[index].status);
                                });
                              },
                              child: Text(
                                'DONE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
