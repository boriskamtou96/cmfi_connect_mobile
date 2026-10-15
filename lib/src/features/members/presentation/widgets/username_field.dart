import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/theme/app_icons.dart';
import '../../../../core/theme/app_motion.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/adaptive.dart';
import '../../../../core/widgets/labeled_field.dart';
import '../../domain/member.dart';
import '../../infrastructure/members_api.dart';

/// The pseudo field: "@" in front, checked with the server while typing, and
/// free pseudos made from the name to pick from.
class UsernameField extends HookConsumerWidget {
  const UsernameField({
    required this.controller,
    this.firstName = '',
    this.lastName = '',
    this.current,
    this.autofill = false,
    super.key,
  });

  final TextEditingController controller;

  /// The name the suggestions are made from.
  final String firstName;
  final String lastName;

  /// The member's own pseudo (profile): theirs, not "taken".
  final String? current;

  /// Puts the first suggestion in the field until the user types their own.
  final bool autofill;

  static const _debounce = Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    useListenable(controller);
    final username = UsernameRules.normalize(controller.text);
    final isCurrent = username.isNotEmpty && username == current;
    final localProblem = username.isEmpty
        ? null
        : UsernameRules.check(username);

    final check = useState<UsernameCheck?>(null);
    final checking = useState(false);
    // typed or picked by the user: the suggestions no longer replace it
    final chosen = useRef(controller.text.isNotEmpty);
    final requestId = useRef(0);

    useEffect(() {
      final id = ++requestId.value;
      final askName = firstName.trim().isNotEmpty || lastName.trim().isNotEmpty;
      final askUsername =
          localProblem == null && !isCurrent && username.isNotEmpty;
      if (!askName && !askUsername) {
        return null;
      }
      // state changes wait for the timer: never during a build
      final timer = Timer(_debounce, () async {
        checking.value = askUsername;
        try {
          final result = await ref
              .read(membersApiProvider)
              .availability(
                username: askUsername ? username : '',
                firstName: firstName.trim(),
                lastName: lastName.trim(),
              );
          if (requestId.value != id || !context.mounted) {
            return;
          }
          check.value = result;
          if (autofill &&
              !chosen.value &&
              result.suggestions.isNotEmpty &&
              controller.text != result.suggestions.first) {
            controller.text = result.suggestions.first;
          }
        } on Object {
          // no answer: the server says it again when the form is sent
          if (requestId.value == id && context.mounted) {
            check.value = null;
          }
        } finally {
          if (requestId.value == id && context.mounted) {
            checking.value = false;
          }
        }
      });
      return timer.cancel;
    }, [username, firstName, lastName]);

    // the answer for what is typed now (an older one is for another pseudo)
    final answer = check.value?.username == username ? check.value : null;
    final problem = localProblem ?? answer?.problem;

    String? message(UsernameProblem? problem) => switch (problem) {
      UsernameProblem.invalid => t.members.usernameInvalid,
      UsernameProblem.reserved => t.members.usernameReserved,
      UsernameProblem.taken => t.members.usernameTaken,
      null => null,
    };

    final (IconData? icon, String text, Color color) = switch (()) {
      _ when username.isEmpty => (
        null,
        t.members.usernameHelp,
        scheme.onSurfaceVariant,
      ),
      _ when isCurrent => (
        AppIcons.checkCircleFilled,
        t.members.usernameCurrent,
        scheme.primary,
      ),
      _ when problem != null => (
        AppIcons.xCircleFilled,
        message(problem)!,
        scheme.error,
      ),
      _ when checking.value => (
        null,
        t.members.usernameChecking,
        scheme.onSurfaceVariant,
      ),
      _ when answer?.available ?? false => (
        AppIcons.checkCircleFilled,
        t.members.usernameFree(username: username),
        scheme.primary,
      ),
      _ => (null, t.members.usernameHelp, scheme.onSurfaceVariant),
    };

    final suggestions = [
      for (final suggestion in check.value?.suggestions ?? const <String>[])
        if (suggestion != username) suggestion,
    ];

    return LabeledField(
      label: t.members.username,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: controller,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newUsername],
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9._]')),
              TextInputFormatter.withFunction(
                (_, value) => value.copyWith(text: value.text.toLowerCase()),
              ),
              LengthLimitingTextInputFormatter(UsernameRules.maxLength),
            ],
            onChanged: (_) => chosen.value = true,
            decoration: InputDecoration(
              prefixText: '@',
              hintText: t.members.usernameHint,
              suffixIcon: checking.value
                  ? const Padding(
                      padding: EdgeInsets.all(14),
                      child: AppSpinner(size: 18, strokeWidth: 2),
                    )
                  : null,
            ),
            validator: (_) => username.isEmpty
                ? t.validation.required
                : isCurrent
                ? null
                : message(problem),
          ),
          const SizedBox(height: AppSpacing.xs + 2),
          Semantics(
            liveRegion: true,
            child: AnimatedSwitcher(
              duration: AppMotion.of(context, AppMotion.fast),
              child: Row(
                key: ValueKey(text),
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: color),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 13, color: color),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (suggestions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.xs,
              children: [
                for (final suggestion in suggestions)
                  ActionChip(
                    label: Text('@$suggestion'),
                    onPressed: () {
                      chosen.value = true;
                      controller.text = suggestion;
                    },
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
