import 'package:flutter/material.dart';

import 'oprations.dart';

class FirebaseOperation extends StatefulWidget {
  final String updateId;
  final dynamic data;

  const FirebaseOperation(
      {Key? key, required this.updateId, required this.data})
      : super(key: key);

  @override
  _FirebaseOperationState createState() => _FirebaseOperationState();
}

class _FirebaseOperationState extends State<FirebaseOperation> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    widget.data != '' ? titleController.text = widget.data['title'] : '';
    widget.data != '' ? descriptionController.text = widget.data['description'] : '';
    super.initState();
  }

  static final _priorities = ["High", "Low"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          title: DropdownButton(
            items: _priorities.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            // style: textStyle,
            // value: getPriorityAsString(note.priority),
            onChanged: (valueSelectedByUser) {
              setState(() {
                debugPrint("User selected $valueSelectedByUser");
                // updatePriorityAsInt(valueSelectedByUser);
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextFormField(
            controller: titleController,
            // style: textStyle,
            onChanged: (value) {
              debugPrint("Something changed in titleTextile");
              // updateTitle();
              //createDb();
            },
            decoration: InputDecoration(
                labelText: "Title",
                // labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: TextFormField(
            controller: descriptionController,
            onChanged: (value) {
              debugPrint("Something changed in DescriptionTextile");
            },
            decoration: InputDecoration(
                labelText: "Description".toString(),
                // labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        debugPrint("save button");

                        Opration().createDb(data: {
                          'title': titleController.text,
                          'description': descriptionController.text
                        });
                        Navigator.pop(context, true);
                      });
                    },
                    child: Text(
                      "Save",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    )),
              ),
              const SizedBox(width: 5.0),
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        debugPrint("update button");
                        //
                        Opration().updateDb(data: {
                          'title': titleController.text,
                          'description': descriptionController.text
                        }, docId: widget.updateId);
                        Navigator.pop(context, true);
                      });
                    },
                    child: Text(
                      "Update",
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    )),
              )
            ],
          ),
        ),
      ],
    ));
  }
}
