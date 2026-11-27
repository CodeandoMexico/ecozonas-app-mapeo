import 'package:material_ui/material_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecozonas/l10n/app_localizations.dart';

import '../../domain/models/mapaton_model.dart';
import '../../ui/utils/color_extension.dart';
import '../utils/utils.dart' as utils;
import '../theme/theme.dart';

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
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _categories.asMap().entries.map((entry) {
          final active = _current == entry.key;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: active ? 20 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              color: active ? AppColors.secondary : AppColors.outlineVariant,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _info(BuildContext context, Category category) {
    return Column(
      children: [
        _header(context, category),
        const SizedBox(height: AppSpacing.lg),
        _details(category.description)
      ],
    );
  }

  Widget _header(BuildContext context, Category category) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: category.color.toColor(),
      padding: const EdgeInsets.all(AppSpacing.md),
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
      textAlign: TextAlign.center,
      style: appTheme.textTheme.titleMedium!.copyWith(color: AppColors.secondary),
    );
  }

  Widget _details(String description) {
    return Padding(
      padding: AppSpacing.page,
      child: Text(description, style: appTheme.textTheme.bodyLarge),
    );
  }
}
