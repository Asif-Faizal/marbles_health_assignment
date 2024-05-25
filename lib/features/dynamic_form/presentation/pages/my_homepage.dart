import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marble/features/dynamic_form/presentation/widgets/component_item.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart' as DynamicFormState;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<GlobalKey<FormState>> _formKeys = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Marbles Health'),
        actions: [
          TextButton(
            child: const Row(
              children: [
                Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              ],
            ),
            onPressed: () {
              bool allValid = true;
              for (var formKey in _formKeys) {
                if (!formKey.currentState!.validate()) {
                  allValid = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill out all fields'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                  break;
                }
              }
              if (allValid) {
                context.read<FormBloc>().add(SubmitFormEvent());
              }
            },
          ),
        ],
      ),
      body: BlocListener<FormBloc, DynamicFormState.FormState>(
        listener: (context, state) {
          if (state is DynamicFormState.FormSubmittedState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Form Submitted'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: state.components.map((component) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Component ${component.id + 1}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text('Label: ${component.label}'),
                              const SizedBox(height: 5),
                              Text('Info-text: ${component.infoText}'),
                              const SizedBox(height: 5),
                              Text('Settings: ${component.settings}'),
                              const Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        context.read<FormBloc>().add(ResetFormEvent());
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        child: BlocBuilder<FormBloc, DynamicFormState.FormState>(
          builder: (context, state) {
            _formKeys.clear();
            for (var i = 0; i < state.components.length; i++) {
              _formKeys.add(GlobalKey<FormState>());
            }
            return ListView.builder(
              itemCount: state.components.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ComponentItem(
                    index: index,
                    component: state.components[index],
                    formKey: _formKeys[index],
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomAppBar(
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<FormBloc>().add(AddComponentEvent());
                      },
                      child: const Text('ADD'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
