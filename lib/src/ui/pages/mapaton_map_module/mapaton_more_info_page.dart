import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constants.dart';
import '../../widgets/ecozonas_image.dart';
import '../../widgets/my_app_bar.dart';

class MapatonMoreInfoPage extends StatelessWidget {
  static const routeName = 'moreInfo';

  const MapatonMoreInfoPage({super.key});

  final _letterSpacing = 0.75;
  final _height = 1.5;
  final _style = const TextStyle(
    color: Constants.labelTextColor,
    fontSize: 16
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          AppLocalizations.of(context)!.webPlatform,
          style: const TextStyle(fontSize: Constants.appBarFontSize)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          child: Column(
            children: [
              const EcozonasImage(topPadding: 20, bottomPadding: 20),
              RichText(
                text: TextSpan(
                  style: _style.copyWith(
                    letterSpacing: _letterSpacing,
                    height: _height
                  ),
                  children: [
                    TextSpan(
                      text: '${AppLocalizations.of(context)!.moreInfoIntro}\n\n'
                    ),
                    _numberIndent(
                      1,
                      '${AppLocalizations.of(context)!.moreInfo1}\n'
                    ),
                    _numberIndent(
                      2,
                      '${AppLocalizations.of(context)!.moreInfo2}\n'
                    ),
                    _numberIndent(
                      3,
                      '${AppLocalizations.of(context)!.moreInfo3}\n'
                    ),
                    _numberIndent(
                      4,
                      '${AppLocalizations.of(context)!.moreInfo4}\n'
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.moreInfo5
                    ),
                  ]
                ),
              ),
              const SizedBox(height: Constants.paddingLarge),
              Image.asset('assets/images/more_info_chart.png'),
              const SizedBox(height: Constants.padding),
              Image.asset('assets/images/more_info_map.png'),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /*
   * WIDGETS
   */
  WidgetSpan _numberIndent(int number, String text) {
    final style = _style.copyWith(
      letterSpacing: _letterSpacing,
      height: _height
    );

    return WidgetSpan(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$number. ', style: style),
          Flexible(child: Text(text, style: style))
        ],
      )
    );
  }
}