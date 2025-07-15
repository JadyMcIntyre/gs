import 'package:flutter/material.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

class FindMentor extends StatelessWidget {
  FindMentor({super.key});

  final _formKey = GlobalKey<FormState>();

  final _controllers = {'Name': TextEditingController(), 'Email': TextEditingController()};
  final _buttons = {'Cancel': () {}, 'Submit': () {}};

  @override
  Widget build(BuildContext context) {
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
                child: FilledButton(child: Text(entry.key), onPressed: () => entry.value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
