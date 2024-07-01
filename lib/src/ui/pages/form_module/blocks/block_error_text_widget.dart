import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/constants.dart';

class BlockErrorTextWidget extends StatelessWidget {
  final bool showError;

  const BlockErrorTextWidget({super.key, required this.showError});

  @override
  Widget build(BuildContext context) {
    return showError ? Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text('* ${AppLocalizations.of(context)!.required}', style: const TextStyle(color: Constants.redColor)),
    ) : Container();
  }
}