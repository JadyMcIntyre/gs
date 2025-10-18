import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:godsufficient/core/di/injection.dart';
import 'package:godsufficient/core/widgets/app_page.dart';
import 'package:godsufficient/core/widgets/text_field.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/domain/entities/mentor_application.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/domain/entities/mentor_attachment.dart';
import 'package:godsufficient/features/help/mentor/become_mentor/presentation/cubit/become_mentor_cubit.dart';

class BecomeMentor extends StatefulWidget {
  const BecomeMentor({super.key});

  @override
  State<BecomeMentor> createState() => _BecomeMentorState();
}

class _BecomeMentorState extends State<BecomeMentor> {
  static const _maxFileSizeBytes = 5 * 1024 * 1024; // 5MB
  static const List<String> _allowedExtensions = ['jpg', 'jpeg', 'png', 'pdf', 'doc', 'docx'];

  final _formKey = GlobalKey<FormState>();
  late final List<_FieldConfig> _fields;

  MentorApplicationAttachment? _attachment;
  Uint8List? _imagePreview;
  String? _selectedFileName;
  String? _selectedMimeType;

  @override
  void initState() {
    super.initState();
    _fields = [
      _FieldConfig(
        label: 'First Name',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'First Name'),
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Last Name',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'Last Name'),
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Email',
        controller: TextEditingController(),
        validator: _emailValidator,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Phone',
        controller: TextEditingController(),
        validator: _phoneValidator,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Expertise',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'Expertise'),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
      ),
      _FieldConfig(
        label: 'Description',
        controller: TextEditingController(),
        validator: (value) => _requiredValidator(value, 'Description'),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        minLines: 3,
      ),
    ];
  }

  @override
  void dispose() {
    for (final field in _fields) {
      field.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BecomeMentorCubit>(),
      child: BlocConsumer<BecomeMentorCubit, BecomeMentorState>(
        listener: (context, state) {
          if (state.status == BecomeMentorStatus.success) {
            for (final field in _fields) {
              field.controller.clear();
            }
            setState(() {
              _attachment = null;
              _imagePreview = null;
              _selectedFileName = null;
              _selectedMimeType = null;
            });
            _showSnackBar(context, 'Thanks! Your mentor submission was received.');
            context.read<BecomeMentorCubit>().reset();
          } else if (state.status == BecomeMentorStatus.failure && state.errorMessage != null) {
            _showSnackBar(context, state.errorMessage!, isError: true);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.isSubmitting;

          return AppPage(
            isScrollable: true,
            padding: const EdgeInsets.all(24),
            title: 'Become Mentor',
            widgets: [
              _buildAvatar(context, isSubmitting),
              const SizedBox(height: 12),
              Text(
                'Optionally include a profile image or supporting file (max 5MB).',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (_selectedFileName != null) ...[
                const SizedBox(height: 12),
                _AttachmentPreview(
                  fileName: _selectedFileName!,
                  mimeType: _selectedMimeType,
                  onRemove: isSubmitting ? null : _removeAttachment,
                ),
              ],
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: _fields
                      .map(
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
                      )
                      .toList(),
                ),
              ),
            ],
            navBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: (MediaQuery.sizeOf(context).width / 2) - 24,
                      child: FilledButton.tonal(
                        onPressed: isSubmitting
                            ? null
                            : () {
                                context.go('/grow');
                              },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: (MediaQuery.sizeOf(context).width / 2) - 24,
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, bool isSubmitting) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: color.withOpacity(0.15),
          backgroundImage: _imagePreview != null ? MemoryImage(_imagePreview!) : null,
          child: _imagePreview == null
              ? Icon(Icons.person_add_alt_1, size: 72, color: color.withOpacity(0.7))
              : null,
        ),
        Positioned(
          right: 16,
          bottom: 20,
          child: IconButton(
            icon: Icon(Icons.attach_file, size: 32, color: theme.colorScheme.secondary),
            onPressed: isSubmitting ? null : _pickFile,
            tooltip: 'Add attachment',
          ),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: _allowedExtensions,
      withData: true,
    );

    if (!mounted || result == null || result.files.isEmpty) return;

    final file = result.files.single;

    if ((file.size) > _maxFileSizeBytes) {
      _showSnackBar(context, 'File is larger than 5MB. Please choose a smaller file.', isError: true);
      return;
    }

    if (file.bytes == null) {
      _showSnackBar(context, 'Unable to read the selected file. Please try a different file.', isError: true);
      return;
    }

    final bytes = Uint8List.fromList(file.bytes!);
    final mimeType = _lookupMimeType(file.extension);
    final isImage = mimeType?.startsWith('image/') ?? false;

    setState(() {
      _attachment = MentorApplicationAttachment(bytes: bytes, name: file.name, mimeType: mimeType);
      _selectedFileName = file.name;
      _selectedMimeType = mimeType;
      _imagePreview = isImage ? bytes : null;
    });
  }

  String? _lookupMimeType(String? extension) {
    if (extension == null) return null;
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      default:
        return null;
    }
  }

  void _removeAttachment() {
    setState(() {
      _attachment = null;
      _selectedFileName = null;
      _selectedMimeType = null;
      _imagePreview = null;
    });
  }

  void _submit(BuildContext context) {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    final application = MentorApplication(
      firstName: _fields[0].controller.text.trim(),
      lastName: _fields[1].controller.text.trim(),
      email: _fields[2].controller.text.trim(),
      phone: _fields[3].controller.text.trim(),
      expertise: _fields[4].controller.text.trim(),
      description: _fields[5].controller.text.trim(),
    );

    context.read<BecomeMentorCubit>().submit(application, attachment: _attachment);
  }

  static String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? _emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailPattern.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? _phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone is required.';
    }
    final phonePattern = RegExp(r'^[+()\d\s-]{7,}$');
    if (!phonePattern.hasMatch(value.trim())) {
      return 'Please enter a valid phone number.';
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

class _AttachmentPreview extends StatelessWidget {
  const _AttachmentPreview({
    required this.fileName,
    this.mimeType,
    this.onRemove,
  });

  final String fileName;
  final String? mimeType;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        leading: Icon(
          mimeType?.startsWith('image/') ?? false ? Icons.image_outlined : Icons.insert_drive_file_outlined,
        ),
        title: Text(fileName),
        subtitle: Text(mimeType ?? 'Attachment'),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onRemove,
        ),
      ),
    );
  }
}
