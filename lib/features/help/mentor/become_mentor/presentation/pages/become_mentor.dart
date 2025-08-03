import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

class BecomeMentor extends StatelessWidget {
  BecomeMentor({super.key});

  final _formKey = GlobalKey<FormState>();

  final _controllers = {'Name': TextEditingController(), 'Email': TextEditingController()};

  @override
  Widget build(BuildContext context) {
    final _buttons = {
      'Cancel': () {
        context.go('/home');
      },
      'Submit': () {
        if (_formKey.currentState!.validate()) {
          // your submit logic, e.g.:
          final name = _controllers['Name']!.text;
          final email = _controllers['Email']!.text;
          // … call your API, show a dialog, etc.
        }
      },
    };

    return AppPage(
      padding: const EdgeInsets.all(24),
      title: 'Become Mentor',
      widgets: [
        Form(
          key: _formKey,
          child: Column(
            children: _controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CustomTextField(controller: entry.value, label: entry.key),
              );
            }).toList(),
          ),
        ),
      ],
      // Change button stlye for cancel
      navBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buttons.entries.map((entry) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: (MediaQuery.sizeOf(context).width / 2) - 24,
                child: FilledButton(child: Text(entry.key), onPressed: entry.value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
