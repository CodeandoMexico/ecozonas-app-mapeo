import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../../data/repositories/db/activity/activity_repository_impl.dart';
import '../../../domain/models/category_option_model.dart';
import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../../domain/use_cases/db/activity_use_case.dart';
import '../../pages/form_module/form_page.dart';
import '../../pages/mapaton_map_module/bloc/bloc.dart';
import '../../utils/dialogs.dart' as dialogs;
import '../../utils/utils.dart' as utils;
import '../activity_item.dart';
import '../my_text_form_field.dart';
import '../../theme/theme.dart';

/// Hoja deslizable con las actividades del mapatón. La abre y cierra quien
/// tenga [controller]; [onActivitySaved] recibe cada actividad guardada.
class ActivitiesDraggable extends StatefulWidget {
  final MapatonModel mapaton;
  final DraggableScrollableController controller;
  final ValueChanged<ActivityDbModel> onActivitySaved;

  const ActivitiesDraggable({
    super.key,
    required this.mapaton,
    required this.controller,
    required this.onActivitySaved,
  });

  /// Tamaño de la hoja abierta (fracción de la pantalla).
  static const openSize = 0.9;

  @override
  State<ActivitiesDraggable> createState() => _ActivitiesDraggableState();
}

class _ActivitiesDraggableState extends State<ActivitiesDraggable> {
  List<Activity> get _activities => widget.mapaton.activities;
  late List<Activity> _filteredActivities = List.of(_activities);
  late String _selectedCategory;
  late List<CategoryOptionModel> _options;
  final _controller = TextEditingController();
  final useCase = ActivityUseCase(ActivityRepositoryImpl());

  String _searchText = '';

  @override
  void didChangeDependencies() {
    _selectedCategory = AppLocalizations.of(context)!.searchByDimension;
    _options = [
      CategoryOptionModel(
          text: AppLocalizations.of(context)!.searchByDimension),
      CategoryOptionModel(
          text: AppLocalizations.of(context)!.urbanEnvironment,
          code: 'ENTORNO_URBANO'),
      CategoryOptionModel(
          text: AppLocalizations.of(context)!.environmentalQuality,
          code: 'CALIDAD_AMBIENTAL'),
      CategoryOptionModel(
          text: AppLocalizations.of(context)!.socioeconomicWellbeing,
          code: 'BIENESTAR_SOCIOECONOMICO'),
      CategoryOptionModel(
          text: AppLocalizations.of(context)!.disasterRisk,
          code: 'RIESGO_DESASTRES'),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MapatonBloc>();

    return DraggableScrollableSheet(
      controller: widget.controller,
      minChildSize: 0,
      initialChildSize: 0,
      maxChildSize: ActivitiesDraggable.openSize,
      snap: true,
      builder: (context, scrollController) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Barra de arrastre: indica que la hoja se puede deslizar.
                    Container(
                      width: 32,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: AppColors.outline,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ),
                    Padding(
                      padding: AppSpacing.page,
                      child: _searchTextField(),
                    ),
                  ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ActionChip(
          avatar: const Icon(Icons.filter_list, size: 18),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_selectedCategory),
              const Icon(Icons.keyboard_arrow_down, size: 18),
            ],
          ),
          onPressed: () {
            dialogs.showMyBottomSheet(
              context: context,
              options: _options.map((e) => e.text).toList(),
              callback: (value) => _filter(value),
            );
          },
        ),
      ),
    );
  }

  Widget _page1(BuildContext context, MapatonBloc bloc) {
    _filteredActivities.sort((a, b) {
      return a.title.compareTo(b.title);
    });

    _filteredActivities.sort((a, b) {
      return a.category.code.compareTo(b.category.code);
    });

    _filteredActivities.sort((a, b) {
      final aInt = a.isPriority ? 1 : 0;
      final bInt = b.isPriority ? 1 : 0;

      return bInt.compareTo(aInt);
    });

    Activity? c = _activities.firstWhereOrNull((element) => element.category.code == 'OTRA');
    if (c != null) {
      c.color = c.category.color;
      c.color = c.category.color;
      c.borderColor = c.category.borderColor;
      c.icon = c.category.icon;
      c.category.description = c.category.name;
    }

    final withPriority = _filteredActivities.where((e) => e.isPriority == true);
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
                    ..._filteredActivities.where((element) {
                      return element.category.code != 'OTRA';
                    }).map((e) {
                      final category = widget.mapaton.categories
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
                    }),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
      child: Row(
        children: [
          Image.asset('assets/icons/ic_asterisk_50.png', width: 16),
          Image.asset('assets/icons/ic_asterisk_50.png', width: 16),
          const SizedBox(width: AppSpacing.xs),
          Text(AppLocalizations.of(context)!.priorityObjects, style: Theme.of(context).textTheme.titleSmall),
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
      _filteredActivities = _activities.where((element) {
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
        _filteredActivities = _activities.where((element) {
          if (_searchText.isEmpty) {
            return _matchCategory(element);
          } else {
            return _matchCategory(element) && _matchText(element);
          }
        }).toList();
        _filteredActivities.sort((a, b) {
          return a.title.compareTo(b.title);
        });
      } else {
        if (_searchText.isEmpty) {
          _filteredActivities = List.of(_activities);
        } else {
          _filteredActivities = _activities.where((element) {
            return _matchText(element);
          }).toList();
        }
      }
    });
  }

  bool _matchText(Activity element) {
    final title = utils.removeDiacritics(utils.localized(context, es: element.title, en: element.titleEn));
    final description = utils.removeDiacritics(utils.localized(context, es: element.description, en: element.descriptionEn));
    final blocksJson = utils.removeDiacritics(element.blocksJson);
    final search = utils.removeDiacritics(_searchText);

    if (_searchText.isNotEmpty) {
      return title.contains(search) || description.contains(search) || blocksJson.contains(search);
    } else {
      return true;
    }
  }

  bool _matchCategory(Activity element) {
    final category = _options.firstWhere((element) {
      return element.text == _selectedCategory;
    });

    return element.category.code == category.code;
  }

  Future<void> _goToFormPage(Activity e, BuildContext context) async {
    e.mapatonUuid = widget.mapaton.uuid;
    e.mapatonTitle = widget.mapaton.title;
    e.mapatonLocationText = widget.mapaton.locationText;

    final a = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormPage(),
        settings: RouteSettings(arguments: e)
      )
    );

    if (a != null) {
      widget.controller.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease
      );

      widget.onActivitySaved(a);
    }
  }
}
