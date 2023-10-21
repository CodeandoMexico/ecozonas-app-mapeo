import 'package:bloc/bloc.dart';

import '../pages/mapaton_map_module/mapaton_map_page.dart';
import '../pages/my_session_module/my_session_page.dart';

enum BottomNavigationBarEvents {
  main,
  mySession
}

abstract class BottomNavigationBarState {}

class BottomNavigationBarBloc extends Bloc<BottomNavigationBarEvents, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(const MapatonMapPage()) {
    on<BottomNavigationBarEvents>((event, emit) => _mapEventToState(emit, event));
  }

  void _mapEventToState(Emitter<BottomNavigationBarState> emit, BottomNavigationBarEvents event) async {
    switch(event) {
      case BottomNavigationBarEvents.main:
        emit(const MapatonMapPage());
        break;
      case BottomNavigationBarEvents.mySession:
        emit(const MySessionPage());
        break;
    }
  }
}