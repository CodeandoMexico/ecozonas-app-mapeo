import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../login_module/tabs_container/bloc/login_tab_event.dart';
import '../continue_session_tab/continue_session_page.dart';
import '../new_session_tab/new_session_page.dart';
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

    _defaultPages = [_newSession];

    _allPages = [
      const ContinueSessionPage(),
      _newSession
    ];

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _defaultTabs = [_tab(AppLocalizations.of(context)!.newSession)];

    _allTabs = [
      _tab(AppLocalizations.of(context)!.continueText),
      _tab(AppLocalizations.of(context)!.newSession)
    ];
    super.didChangeDependencies();
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
      title: Text(AppLocalizations.of(context)!.init),
      bottom: TabBar(tabs: tabs, indicatorWeight: 3),
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
    return Tab(text: label);
  }
}