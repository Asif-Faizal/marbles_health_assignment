import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marble/features/dynamic_form/domain/entities/component.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';

class ComponentItem extends StatefulWidget {
  final int index;
  final Component component;
  final GlobalKey<FormState> formKey;

  const ComponentItem({
    Key? key,
    required this.index,
    required this.component,
    required this.formKey,
  }) : super(key: key);

  @override
  _ComponentItemState createState() => _ComponentItemState();
}

class _ComponentItemState extends State<ComponentItem> {
  late TextEditingController _labelController;
  late TextEditingController _infoTextController;
  int _radioValue = 0;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.component.label);
    _infoTextController =
        TextEditingController(text: widget.component.infoText);
    _radioValue = _getRadioValueFromSettings(widget.component.settings);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _infoTextController.dispose();
    super.dispose();
  }

  int _getRadioValueFromSettings(String settings) {
    switch (settings) {
      case 'Required':
        return 0;
      case 'Read only':
        return 1;
      case 'Hidden':
        return 2;
      default:
        return 0;
    }
  }

  String _getSettingsFromRadioValue(int value) {
    switch (value) {
      case 0:
        return 'Required';
      case 1:
        return 'Read only';
      case 2:
        return 'Hidden';
      default:
        return 'Required';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Component ${widget.index + 1}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(
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
                          child: const Text('Delete'),
                        ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: const ButtonStyle(
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {},
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _labelController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Label';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter Label',
                ),
                onChanged: (value) {
                  _updateComponent();
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _infoTextController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Info-text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: 'Enter Info-text',
                ),
                onChanged: (value) {
                  _updateComponent();
                },
              ),
              const SizedBox(height: 20),
              const Text('Settings:'),
              const SizedBox(height: 10),
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
                                _updateComponent();
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

  void _updateComponent() {
    context.read<FormBloc>().add(
          UpdateComponentEvent(
            index: widget.index,
            component: widget.component.copyWith(
              label: _labelController.text,
              infoText: _infoTextController.text,
              settings: _getSettingsFromRadioValue(_radioValue),
            ),
          ),
        );
  }
}
