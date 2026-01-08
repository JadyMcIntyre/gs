import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

import '../../data/datasources/remote/help_center_suggestion_remote_data_source_impl.dart';
import '../../data/repo/help_center_suggestion_repo_impl.dart';
import '../../domain/entities/help_center_suggestion.dart';
import '../../domain/entities/help_center_suggestion_record.dart';
import '../cubit/help_center_suggestion_cubit.dart';

class AddHelpCenterPage extends StatefulWidget {
  const AddHelpCenterPage({super.key});

  @override
  State<AddHelpCenterPage> createState() => _AddHelpCenterPageState();
}

class _AddHelpCenterPageState extends State<AddHelpCenterPage> {
  final _formKey = GlobalKey<FormState>();
  late final List<_FieldConfig> _fields;
  final _tagsController = TextEditingController();
  HelpCenterSuggestionRecord? _editingRecord;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    _fields = [
      _FieldConfig(
        label: 'Name',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'Name'),
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Category ID',
        controller: TextEditingController(),
        hint: 'housing, food, counseling',
        validator: (value) => _requiredValidator(value, 'Category ID'),
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Description',
        controller: TextEditingController(),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        minLines: 3,
      ),
      _FieldConfig(
        label: 'Address',
        controller: TextEditingController(),
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Phone',
        controller: TextEditingController(),
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Website',
        controller: TextEditingController(),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Image URL',
        controller: TextEditingController(),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.next,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_prefilled) return;

    final extra = GoRouterState.of(context).extra;
    if (extra is HelpCenterSuggestionRecord) {
      _editingRecord = extra;
      _prefill(extra);
    }
    _prefilled = true;
  }

  @override
  void dispose() {
    for (final field in _fields) {
      field.controller.dispose();
    }
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repo = HelpCenterSuggestionRepoImpl(
      HelpCenterSuggestionRemoteDataSourceImpl(FirebaseFirestore.instance),
      FirebaseAuth.instance,
    );

    return BlocProvider(
      create: (_) => HelpCenterSuggestionCubit(repo),
      child: BlocConsumer<HelpCenterSuggestionCubit, HelpCenterSuggestionState>(
        listener: (context, state) {
          if (state.status == HelpCenterSuggestionStatus.success) {
            for (final field in _fields) {
              field.controller.clear();
            }
            _tagsController.clear();
            _editingRecord = null;
            context.push('/suggestions', extra: const {'showSubmissionDialog': true});
          } else if (state.status == HelpCenterSuggestionStatus.failure &&
              state.errorMessage != null) {
            _showSnackBar(context, state.errorMessage!, isError: true);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.isSubmitting;

          return AppPage(
            isScrollable: true,
            mainAxisAlignment: MainAxisAlignment.start,
            padding: const EdgeInsets.all(24),
            title: _editingRecord == null ? 'Add help centre' : 'Update help centre',
            widgets: [
              Text(
                'Share a help centre to include under Get help.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    ..._fields.map(
                      (field) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: CustomTextField(
                          controller: field.controller,
                          label: field.label,
                          hint: field.hint,
                          validator: field.validator,
                          keyboardType: field.keyboardType,
                          textInputAction: field.textInputAction,
                          maxLines: field.maxLines,
                          minLines: field.minLines,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomTextField(
                        controller: _tagsController,
                        label: 'Tags',
                        hint: 'local, shelter, outreach',
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isSubmitting ? null : () => _submit(context),
                        child: isSubmitting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _submit(BuildContext context) {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toSet()
        .toList();

    final suggestion = HelpCenterSuggestion(
      name: _fields[0].controller.text.trim(),
      categoryId: _fields[1].controller.text.trim(),
      description: _fields[2].controller.text.trim().isEmpty ? null : _fields[2].controller.text.trim(),
      address: _fields[3].controller.text.trim().isEmpty ? null : _fields[3].controller.text.trim(),
      phone: _fields[4].controller.text.trim().isEmpty ? null : _fields[4].controller.text.trim(),
      website: _fields[5].controller.text.trim().isEmpty ? null : _fields[5].controller.text.trim(),
      imageUrl: _fields[6].controller.text.trim().isEmpty ? null : _fields[6].controller.text.trim(),
      tags: tags,
    );

    final editing = _editingRecord;
    if (editing != null) {
      context.read<HelpCenterSuggestionCubit>().update(editing.id, suggestion);
    } else {
      context.read<HelpCenterSuggestionCubit>().submit(suggestion);
    }
  }

  static String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }

  void _prefill(HelpCenterSuggestionRecord record) {
    _fields[0].controller.text = record.suggestion.name;
    _fields[1].controller.text = record.suggestion.categoryId;
    _fields[2].controller.text = record.suggestion.description ?? '';
    _fields[3].controller.text = record.suggestion.address ?? '';
    _fields[4].controller.text = record.suggestion.phone ?? '';
    _fields[5].controller.text = record.suggestion.website ?? '';
    _fields[6].controller.text = record.suggestion.imageUrl ?? '';
    _tagsController.text = record.suggestion.tags.join(', ');
  }
}

class _FieldConfig {
  _FieldConfig({
    required this.label,
    required this.controller,
    this.validator,
    this.hint,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
  });

  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final String? hint;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;
}
