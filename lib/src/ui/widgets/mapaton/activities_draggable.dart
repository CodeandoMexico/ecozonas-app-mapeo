import 'package:flutter/material.dart';

import '../../../domain/models/db/activity_db_model.dart';
import '../../../domain/models/mapaton_model.dart';
import '../../pages/form_module/form_page.dart';
import '../../utils/constants.dart';
import '../../utils/dialogs.dart' as dialogs;
import '../activity_item.dart';
import '../my_text_form_field.dart';

class CategoryOptions {
  CategoryOptions({
    required this.text,
    this.code,
  });

  String text;
  String? code;
}

class ActivitiesDraggable extends StatefulWidget {
  final DraggableScrollableController draggableController = DraggableScrollableController();

  ActivitiesDraggable({super.key});

  @override
  State<ActivitiesDraggable> createState() => _ActivitiesDraggableState();

  late Mapaton _mapatone;
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

  void setActivities(Mapaton mapatone) {
    _mapatone = mapatone;
    _activities = mapatone.activities;
    _filteredActivities = _activities;
  }

  void setCallback(Function(ActivityDbModel) callback) {
    _callback = callback;
  }
}

class _ActivitiesDraggableState extends State<ActivitiesDraggable> {
  final _controller = TextEditingController();

  String _defaultCategory = 'Todas las dimensiones';
  final _options = [
    CategoryOptions(text: 'Todas las dimensiones'),
    CategoryOptions(text: 'Entorno urbano', code: 'ENTORNO_URBANO'),
    CategoryOptions(text: 'Calidad medioambiental', code: 'CALIDAD_MEDIOAMBIENTAL'),
    CategoryOptions(text: 'Bienestar socioeconómico', code: 'BIENESTAR_SOCIOECONOMICO'),
    CategoryOptions(text: 'Riesgo de desastres', code: 'RIESGO DESASTRES'),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0);

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
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    _page1(context, pageController),
                    // _page2(pageController),
                  ],
                ),
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
      hintText: 'Buscar actividad',
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
                  Text(_defaultCategory),
                  const Icon(Icons.keyboard_arrow_down)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _page1(BuildContext context, PageController pageController) {
    return Column(
      children: [
        _filters(),
        Expanded(
          child: ListView(
            children: [
              Container(
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
                    const Text('Actividades prioritarias')
                  ],
                ),
              ),
              ...widget._filteredActivities.map((e) {
              final category = widget._mapatone.categories.where((element) {
                return element.code.replaceAll(' ', '_') == e.category.code;
              }).toList();
              if (category.isNotEmpty) {
                e.color = category[0].color;
                e.icon = category[0].icon;
              }

              return ActivityItem(
                activity: e,
                callback: () async {
                  await _goToFormPage(e, context);
                },
              );
            }).toList()
            ],
          ),
        ),
      ],
    );
  }

  /*
   * METHODS
   */
  void _search(String value) {
    setState(() {
      widget._filteredActivities = widget._activities.where((element) {
        return element.title.toLowerCase().contains(value.toLowerCase()) ||
          element.description.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  void _filter(String value) {
    setState(() {
      final index = _options.indexWhere((element) {
        return element.text == value;
      });
    
      _defaultCategory = value;
      if (index == 0) {
        widget._filteredActivities = widget._activities;
      } else {
        widget._filteredActivities = widget._activities.where((element) {
          final category = _options.firstWhere((element) {
            return element.text == value;
          });
    
          return element.category.code == category.code;
        }).toList();
      }
    });
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
    ) as ActivityDbModel;
    
    widget._callback(a);
    
    widget.draggableController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease
    );
  }
}