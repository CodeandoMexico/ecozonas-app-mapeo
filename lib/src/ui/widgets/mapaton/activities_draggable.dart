import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../domain/models/category_option_model.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/use_cases/db/activity_use_case.dart';
import '../../pages/form_module/form_page.dart';
import '../../pages/mapaton_map_module/bloc/bloc.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart' as dialogs;
import '../../utils/utils.dart' as utils;
import '../activity_item.dart';
import '../my_text_form_field.dart';

class ActivitiesDraggable extends StatefulWidget {
  final DraggableScrollableController draggableController = DraggableScrollableController();

  ActivitiesDraggable({super.key});

  @override
  State<ActivitiesDraggable> createState() => _ActivitiesDraggableState();

  late MapatonModel _mapatone;
  List<Activity> _activities = [];
  List<Activity> _filteredActivities = [];
  late Function(ActivityDbModel) _callback;


  void animateDraggable(bool isShowing) {
    draggableController.animateTo(
      !isShowing ? 0.9 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease
    );
  }

  void setActivities(MapatonModel mapatone) {
    _mapatone = mapatone;
    _activities = mapatone.activities;
    _filteredActivities = _activities;
  }

  void setCallback(Function(ActivityDbModel) callback) {
    _callback = callback;
  }
}

class _ActivitiesDraggableState extends State<ActivitiesDraggable> {
  late String _selectedCategory;
  late List<CategoryOptionModel> _options;
  final _controller = TextEditingController();
  final useCase = ActivityUseCase(ActivityRepositoryImpl());

  String _searchText = '';

