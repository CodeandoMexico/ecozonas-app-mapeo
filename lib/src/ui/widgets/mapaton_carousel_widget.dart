import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/models/mapaton_model.dart';
import '../../ui/utils/color_extension.dart';
import '../utils/constants.dart';
import '../utils/utils.dart' as utils;

class MapatonCarouselWidget extends StatefulWidget {
  final MapatonModel mapaton;

  const MapatonCarouselWidget({super.key, required this.mapaton});

  @override
  State<MapatonCarouselWidget> createState() => _MapatonCarouselWidgetState();
}

class _MapatonCarouselWidgetState extends State<MapatonCarouselWidget> {
  late int _current;
  final _categories = [];

  @override
  void initState() {
    _current = 0;
    _categories.addAll(widget.mapaton.categories);
    _categories.removeWhere((element) {
      return element.code == 'OTRA';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _carousel(context),
        _carouselIndicator(),
      ],
    );
  }

  /*
   * WIDGETS
   */
  Widget _carousel(BuildContext context) {
    return CarouselSlider(
      items: _categories.map((e) {
        return _info(context, e);
      }).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.7,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) => setState(() => _current = index),
      ),
    );
  }

  Widget _carouselIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _categories.asMap().entries.map((entry) {
          return Container(
            width: 9,
            height: 9,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(_current == entry.key ? 0.9 : 0.4)),
          );
        }).toList(),
      ),
    );
  }

  Widget _info(BuildContext context, Category category) {
    return Column(
      children: [
        _header(context, category),
        const SizedBox(height: Constants.paddingXLarge),
        _details(category.description)
      ],
    );
  }

  Widget _header(BuildContext context, Category category) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: category.color.toColor(),
      padding: const EdgeInsets.all(Constants.padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _sectionTitle('${AppLocalizations.of(context)!.dimension} ${category.name}'),
          utils.getCategoryIcon(
            code: category.code,
            size: 120,
            color: category.borderColor!.toColor()
          )
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF29496E))
    );
  }

  Widget _details(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.padding),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16)
      ),
    );
  }
}
