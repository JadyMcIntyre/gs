import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/navigation/min_app.dart';
import 'package:godsufficient/core/widgets/text_field.dart';

import '../../data/datasources/remote/app_suggestion_remote_data_source_impl.dart';
import '../../data/repo/app_suggestion_repo_impl.dart';
import '../../domain/entities/app_suggestion.dart';
import '../../domain/entities/app_suggestion_record.dart';
import '../cubit/app_suggestion_cubit.dart';

class SuggestAppPage extends StatefulWidget {
  const SuggestAppPage({super.key});

  @override
  State<SuggestAppPage> createState() => _SuggestAppPageState();
}

class _SuggestAppPageState extends State<SuggestAppPage> {
  final _formKey = GlobalKey<FormState>();
  late final List<_FieldConfig> _fields;
  final _tagsController = TextEditingController();
  AppSuggestionRecord? _editingRecord;
  bool _prefilled = false;

  @override
  void initState() {
    super.initState();
    _fields = [
      _FieldConfig(
        label: 'App name',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'App name'),
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
        label: 'Logo URL',
        controller: TextEditingController(),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'App Store URL',
        controller: TextEditingController(),
        keyboardType: TextInputType.url,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Play Store URL',
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
    if (extra is AppSuggestionRecord) {
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
    final repo = AppSuggestionRepoImpl(
      AppSuggestionRemoteDataSourceImpl(FirebaseFirestore.instance),
      FirebaseAuth.instance,
    );

    return BlocProvider(
      create: (_) => AppSuggestionCubit(repo),
      child: BlocConsumer<AppSuggestionCubit, AppSuggestionState>(
        listener: (context, state) {
          if (state.status == AppSuggestionStatus.success) {
            for (final field in _fields) {
              field.controller.clear();
            }
            _tagsController.clear();
            _editingRecord = null;
            context.push('/suggestions', extra: const {'showSubmissionDialog': true});
          } else if (state.status == AppSuggestionStatus.failure && state.errorMessage != null) {
            _showSnackBar(context, state.errorMessage!, isError: true);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.isSubmitting;
          return MinAppScaffold(
            title: _editingRecord == null ? 'Suggest an app' : 'Update app suggestion',
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Share an app you think belongs in Grow > Apps.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
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
                        hint: 'faith, prayer, bible',
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: isSubmitting ? null : () => _submit(context),
                      child: isSubmitting
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
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

    final suggestion = AppSuggestion(
      name: _fields[0].controller.text.trim(),
      description: _fields[1].controller.text.trim().isEmpty ? null : _fields[1].controller.text.trim(),
      logoUrl: _fields[2].controller.text.trim().isEmpty ? null : _fields[2].controller.text.trim(),
      appStoreUrl: _fields[3].controller.text.trim().isEmpty ? null : _fields[3].controller.text.trim(),
      playStoreUrl: _fields[4].controller.text.trim().isEmpty ? null : _fields[4].controller.text.trim(),
      tags: tags,
    );

    final editing = _editingRecord;
    if (editing != null) {
      context.read<AppSuggestionCubit>().update(editing.id, suggestion);
    } else {
      context.read<AppSuggestionCubit>().submit(suggestion);
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
      SnackBar(content: Text(message), backgroundColor: isError ? Theme.of(context).colorScheme.error : null),
    );
  }

  void _prefill(AppSuggestionRecord record) {
    _fields[0].controller.text = record.suggestion.name;
    _fields[1].controller.text = record.suggestion.description ?? '';
    _fields[2].controller.text = record.suggestion.logoUrl ?? '';
    _fields[3].controller.text = record.suggestion.appStoreUrl ?? '';
    _fields[4].controller.text = record.suggestion.playStoreUrl ?? '';
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
