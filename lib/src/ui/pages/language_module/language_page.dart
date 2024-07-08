import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart' as utils;
import '../../widgets/ecozonas_image.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/my_bottom_sheet_text_field.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../login_module/tabs_container/login_tab_page.dart';

class LanguagePage extends StatelessWidget {
  final Function(Locale) localeCallback;

  const LanguagePage({super.key, required this.localeCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(Constants.padding),
        child: Column(
          children: [
            const EcozonasImage(topPadding: 76, bottomPadding: 76),
            _bottomSheet(context),
            const Spacer(),
            _continueButton(context)
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /*
   * APPBAR
   */
  MyAppBar _appBar(BuildContext context) {
    return MyAppBar(
      title: Text(AppLocalizations.of(context)!.selectLanguage, style: const TextStyle(fontSize: Constants.appBarFontSize)),
    );
  }

  /*
   * WIDGETS
   */
  Widget _bottomSheet(BuildContext context) {
    return MyBottomSheetTextField(
      titleText: AppLocalizations.of(context)!.language,
      initialValue: utils.showEnglish(context) ?
        AppLocalizations.of(context)!.english :
        AppLocalizations.of(context)!.spanish,
      options: utils.getLanguageOptions(context),
      callback: (value) => _setLocale(value, context),
    );
  }

  Widget _continueButton(BuildContext context) {
    return MyPrimaryElevatedButton(
      label: AppLocalizations.of(context)!.continueText,
      fullWidth: true,
      onPressed: () {
        Navigator.pushNamed(context, LoginTabPage.routeName);
      },
    );
  }

  /*
   * METHODS
   */
  void _setLocale(String value, BuildContext context) {
    if (value == AppLocalizations.of(context)!.spanish) {
      localeCallback(const Locale('es'));
    } else {
      localeCallback(const Locale('en'));
    }
  }
}