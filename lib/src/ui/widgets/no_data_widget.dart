import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/constants.dart';
import 'ecozonas_image.dart';

class NoDataWidget extends StatelessWidget {
  final VoidCallback callback;

  const NoDataWidget({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36.0, 0, 36.0, 0),
      child: Column(
        children: [
          const EcozonasImage(topPadding: 96, bottomPadding: 76),
          Text(
            AppLocalizations.of(context)!.noDataYet,
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            onPressed: () => callback(),
            icon: const Icon(Icons.download, color: Constants.darkBlueColor),
            label: Text(AppLocalizations.of(context)!.download, style: const TextStyle(color: Constants.darkBlueColor, fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.yellowButtonColor,
              shadowColor: Constants.yellowButtonShadowColor,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
              )
            ),
          )
        ],
      ),
    );
  }
}