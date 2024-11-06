import 'dart:async';

import 'package:ecozonas/src/ui/utils/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../main.dart';
import '../../../data/device/connectivity.dart';
import '../../../data/preferences/user_preferences.dart';
import '../../../domain/models/current_activity_model.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart';
import '../../utils/utils.dart' as utils;
import '../../widgets/mapaton/activities_draggable.dart';
import '../../widgets/my_primary_elevated_button.dart';
import '../update_map_module/update_map_page.dart';
import 'bloc/bloc.dart';

class MapatonMapContent extends StatefulWidget {
  final MapatonModel? mapaton;

  const MapatonMapContent({super.key, this.mapaton});

  @override
  State<MapatonMapContent> createState() => _MapatonMapContentState();
}

class _MapatonMapContentState extends State<MapatonMapContent> {
  final ActivitiesDraggable _activitiesDraggable = ActivitiesDraggable();

  // late MapatonBloc _bloc;
  MapboxMapController? _controller;
  Symbol? _currentPositionSymbol;
  bool _disableCameraMove = false;
  String? _selectedMarkerId;

  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 15
  );

  // @override
  // void initState() {
  //   _bloc = context.read<MapatonBloc>();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final mapaton = ModalRoute.of(context)!.settings.arguments as MapatonModel;
    final bloc = context.read<MapatonBloc>();

    final prefs = UserPreferences();

    _activitiesDraggable.setActivities(widget.mapaton!);
    _activitiesDraggable.setCallback((value) {
      BlocProvider.of<MapatonBloc>(context).add(AddMarker(value));
    });

    return Scaffold(
      appBar: _appBar(context, bloc, widget.mapaton!),
      body: BlocListener<MapatonBloc, MapatonState>(
        listener: _states,
        child: _body(bloc, prefs, context, widget.mapaton!),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  /*
   * STATES
   */
  void _states(context, state) {
    if (state is LocationGetted) {
      _moveCamera(state.location);
    }
    if (state is MarkersGetted) {
      for(var a in state.activities) {
        addImageFromAsset(LatLng(a.latitude, a.longitude), a);
      }
    }
    if (state is MarkerAdded) {
      addImageFromAsset(LatLng(state.activity.latitude, state.activity.longitude), state.activity);
    }
    if (state is DownloadingRegion) {
      showLoadingDialog(context);
    }
    if (state is RegionDownloaded) {
      utils.showSnackBarSuccess(context, AppLocalizations.of(context)!.downloadCompleted);
      Navigator.pop(context);
    }
    if (state is ErrorDownloadingRegion) {
      utils.showSnackBarError(context, AppLocalizations.of(context)!.downloadError);
      Navigator.pop(context);
    }
  }

  /*
   * APP BAR
   */
  AppBar _appBar(BuildContext context, MapatonBloc bloc, MapatonModel mapaton) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          Expanded(
            child: Text(
              utils.showEnglish(context) ? mapaton.titleEn : mapaton.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            ),
          ),
          _updateMapButton(context)
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
  Widget _body(MapatonBloc bloc, UserPreferences prefs, BuildContext context, MapatonModel mapaton) {
    return Stack(
      children: [
        _currentPositionStream(bloc),
        _map(bloc, prefs, context, mapaton),
        _startButton(),
        _dropPinIcon(bloc),
        _goToMyLocationButton(),
        _activityName(bloc),
        _downloadButton(bloc, mapaton),
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
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Constants.borderRadiusMedium))
          )
        ),
        child: Text(
          AppLocalizations.of(context)!.sendData,
          style: const TextStyle(fontSize: 12, color: Colors.black)
        )
      ),
    );
  }

  Widget _currentPositionStream(MapatonBloc bloc) {
    return Positioned.fill(
      child: StreamBuilder<LocationData>(
        stream: bloc.currentPosition,
        builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final l = snapshot.data!;

            if (_currentPositionSymbol != null) {
              final currentGeo = _currentPositionSymbol!.options.geometry!;
              if (currentGeo.latitude.toStringAsFixed(5) != l.latitude!.toStringAsFixed(5) ||
                  currentGeo.longitude.toStringAsFixed(5) != l.longitude!.toStringAsFixed(5)) {
                removeMyLocation();
                addMyLocation(LatLng(l.latitude!, l.longitude!));
              }
            } else {
              addMyLocation(LatLng(l.latitude!, l.longitude!));
            }
          }

          return Container();
        },
      ),
    );
  }

  Widget _map(MapatonBloc bloc, UserPreferences prefs, BuildContext context, MapatonModel mapaton) {
    return MapboxMap(
      accessToken: MyApp.accessToken,
      initialCameraPosition: _cameraPosition,
      myLocationEnabled: false,
      trackCameraPosition: true,
      onMapCreated: (controller) => _onMapCreated(controller, context, mapaton),
      onCameraIdle: () => _onCameraIdle(bloc, prefs),
      onStyleLoadedCallback: () async {
        await _controller!.setSymbolIconAllowOverlap(true);
        await _controller!.setSymbolTextAllowOverlap(true);

        final icons = [
          'my_location',
          'desastres',
          'ambiental',
          'socioeconomico',
          'urbano',
          'otra'
        ];

        for (var icon in icons) {
          final ByteData bytes = await rootBundle.load('assets/markers/icon_$icon.png');
          final Uint8List list = bytes.buffer.asUint8List();
          await _controller!.addImage(icon, list);
        }

        if (mounted) {
          BlocProvider.of<MapatonBloc>(context).add(GetLocation());
          BlocProvider.of<MapatonBloc>(context).add(GetMarkers(mapaton.uuid));
        }
      },
    );
  }

  Widget _startButton() {
    return Positioned(
      left: 16.0,
      right: 16.0,
      bottom: 16.0,
      child: MyPrimaryElevatedButton(
        label: AppLocalizations.of(context)!.mapHere,
        fullWidth: true,
        elevation: 5,
        onPressed: () => _activitiesDraggable.animateDraggable(false),
      ),
    );
  }

  Widget _dropPinIcon(MapatonBloc bloc) {
    return IgnorePointer(
      child: StreamBuilder(
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
    );
  }

  Widget _goToMyLocationButton() {
    return Positioned(
      right: 10,
      top: 10,
      child: FloatingActionButton(
        heroTag: 'my_location',
        onPressed: () {
          if (_currentPositionSymbol != null) {
            final currentGeo = _currentPositionSymbol!.options.geometry!;
            _moveCamera(LatLng(currentGeo.latitude, currentGeo.longitude));
          }
        },
        backgroundColor: Colors.white,
        child: Image.asset('assets/markers/icon_my_location.png', height: 35),
      ),
    );
  }

  Widget _activityName(MapatonBloc bloc) {
    return Positioned(
      left: 10,
      top: 10,
      right: 80,
      child: StreamBuilder(
        stream: bloc.currentActivity,
        builder: (BuildContext context, AsyncSnapshot<CurrentActivityModel?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: snapshot.data!.borderColor,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(Constants.borderRadiusSmall)
              ),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: snapshot.data!.color,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    snapshot.data!.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _downloadButton(MapatonBloc bloc, MapatonModel mapaton) {
    return Positioned(
      right: 10,
      bottom: 80,
      child: StreamBuilder(
        stream: bloc.showDownload,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data! == true) {
            return FloatingActionButton(
              heroTag: 'download',
              onPressed: () async => await _downloadRegion(mapaton),
              backgroundColor: Constants.yellowButtonColor,
              child: const Icon(Icons.download, size: 32),
            );
          } else {
            return Container();
          }
        },
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
    _cameraPosition = CameraPosition(target: latLng, zoom: 15);
    _controller!.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void _goToUpdateMap(BuildContext context) {
    Navigator.pushNamed(context, UpdateMapPage.routeName);
  }

  void _onMapCreated(MapboxMapController controller, BuildContext context, MapatonModel mapaton) async {
    _controller = controller;
    _controller!.onSymbolTapped.add(_onSymbolTapped);
    _controller!.addListener(() {
      if (_controller!.isCameraMoving) {
        _showCenter(context);
      }
    });
  }

  Future<void> _onCameraIdle(MapatonBloc bloc, UserPreferences prefs) async {
    if (_controller != null) {
      LatLngBounds bounds = await _controller!.getVisibleRegion();
      LatLng latLng = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );

      prefs.setActivityLocation = latLng;

      bloc.setShowDownload(_controller!.cameraPosition!.zoom >= 15);
    }
  }

  void _showCenter(BuildContext context) {
    if (!_disableCameraMove) {
      _selectedMarkerId = null;
      BlocProvider.of<MapatonBloc>(context).add(ShowCenter(showCenter: true));
      BlocProvider.of<MapatonBloc>(context).add(SetCurrentActivity(activity: null));
    }
  }

  Future<void> addMyLocation(LatLng coordinates) async {
    try {
      if (_controller != null) {
        _currentPositionSymbol = await _controller!.addSymbol(
          SymbolOptions(
            geometry: coordinates,
            iconImage: 'my_location',
            iconSize: 0.7,
            iconColor: '#FF0000',
          ),
        );
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> removeMyLocation() async {
    if (_controller != null && _currentPositionSymbol != null) {
      _controller!.removeSymbol(_currentPositionSymbol!);
    }
  }

  Future<void> addImageFromAsset(LatLng coordinates, ActivityDbModel a) async {
    String icon = '';

    switch(a.categoryCode) {
      case 'RIESGO_DESASTRES':
        icon = 'desastres';
        break;
      case 'CALIDAD_AMBIENTAL':
        icon = 'ambiental';
        break;
      case 'BIENESTAR_SOCIOECONOMICO':
        icon = 'socioeconomico';
        break;
      case 'ENTORNO_URBANO':
        icon = 'urbano';
        break;
      case 'OTRA':
        icon = 'otra';
        break;
    }

    if (_controller != null) {
      try {
        await _controller!.addSymbol(
          SymbolOptions(
            geometry: coordinates,
            iconImage: icon,
            iconSize: 1,
            iconOffset: const Offset(0, -10),
          ),
          a.toJson()
        );
      } catch (err) {
        debugPrint(err.toString());
      }
    }
  }

  void _onSymbolTapped(Symbol symbol) {
    if (symbol == _currentPositionSymbol) {
      return;
    }

    final coor = symbol.options.geometry;
    final activity = ActivityDbModel.fromJson(symbol.data!);
    _controller!.animateCamera(CameraUpdate.newLatLng(coor!));

    BlocProvider.of<MapatonBloc>(context).add(SetCurrentActivity(
      activity: CurrentActivityModel(
        name: activity.name,
        color: activity.color.toColor(),
        borderColor: activity.borderColor.toColor()
      )
    ));

    if (symbol.id == _selectedMarkerId) {
      showConfirmationDialog(
        context,
        text: AppLocalizations.of(context)!.deleteMapping,
        acceptButtonText: AppLocalizations.of(context)!.delete,
        acceptCallback: () async {
          await _controller!.removeSymbol(symbol);

          if (mounted) {
            BlocProvider.of<MapatonBloc>(context).add(RemoveMarker(activity));
            utils.showSnackBarSuccess(context, AppLocalizations.of(context)!.activityDeleted);
          }
        }
      );

      _setDisableCameraMove();
    } else {
      _selectedMarkerId = symbol.id;

      BlocProvider.of<MapatonBloc>(context).add(ShowCenter(showCenter: false));
      _setDisableCameraMove();
    }
  }

  Future<void> _setDisableCameraMove() async {
    _disableCameraMove = true;

    await Future.delayed(const Duration(milliseconds: 600)).then((value) {
      _disableCameraMove = false;
    });
  }

  Future<void> _downloadRegion(MapatonModel mapaton) async {
    LatLngBounds bounds = await _controller!.getVisibleRegion();

    final connectionAvailable = await Connectivity.connectionAvailable();
    if (connectionAvailable) {
      if (mounted) {
        showConfirmationDialog(
          context,
          text: AppLocalizations.of(context)!.downloadRegion,
          acceptButtonText: AppLocalizations.of(context)!.download,
          acceptCallback: () {
            BlocProvider.of<MapatonBloc>(context).add(DownloadRegion(name: mapaton.uuid, bounds: bounds));
          }
        );
      }
    } else {
      if (mounted) {
        utils.showSnackBarError(context, AppLocalizations.of(context)!.noConnection);
      }
    }
  }
}
