import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/preferences/user_preferences.dart';
import '../../../../data/repositories/preferences/preferences_repository_impl.dart';
import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/use_cases/preferences_use_case.dart';
import '../../../utils/constants.dart';
import '../../manage_sessions_module/manage_sessions_page.dart';
import '../../mapaton_main_module/mapaton_main_page.dart';
import '../../mapaton_map_module/mapaton_text_onboarding_page.dart';
import 'bloc/bloc.dart';

class ContinueSessionContent extends StatelessWidget {
  const ContinueSessionContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ContinueSessionBloc>();

    return Padding(
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        children: [
          _text(),
          const SizedBox(height: Constants.paddingLarge),
          _sessionsList(bloc),
          _elevatedButton(context),
        ],
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _text() {
    return const Text(
      'Selecciona una de las sesiones registradas en este dispositivo',
      style: TextStyle(fontSize: 18, color: Constants.labelTextColor),
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
            child: ListView.builder(
              itemCount: snapshot.data!.length,
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
    return GestureDetector(
      onTap: () => _saveMapperToPreferences(context, mapperDbModel),
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF494949), width: 1),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${mapperDbModel.alias}#${mapperDbModel.mapperId}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Constants.labelTextColor,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18)
          ],
        ),
      ),
    );
  }

  Widget _elevatedButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Constants.darkBlueColor),
          borderRadius: BorderRadius.circular(12)
        )
      ),
      onPressed: () async {
        await _push(context, const ManageSessionsPage());
      },
      child: const Text('Administrar sesiones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
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