  @override
  void didChangeDependencies() {
    _selectedCategory = AppLocalizations.of(context)!.searchByDimension;
    _options = [
      CategoryOptionModel(text: AppLocalizations.of(context)!.searchByDimension),
      CategoryOptionModel(text: AppLocalizations.of(context)!.urbanEnvironment, code: 'ENTORNO_URBANO'),
      CategoryOptionModel(text: AppLocalizations.of(context)!.environmentalQuality, code: 'CALIDAD_MEDIOAMBIENTAL'),
      CategoryOptionModel(text: AppLocalizations.of(context)!.socioeconomicWellbeing, code: 'BIENESTAR_SOCIOECONOMICO'),
      CategoryOptionModel(text: AppLocalizations.of(context)!.disasterRisk, code: 'RIESGO_DESASTRES'),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MapatonBloc>();

    return DraggableScrollableSheet(
      controller: widget.draggableController,
      minChildSize: 0,
      initialChildSize: 0,
      maxChildSize: 0.9,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Constants.borderRadius),
              topRight: Radius.circular(Constants.borderRadius),
            )
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: _searchTextField(),
                ),
              ),
              SliverFillRemaining(
                child: _page1(context, bloc),
              ),
            ],
          ),
        );
      },
    );
  }

  /*
   * WIDGETS
   */
  Widget _searchTextField() {
    return MyTextFormField(
      controller: _controller,
      hintText: '${AppLocalizations.of(context)!.search}...',
      suffixIconData: Icons.search,
      onChanged: (value) => _search(value),
    );
  }

  Widget _filters() {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(width: 16.0),
          GestureDetector(
            onTap: () {
              dialogs.showMyBottomSheet(
                context: context,
                options: _options.map((e) => e.text).toList(),
                callback: (value) => _filter(value),
              );
            },
            child: Chip(
              label: Row(
                children: [
                  Text(_selectedCategory),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _page1(BuildContext context, MapatonBloc bloc) {
    widget._filteredActivities.sort((a, b) {
      return a.title.compareTo(b.title);
    });

    widget._filteredActivities.sort((a, b) {
      return a.category.code.compareTo(b.category.code);
    });

    widget._filteredActivities.sort((a, b) {
      final aInt = a.isPriority ? 1 : 0;
      final bInt = b.isPriority ? 1 : 0;

      return bInt.compareTo(aInt);
    });
    
    Activity? c = widget._activities.firstWhereOrNull((element) => element.category.code == 'OTRA');
    if (c != null) {
      c.color = c.category.color;
      c.color = c.category.color;
      c.borderColor = c.category.borderColor;
      c.icon = c.category.icon;
      c.category.description = c.category.name;
    }

    final withPriority = widget._filteredActivities.where((e) => e.isPriority == true);
    bool showPriorityLabel = withPriority.isNotEmpty;

    return StreamBuilder(
      stream: bloc.activities,
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              _filters(),
              Expanded(
                child: ListView(
                  children: [
                    if (showPriorityLabel) ...[
                      _priorityLabel()
                    ],
                    ...widget._filteredActivities.where((element) {
                      return element.category.code != 'OTRA';
                    }).map((e) {
                      final category = widget._mapatone.categories
                        .where((element) {
                          return element.code == e.category.code;
                        })
                        .toList();
                      if (category.isNotEmpty) {
                        e.color = category[0].color;
                        e.borderColor = category[0].borderColor;
                        e.icon = category[0].icon;
                        e.category.description = category[0].name;
                        e.counter = snapshot.data!.where((element) {
                          return element.uuid == e.uuid;
                        }).toList().length;
                      }
        
                      return ActivityItem(
                        activity: e,
                        callback: () async {
                          await _goToFormPage(e, context);
                        },
                      );
                    }).toList(),
                    if (c != null) ActivityItem(
                      activity: c,
                      callback: () async {
                        await _goToFormPage(c, context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ); 
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _priorityLabel() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Constants.yellowButtonColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/ic_asterisk_50.png', width: 18),
          Image.asset('assets/icons/ic_asterisk_50.png', width: 18),
          const SizedBox(width: 8.0),
          const Text('Objetos a mapear prioritarios')
        ],
      ),
    );
  }

  /*
   * METHODS
   */
  void _search(String value) {
    setState(() {
      _searchText = value;
      widget._filteredActivities = widget._activities.where((element) {
        if (_selectedCategory != _options[0].text) {
          return _matchCategory(element) && _matchText(element);
        } else {
          return _matchText(element);
        }
      }).toList();
    });
  }

  void _filter(String value) {
    setState(() {
      _selectedCategory = value;
      if (_selectedCategory != _options[0].text) {
        widget._filteredActivities = widget._activities.where((element) {
          if (_searchText.isEmpty) {
            return _matchCategory(element);
          } else {
            return _matchCategory(element) && _matchText(element);
          }
        }).toList();
        widget._filteredActivities.sort((a, b) {
          return a.title.compareTo(b.title);
        });
      } else {
        if (_searchText.isEmpty) {
          widget._filteredActivities = widget._activities;
        } else {
          widget._filteredActivities = widget._activities.where((element) {
            return _matchText(element);
          }).toList();
        }
      }
    });
  }

  bool _matchText(Activity element) {
    final title = utils.removeDiacritics(element.title);
    final description = utils.removeDiacritics(element.description);
    final blocksJson = utils.removeDiacritics(element.blocksJson);
    final search = utils.removeDiacritics(_searchText);

    if (_searchText.isNotEmpty) {
      return title.contains(search) || description.contains(search) || blocksJson.contains(search);
    }
    return true;
  }
  
  bool _matchCategory(Activity element) {
    final category = _options.firstWhere((element) {
      return element.text == _selectedCategory;
    });
  
    return element.category.code == category.code;
  }

  Future<void> _goToFormPage(Activity e, BuildContext context) async {
    e.mapatonUuid = widget._mapatone.uuid;
    e.mapatonTitle = widget._mapatone.title;
    e.mapatonLocationText = widget._mapatone.locationText;
    
    final a = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormPage(),
        settings: RouteSettings(arguments: e)
      )
    );

     if (a != null) {
      widget.draggableController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease
      );

      widget._callback(a);
    }
  }
}