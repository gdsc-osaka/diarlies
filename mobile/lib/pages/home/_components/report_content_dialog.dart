import 'package:diarlies/components/nb_text_field.dart';
import 'package:diarlies/shared/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../components/nb_button.dart';
import '../../../components/nb_dialog.dart';
import '../../../components/variant.dart';
import '../../../i18n/strings.g.dart';

class ReportContentDialog extends HookWidget {
  const ReportContentDialog({super.key, required this.onCancel, required this.onSubmit});

  final FutureOrCallback onCancel;
  final FutureOrCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final report = useState('');

    return NBDialog(title: Text(t.home.dialog.report_title),
        content: NBTextField(
          value: report.value,
          onChanged: (value) {
            report.value = value;
          },
          placeholder: t.home.dialog.report_content,
        ),
        actions: [
          NBButton(
            label: Text(t.home.btn.cancel),
            variant: Variant.secondary,
            onPressed: onCancel,
          ),
          NBButton(
            label: Text(t.home.btn.report),
            onPressed: report.value.isEmpty ? null : onSubmit,
          )
        ]);
  }
}
