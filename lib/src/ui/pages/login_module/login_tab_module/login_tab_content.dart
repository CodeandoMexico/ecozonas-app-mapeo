import 'package:ecozonas/src/ui/pages/login_module/login_tab_module/bloc/login_tab_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../continue_session_module/continue_session_page.dart';
import '../new_session_module/new_session_page.dart';
import 'bloc/login_tab_bloc.dart';

class LoginTabContent extends StatefulWidget {
  const LoginTabContent({super.key});

  @override
  State<LoginTabContent> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabContent> {
  late List<Widget> _defaultTabs;
  late List<Widget> _allTabs;
  late List<Widget> _defaultPages;
  late List<Widget> _allPages;

  late Widget _newSession;

  @override
  void initState() {
    _newSession = NewSessionPage(
      callback: () {
        BlocProvider.of<LoginTabBloc>(context).add(GetSessions());
      },
    );

    _defaultTabs = [_tab('Nueva sesión')];

    _allTabs = [
      _tab('Nueva sesión'),
      _tab('Continuar sesión')
    ];

    _defaultPages = [_newSession];

    _allPages = [
      _newSession,
      const ContinueSessionPage()
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginTabBloc>();

    return StreamBuilder(
      stream: bloc.hasSessions,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        final hasSessions = snapshot.data!;

        return DefaultTabController(
          length: !hasSessions ? 1 : 2,
          child: Scaffold(
            appBar: _appBar(!hasSessions ? _defaultTabs : _allTabs),
            body: _body(!hasSessions ? _defaultPages : _allPages),
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }

  /*
   * APPBAR
   */
  AppBar _appBar(List<Widget> tabs) {
    return AppBar(
      elevation: 0,
      title: TabBar(
        indicatorColor: Constants.darkBlueColor,
        indicatorWeight: 3,
        tabs: tabs,
      ),
    );
  }

  /*
   * WIDGETS
   */
  Widget _body(List<Widget> pages) {
    return TabBarView(
      children: pages,
    );
  }

  Widget _tab(String label) {
    return Tab(
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, color: Constants.labelTextColor)
      )
    );
  }
}