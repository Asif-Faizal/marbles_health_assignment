// lib/features/dynamic_form/presentation/pages/my_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marble/features/dynamic_form/presentation/widgets/component_item.dart';
import '../bloc/form_bloc.dart';
import '../bloc/form_event.dart';
import '../bloc/form_state.dart' as DynamicFormState;

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Form'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              context.read<FormBloc>().add(SubmitFormEvent());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FormBloc, DynamicFormState.FormState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.components.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ComponentItem(
                          index: index,
                          component: state.components[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FormBloc>().add(AddComponentEvent());
                    },
                    child: Text('ADD'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
