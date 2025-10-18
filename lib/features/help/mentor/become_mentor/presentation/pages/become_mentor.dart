import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

/// TODO:
/// This should likely send a form and we can evaluate it before allowing just anyone to be a mentor
class BecomeMentor extends StatelessWidget {
  BecomeMentor({super.key});

  final _formKey = GlobalKey<FormState>();

  final _controllers = {
    'First Name': TextEditingController(),
    'Last Name': TextEditingController(),
    'Email': TextEditingController(),
    'Phone': TextEditingController(),
    'Expertise': TextEditingController(),
    'Description': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    final buttons = {
      'Cancel': () {
        context.go('/home');
      },
      'Submit': () {
        if (_formKey.currentState!.validate()) {
          // your submit logic, e.g.:
          final firstName = _controllers['First Name']!.text;
          final lastName = _controllers['Last Name']!.text;
          final email = _controllers['Email']!.text;
          final phone = _controllers['Phone']!.text;
          final expertise = _controllers['Expertise']!.text;
          final description = _controllers['Description']!.text;
          // … call your API, show a dialog, etc.
        }
      },
    };

    return AppPage(
      isScrollable: true,
      padding: const EdgeInsets.all(24),
      title: 'Become Mentor',
      widgets: [
        Stack(
          children: [
            CircleAvatar(radius: 80, backgroundColor: Theme.of(context).colorScheme.primary),
            Positioned(
              left: 108,
              top: 115,
              child: IconButton(
                icon: Icon(Icons.add_a_photo, size: 35, color: Theme.of(context).colorScheme.secondary),
                onPressed: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
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
        children: buttons.entries.map((entry) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: (MediaQuery.sizeOf(context).width / 2) - 24,
                child: FilledButton(onPressed: entry.value, child: Text(entry.key)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
