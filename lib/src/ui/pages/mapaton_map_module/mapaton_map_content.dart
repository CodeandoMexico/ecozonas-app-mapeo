import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/preferences/user_preferences.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../utils/constants.dart';
import '../../widgets/mapaton/activities_draggable.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../update_map_module/update_map_page.dart';
import 'bloc/bloc.dart';

class MapatonMapContent extends StatelessWidget {
  MapatonMapContent({super.key});

  final ActivitiesDraggable _activitiesDraggable = ActivitiesDraggable();

  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 16
  );
  bool _disableCameraMove = false;

  @override
  Widget build(BuildContext context) {
    final mapaton = ModalRoute.of(context)!.settings.arguments as Mapaton;
    
    final bloc = context.read<MapatonBloc>();
    final prefs = UserPreferences();

    _activitiesDraggable.setActivities(mapaton);
    _activitiesDraggable.setCallback((value) {
      BlocProvider.of<MapatonBloc>(context).add(AddMarker(value));
    });

    return Scaffold(
      appBar: _appBar(context, bloc, mapaton),
      body: BlocListener<MapatonBloc, MapatonState>(
        listener: _states,
        child: _body(bloc, prefs),
      ),
    );
  }

  /*
   * STATES
   */
  void _states(context, state) {
    if (state is LocationGetted) {
      _moveCamera(state.location);
    }
  }

  /*
   * APP BAR
   */
  AppBar _appBar(BuildContext context, MapatonBloc bloc, Mapaton mapaton) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mapaton.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(mapaton.locationText, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          StreamBuilder<List<ActivityDbModel>>(
            stream: bloc.activities,
            initialData: const [],
            builder: (BuildContext context, AsyncSnapshot<List<ActivityDbModel>> snapshot) {
              if (snapshot.data!.isNotEmpty) {
                return _updateMapButton(context);
              } else {
                return Container();
                // return Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Column(
                //     children: [
                //       const Text('Última actualización', style: TextStyle(fontSize: 12)),
                //       const SizedBox(height: 4.0),
                //       Text(utils.formatDate(mapaton.updatedAt), style: const TextStyle(fontSize: 12)),
                //     ],
                //   ),
                // );
              }
            },
          ),
        ],
      ),
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _body(MapatonBloc bloc, UserPreferences prefs) {
    return Stack(
      children: [
        _map(bloc, prefs),
        _startButton(),
        StreamBuilder(
          stream: bloc.showCenter,
          initialData: true,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data!) {
              return const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 36.0),
                  child: Icon(Icons.pin_drop, size: 50),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        _draggableScrollableSheet()
      ],
    );
  }

  Widget _updateMapButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () => _goToUpdateMap(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(8.0),
          backgroundColor: Constants.yellowButtonColor,
          shadowColor: Constants.yellowButtonShadowColor,
          elevation: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
          )
        ),
        child: const Text(
          'Sincronizar datos',
          style: TextStyle(fontSize: 12)
        )
      ),
    );
  }

  Widget _map(MapatonBloc bloc, UserPreferences prefs) {
    return Positioned.fill(
      child: StreamBuilder<List<ActivityDbModel>>(
        stream: bloc.activities,
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot<List<ActivityDbModel>> activitiesSnapshot) {
          if (activitiesSnapshot.hasData && activitiesSnapshot.data != null) {
            return GoogleMap(
              initialCameraPosition: _cameraPosition,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              onMapCreated: (controller) => _onMapCreated(controller),
              onCameraIdle: () => _onCameraIdle(prefs),
              markers: _markers(context, activitiesSnapshot),
              onCameraMoveStarted: () => _showCenter(context),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _startButton() {
    return Positioned(
      left: 16.0,
      right: 16.0,
      bottom: 16.0,
      child: MyPrimaryElevatedButton(
        label: 'Mapear aquí',
        fullWidth: true,
        onPressed: () => _activitiesDraggable.animateDraggable(false),
      ),
    );
  }

  Widget _draggableScrollableSheet() {
    return Positioned.fill(
      child: _activitiesDraggable
    );
  }

  /*
   * METHODS
   */
  void _moveCamera(LatLng latLng) async {
    final GoogleMapController c = await _controller.future;
    _cameraPosition = CameraPosition(target: latLng, zoom: 16);
    c.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void _goToUpdateMap(BuildContext context) {
    Navigator.pushNamed(context, UpdateMapPage.routeName);
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  Future<void> _onCameraIdle(UserPreferences prefs) async {
    final GoogleMapController c = await _controller.future;
    LatLngBounds bounds = await c.getVisibleRegion();
    LatLng latLng = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    prefs.setActivityLocation = latLng;
  }

  void _showCenter(BuildContext context) {
    if (!_disableCameraMove) {
      BlocProvider.of<MapatonBloc>(context).add(ShowCenter(showCenter: true));
    }
  }

  Set<Marker> _markers(BuildContext context, AsyncSnapshot<List<ActivityDbModel>> activitiesSnapshot) {
    return activitiesSnapshot.data!.map((e) {
      return Marker(
        markerId: MarkerId(e.id.toString()),
        position: LatLng(e.latitude, e.longitude),
        onTap: () {
          BlocProvider.of<MapatonBloc>(context).add(ShowCenter(showCenter: false));
          _disableCameraMove = true;

          Timer.periodic(const Duration(seconds: 1), (timer) {
            _disableCameraMove = false;
          });
        },
      );
    }).toSet();
  }
}