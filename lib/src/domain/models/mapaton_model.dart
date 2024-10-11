import 'dart:convert';

List<MapatonModel> mapatonListFromJson(String str) => List<MapatonModel>.from(json.decode(str).map((x) => MapatonModel.fromJson(x)));

String mapatonModelToJson(List<MapatonModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

const _noTraduction = '';

class MapatonModel {
    List<Activity> activities;
    List<Category> categories;
    String uuid;
    String title;
    String titleEn;
    String locationText;
    String limitNorth;
    String limitEast;
    String limitSouth;
    String limitWest;
    DateTime createdAt;
    DateTime updatedAt;
    String status;

    MapatonModel({
        required this.activities,
        required this.categories,
        required this.uuid,
        required this.title,
        this.titleEn = _noTraduction,
        required this.locationText,
        required this.limitNorth,
        required this.limitEast,
        required this.limitSouth,
        required this.limitWest,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
    });

    factory MapatonModel.fromJson(Map<String, dynamic> json) => MapatonModel(
        activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        uuid: json["uuid"],
        title: json["title"],
        titleEn: json["title_en"] == null || json["title_en"] == '' ? _noTraduction : json["title_en"],
        locationText: json["location_text"],
        limitNorth: json["limit_north"],
        limitEast: json["limit_east"],
        limitSouth: json["limit_south"],
        limitWest: json["limit_west"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "uuid": uuid,
        "title": title,
        "title_en": titleEn,
        "location_text": locationText,
        "limit_north": limitNorth,
        "limit_east": limitEast,
        "limit_south": limitSouth,
        "limit_west": limitWest,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
    };
}

class Activity {
    List<Block> blocks;
    Category category;
    String uuid;
    String title;
    String titleEn;
    String description;
    String descriptionEn;
    bool isPriority;
    String? mapatonUuid;
    String? mapatonTitle;
    String? mapatonLocationText;
    String? color;
    String? borderColor;
    String? icon;
    int? counter;
    String blocksJson;

    Activity({
        required this.blocks,
        required this.category,
        required this.uuid,
        required this.title,
        this.titleEn = _noTraduction,
        required this.description,
        this.descriptionEn = _noTraduction,
        required this.isPriority,
        required this.blocksJson,
    });

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        blocks: List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
        category: Category.fromJson(json["category"]),
        uuid: json["uuid"],
        title: json["title"],
        titleEn: json["title_en"] == null || json["title_en"] == '' ? _noTraduction : json["title_en"],
        description: json["description"],
        descriptionEn: json["description_en"] == null || json["description_en"] == '' ? _noTraduction : json["description_en"],
        isPriority: json["is_priority"],
        blocksJson: json["blocks"].toString()
    );

    Map<String, dynamic> toJson() => {
        "blocks": List<dynamic>.from(blocks.map((x) => x.toJson())),
        "category": category.toJson(),
        "uuid": uuid,
        "title": title,
        "title_en": titleEn,
        "description": description,
        "description_en": descriptionEn,
        "is_priority": isPriority,
    };
}

List<Block> blockListFromJson(String str) {
  return List<Block>.from(json.decode(str).map((x) => Block.fromJson(x)));
}

String blockListToJson(List<Block> data) {
  return json.encode(List<dynamic>.from(data.map((e) => e.toJson())));
}

class Block {
    String uuid;
    String blockType;
    String title;
    String titleEn;
    String description;
    String descriptionEn;
    bool isRequired;
    Options? options;
    dynamic value;

    Block({
        required this.uuid,
        required this.blockType,
        required this.title,
        this.titleEn = _noTraduction,
        required this.description,
        this.descriptionEn = _noTraduction,
        required this.isRequired,
        required this.options,
        this.value
    });

    factory Block.fromJson(Map<String, dynamic> json) => Block(
        uuid: json["uuid"],
        blockType: json["block_type"],
        title: json["title"],
        titleEn: json["title_en"] == null || json['title_en'] == '' ? _noTraduction : json["title_en"],
        description: json["description"],
        descriptionEn: json["description_en"] == null || json['description_en'] == '' ? _noTraduction : json["description_en"],
        isRequired: json["is_required"],
        options: json["options"] == null ? null : Options.fromJson(json["options"]),
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "block_type": blockType,
        "title": title,
        "title_en": titleEn,
        "description": description,
        "description_en": descriptionEn,
        "is_required": isRequired,
        "options": options?.toJson(),
        "value": value,
    };
}

class Options {
    List<Choice> choices;

    Options({
        required this.choices,
    });

    factory Options.fromJson(Map<String, dynamic> json) => Options(
        choices: List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
    };
}

class Choice {
    String label;
    String labelEn;
    String value;
    bool? checked;

    Choice({
        required this.label,
        this.labelEn = _noTraduction,
        required this.value,
        this.checked,
    });

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        label: json["label"],
        labelEn: json["label_en"] == null || json["label_en"] == '' ? _noTraduction : json["label_en"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "label_en": labelEn,
        "value": value,
    };
}

class Category {
    String uuid;
    String name;
    String nameEn;
    String code;
    String description;
    String descriptionEn;
    String color;
    String? borderColor;
    String icon;

    Category({
        required this.uuid,
        required this.name,
        this.nameEn = _noTraduction,
        required this.code,
        required this.description,
        this.descriptionEn = _noTraduction,
        required this.color,
        this.borderColor,
        required this.icon,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        uuid: json["uuid"],
        name: json["name"],
        nameEn: json["name_en"] == null || json["name_en"] == '' ? _noTraduction : json["name_en"],
        code: json["code"],
        description: json["description"],
        descriptionEn: json["description_en"] == null || json["description_en"] == '' ? _noTraduction : json["description_en"],
        color: json["color"],
        borderColor: json["border_color"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "name_en": nameEn,
        "code": code,
        "description": description,
        "description_en": descriptionEn,
        "color": color,
        "border_color": borderColor,
        "icon": icon,
    };
}