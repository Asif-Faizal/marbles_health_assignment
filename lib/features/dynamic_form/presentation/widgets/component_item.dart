import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marble/features/dynamic_form/domain/entities/component.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';

class ComponentItem extends StatefulWidget {
  final int index;
  final Component component;

  const ComponentItem({Key? key, required this.index, required this.component})
      : super(key: key);

  @override
  _ComponentItemState createState() => _ComponentItemState();
}

class _ComponentItemState extends State<ComponentItem> {
  final _formKey = GlobalKey<FormState>();
  final _textFieldController1 = TextEditingController();
  final _textFieldController2 = TextEditingController();
  int _radioValue = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Component ${widget.index + 1}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.index != 0)
                        ElevatedButton(
                            onPressed: () {
                              context.read<FormBloc>().add(RemoveComponentEvent(
                                  widget.index, widget.component));
                            },
                            child: const Text('Delete')),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          style: const ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          child: const Text('Done'))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LabelTextField(textFieldController1: _textFieldController1),
              SizedBox(
                height: 10,
              ),
              InfoTextField(textFieldController2: _textFieldController2),
              const SizedBox(
                height: 20,
              ),
              const Text('Settings:'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
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
                          Text(
                            index == 0
                                ? 'Required'
                                : index == 1
                                    ? 'Read only'
                                    : 'Hidden',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool validateForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      return true;
    }
    return false;
  }
}

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    super.key,
    required TextEditingController textFieldController1,
  }) : _textFieldController1 = textFieldController1;

  final TextEditingController _textFieldController1;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Label';
        }
        return null;
      },
      controller: _textFieldController1,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter Label'),
    );
  }
}

class InfoTextField extends StatelessWidget {
  const InfoTextField({
    super.key,
    required TextEditingController textFieldController2,
  }) : _textFieldController2 = textFieldController2;

  final TextEditingController _textFieldController2;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Info-text';
        }
        return null;
      },
      controller: _textFieldController2,
      decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          hintText: 'Enter Info-text'),
    );
  }
}
