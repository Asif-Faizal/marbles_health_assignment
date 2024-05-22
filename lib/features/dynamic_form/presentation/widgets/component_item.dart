import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';

class ComponentItem extends StatefulWidget {
  final int index;

  const ComponentItem({Key? key, required this.index}) : super(key: key);

  @override
  _ComponentItemState createState() => _ComponentItemState();
}

class _ComponentItemState extends State<ComponentItem> {
  final _textFieldController1 = TextEditingController();
  final _textFieldController2 = TextEditingController();
  int _radioValue = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Component ${widget.index + 1}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.index != 0)
                      ElevatedButton(
                          onPressed: () {
                            context
                                .read<FormBloc>()
                                .add(RemoveComponentEvent(widget.index));
                          },
                          child: Text('Delete')),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          context
                              .read<FormBloc>()
                              .add(RemoveComponentEvent(widget.index));
                        },
                        child: Text('Done'))
                  ],
                )
              ],
            ),
            TextField(
              controller: _textFieldController1,
              decoration: InputDecoration(hintText: 'Enter Label'),
            ),
            TextField(
              controller: _textFieldController2,
              decoration: InputDecoration(hintText: 'Enter Info-text'),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Settings'),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ...List.generate(
                  3,
                  (index) => Row(
                    children: [
                      Radio(
                        value: index,
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value as int;
                          });
                        },
                      ),
                      Text('Option ${index + 1}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
