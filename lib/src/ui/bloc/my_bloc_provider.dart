// import 'package:flutter/material.dart';

// import '../pages/mapaton_map_module/bloc/mapaton_bloc.dart';

// class MyBlocProvider extends InheritedWidget {
//   final mapatonBloc = MapatonBloc();
  
//   static late MyBlocProvider _instance;

//   factory MyBlocProvider({required Widget child}) {
//     _instance = MyBlocProvider._internal(child: child);
//     return _instance;
//   }

//   MyBlocProvider._internal({required Widget child}) : super(child: child);

//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

//   static MapatonBloc getMapatonBloc (BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<MyBlocProvider>()!.mapatonBloc;
//   }
// }