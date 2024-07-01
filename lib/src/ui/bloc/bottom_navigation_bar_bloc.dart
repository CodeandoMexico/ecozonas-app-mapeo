import 'package:bloc/bloc.dart';

import '../pages/mapaton_list_module/tabs_container/mapaton_tabs_page.dart';
import '../pages/mapaton_map_module/mapaton_text_onboarding_page.dart';
import '../pages/my_session_module/my_session_page.dart';

enum BottomNavigationBarEvents {
  main,
  mySession,
  about
}

abstract class BottomNavigationBarState {}

class BottomNavigationBarBloc extends Bloc<BottomNavigationBarEvents, BottomNavigationBarState> {
  BottomNavigationBarBloc() : super(const MapatonTabsPage()) {
    on<BottomNavigationBarEvents>((event, emit) => _mapEventToState(emit, event));
  }

  void _mapEventToState(Emitter<BottomNavigationBarState> emit, BottomNavigationBarEvents event) async {
    switch(event) {
      case BottomNavigationBarEvents.main:
        emit(const MapatonTabsPage());
        break;
      case BottomNavigationBarEvents.mySession:
        emit(const MySessionPage());
        break;
      case BottomNavigationBarEvents.about:
        emit(const MapatonTextOnboardingPage());
        break;
    }
  }
}