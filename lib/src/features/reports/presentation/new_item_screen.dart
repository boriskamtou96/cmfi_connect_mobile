import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/i18n/strings.g.dart';
import '../../../core/network/app_exception.dart';
import '../../../core/network/app_exception_message.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_tones.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_toast.dart';
import '../../../core/widgets/code_chip.dart';
import '../../../core/widgets/dashed_outline.dart';
import '../../../core/widgets/inline_error.dart';
import '../../../core/widgets/labeled_field.dart';
import '../../../core/widgets/section_card.dart';
import '../../../core/widgets/sub_page.dart';
import '../application/new_item_controller.dart';
import '../domain/measure_format.dart';
import 'widgets/measure_labels.dart';

/// Creates a personal item: code, name, and what it measures.
@RoutePage()
class NewItemScreen extends HookConsumerWidget {
  const NewItemScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final scheme = Theme.of(context).colorScheme;
    final tones = AppTones.of(context);
    final codeController = useTextEditingController();
    final labelController = useTextEditingController();
    final unitController = useTextEditingController();
    useListenable(codeController);
    useListenable(labelController);
    useListenable(unitController);
    final tracksQuantity = useState(true);
    final tracksDuration = useState(false);
    final state = ref.watch(newItemControllerProvider);
    // a refused request pops up at the top of the screen
    ref.listen(newItemControllerProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        ref.read(toasterProvider).of(context).error(switch (error) {
          ApiException(code: 'CONFLICT') => t.newItem.codeTaken,
          _ => userMessageFor(error, t),
        });
      }
    });

    final code = codeController.text.trim();
    final label = labelController.text.trim();
    final hasMeasure = tracksQuantity.value || tracksDuration.value;
    final canCreate = code.isNotEmpty && label.isNotEmpty && hasMeasure;

    Future<void> submit() async {
      FocusScope.of(context).unfocus();
      final toast = ref.read(toasterProvider).of(context);
      final created = await ref
          .read(newItemControllerProvider.notifier)
          .submit(
            code: code,
            label: label,
            tracksQuantity: tracksQuantity.value,
            unit: unitController.text,
            tracksDuration: tracksDuration.value,
          );
      if (created != null && context.mounted) {
        toast.success(t.newItem.created(code: created.code));
        await context.router.maybePop();
      }
    }

    Widget measureSwitch({
      required String title,
      required String subtitle,
      required ValueNotifier<bool> value,
    }) => MergeSemantics(
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
        ),
        value: value.value,
        onChanged: (enabled) => value.value = enabled,
      ),
    );

    return SubPage(
      title: t.newItem.title,
      bottom: Container(
        decoration: BoxDecoration(
          color: scheme.surface,
          border: Border(top: BorderSide(color: scheme.outlineVariant)),
        ),
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: AppButton(
          label: t.newItem.submit,
          isLoading: state.isLoading,
          onPressed: canCreate ? submit : null,
        ),
      ),
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: LabeledField(
                        label: t.newItem.code,
                        child: TextField(
                          controller: codeController,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.characters,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[A-Za-z0-9_]'),
                            ),
                            LengthLimitingTextInputFormatter(20),
                            _UpperCaseFormatter(),
                          ],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                          decoration: InputDecoration(
                            hintText: t.newItem.codeHint,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: LabeledField(
                        label: t.newItem.label,
                        child: TextField(
                          controller: labelController,
                          maxLength: 100,
                          textCapitalization: TextCapitalization.sentences,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: t.newItem.labelHint,
                            counterText: '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  t.newItem.help,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  t.newItem.measures,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                measureSwitch(
                  title: t.newItem.quantity,
                  subtitle: t.newItem.quantityHint,
                  value: tracksQuantity,
                ),
                if (tracksQuantity.value)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppSpacing.sm,
                      bottom: AppSpacing.md,
                    ),
                    child: LabeledField(
                      label: t.newItem.unit,
                      child: TextField(
                        controller: unitController,
                        maxLength: 30,
                        decoration: InputDecoration(
                          hintText: t.newItem.unitHint,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                const Divider(),
                measureSwitch(
                  title: t.newItem.duration,
                  subtitle: t.newItem.durationHint,
                  value: tracksDuration,
                ),
              ],
            ),
          ),
          if (!hasMeasure) ...[
            const SizedBox(height: 14),
            InlineError(t.newItem.noMeasure),
          ],
          const SizedBox(height: 18),
          SectionLabel(t.newItem.preview),
          const SizedBox(height: AppSpacing.sm),
          DashedOutline(
            color: scheme.outline,
            radius: 18,
            dash: 6,
            gap: 4,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 60),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    CodeChip(
                      code: code.isEmpty ? t.newItem.previewCode : code,
                      personal: true,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label.isEmpty ? t.newItem.previewLabel : label,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (hasMeasure)
                            Text(
                              measureSubtitle(
                                t,
                                quantity: tracksQuantity.value,
                                duration: tracksDuration.value,
                                unit: ItemUnit.typed(unitController.text),
                              ),
                              style: TextStyle(
                                fontSize: 12,
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: tones.personalSoft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        AppIcons.add,
                        size: 20,
                        color: tones.personal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => newValue.copyWith(text: newValue.text.toUpperCase());
}
