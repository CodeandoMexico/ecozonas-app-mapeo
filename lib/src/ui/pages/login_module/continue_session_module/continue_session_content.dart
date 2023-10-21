import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/preferences/preferences_repository_impl.dart';
import '../../../../domain/models/db/mapper_db_model.dart';
import '../../../../domain/models/mapaton_post_model.dart';
import '../../../../domain/use_cases/preferences_use_case.dart';
import '../../../utils/constants.dart';
import '../../mapaton_list_module/mapaton_list_page.dart';
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
          const Text(
            'Selecciona una de las sesiones registradas en este dispositivo',
            style: TextStyle(fontSize: 18, color: Constants.labelTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Constants.paddingLarge),
          _sessionsList(bloc),
          const Text('Administrar sesiones'),
        ],
      ),
    );
  }

  /*
   * WIDGETS
   */
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
      onTap: () => _saverMapperToPreferences(context, mapperDbModel),
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
                '#${mapperDbModel.mapperId}',
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

  /*
   * METHODS
   */
  void _saverMapperToPreferences(BuildContext context, MapperDbModel mapperDbModel) {
    final preferencesUserCase = PreferencesUseCase(PreferencesRepositoryImpl());
    preferencesUserCase.setMapper(Mapper(
      id: mapperDbModel.mapperId,
      sociodemographicData: SociodemographicData(
        genre: mapperDbModel.gender,
        ageRange: mapperDbModel.age,
        disability: mapperDbModel.disability
      )
    ));

    Navigator.pushNamed(context, MapatonListPage.routeName);
  }
}