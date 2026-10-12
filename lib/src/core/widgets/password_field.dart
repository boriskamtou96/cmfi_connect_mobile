import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../i18n/strings.g.dart';
import '../theme/app_icons.dart';
import 'labeled_field.dart';

/// Password with a show / hide button. Requires at least 6 characters, like the API.
class PasswordField extends HookWidget {
  const PasswordField({
    required this.controller,
    this.isNewPassword = false,
    this.helper,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;

  /// Lets the password manager suggest a new password (sign-up).
  final bool isNewPassword;
  final String? helper;
  final VoidCallback? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final obscure = useState(true);

    return LabeledField(
      label: t.auth.password,
      helper: helper,
      child: TextFormField(
        controller: controller,
        obscureText: obscure.value,
        textInputAction: onSubmitted == null
            ? TextInputAction.next
            : TextInputAction.done,
        autofillHints: [
          isNewPassword ? AutofillHints.newPassword : AutofillHints.password,
        ],
        onFieldSubmitted: onSubmitted == null ? null : (_) => onSubmitted!(),
        decoration: InputDecoration(
          hintText: '••••••••',
          suffixIcon: IconButton(
            tooltip: obscure.value ? t.auth.showPassword : t.auth.hidePassword,
            icon: Icon(obscure.value ? AppIcons.visible : AppIcons.hidden),
            onPressed: () => obscure.value = !obscure.value,
          ),
        ),
        validator: (value) {
          if ((value ?? '').isEmpty) {
            return t.validation.required;
          }
          return value!.length < 6 ? t.validation.passwordTooShort : null;
        },
      ),
    );
  }
}
