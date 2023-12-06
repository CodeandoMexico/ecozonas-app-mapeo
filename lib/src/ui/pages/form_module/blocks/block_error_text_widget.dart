import 'package:flutter/widgets.dart';

import '../../../utils/constants.dart';

class BlockErrorTextWidget extends StatelessWidget {
  final bool showError;

  const BlockErrorTextWidget({super.key, required this.showError});

  @override
  Widget build(BuildContext context) {
    return showError ? const Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text('* Este campo es obligatorio', style: TextStyle(color: Constants.redColor)),
    ) : Container();
  }
}