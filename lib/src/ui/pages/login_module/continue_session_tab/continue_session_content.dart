import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/preferences/preferences_repository_impl.dart';
import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/use_cases/preferences_use_case.dart';
import '../../manage_sessions_module/manage_sessions_page.dart';
import '../../mapaton_main_module/mapaton_main_page.dart';
import '../../mapaton_map_module/mapaton_text_onboarding_page.dart';
import 'bloc/bloc.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_list_item.dart';
import '../../../theme/theme.dart';

class ContinueSessionContent extends StatelessWidget {
  const ContinueSessionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ContinueSessionBloc>();

    return SafeArea(
      top: false,
      child: Padding(
        padding: AppSpacing.pageWithVertical,
        child: Column(
          children: [
            Image.asset('assets/images/new_app_splash.png', height: 128),
            const SizedBox(height: AppSpacing.md),
            _text(context),
            const SizedBox(height: AppSpacing.lg),
            _sessionsList(bloc),
            const SizedBox(height: AppSpacing.md),
            _elevatedButton(context),
          ],
        ),
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _text(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.selectSession,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    );
  }

  Widget _sessionsList(ContinueSessionBloc bloc) {
    return StreamBuilder<List<MapperDbModel>>(
      stream: bloc.sessions,
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot<List<MapperDbModel>> snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Expanded(
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.xs),
              itemBuilder: (context, index) {
                return _sessionListItem(context, snapshot.data![index]);
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _sessionListItem(BuildContext context, MapperDbModel mapperDbModel) {
    return AppListItem(
      title: '${mapperDbModel.alias}#${mapperDbModel.mapperId}',
      onTap: () => _saveMapperToPreferences(context, mapperDbModel),
    );
  }

  Widget _elevatedButton(BuildContext context) {
    return AppButton.outline(
      label: AppLocalizations.of(context)!.manageSessions,
      icon: Icons.delete_outline,
      fullWidth: true,
      onPressed: () async {
        await _push(context, const ManageSessionsPage());
      },
    );
  }

  /*
   * METHODS
   */
  void _saveMapperToPreferences(BuildContext context, MapperDbModel mapperDbModel) {
    final preferencesUserCase = PreferencesUseCase(PreferencesRepositoryImpl());
    preferencesUserCase.setMapper(Mapper(
      dbId: mapperDbModel.id!,
      id: mapperDbModel.mapperId,
      sociodemographicData: SociodemographicData(
        gender: mapperDbModel.gender,
        ageRange: mapperDbModel.age,
        disability: mapperDbModel.disability
      )
    ));

    final prefs = UserPreferences();
    final userId = prefs.getMapper!.id;
    final ids = prefs.getOnboardingTextShownIds;
    if (ids != null) {
      final list = ids.split(',');
      if (list.contains(userId.toString())) {
        _push(context, const MapatonMainPage());
      } else {
        _push(context, const MapatonTextOnboardingPage(), showContinueButton: true);
      }
    } else {
      _push(context, const MapatonTextOnboardingPage(), showContinueButton: true);
    }
  }

  Future<void> _push(BuildContext context, Widget page, {bool? showContinueButton}) async {
    final update = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(
          arguments: showContinueButton
        )
      )
    ) as bool?;
    
    if ((update == null || update) && context.mounted) {
      BlocProvider.of<ContinueSessionBloc>(context).add(GetSessions());
    }
  }
}