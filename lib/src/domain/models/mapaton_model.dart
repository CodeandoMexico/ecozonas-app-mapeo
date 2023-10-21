import 'dart:convert';

MapatonModel mapatonModelFromJson(String str) => MapatonModel.fromJson(json.decode(str));

String mapatonModelToJson(MapatonModel data) => json.encode(data.toJson());

class MapatonModel {
    List<Mapaton> mapatones;

    MapatonModel({
        required this.mapatones,
    });

    factory MapatonModel.fromJson(Map<String, dynamic> json) => MapatonModel(
        mapatones: List<Mapaton>.from(json["mapatones"].map((x) => Mapaton.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "mapatones": List<dynamic>.from(mapatones.map((x) => x.toJson())),
    };
}

class Mapaton {
    String uuid;
    String title;
    String locationText;
    Limits limits;
    DateTime updatedAt;
    String status;
    List<Activity> activities;
    List<CategoryElement> categories;

    Mapaton({
        required this.uuid,
        required this.title,
        required this.locationText,
        required this.limits,
        required this.updatedAt,
        required this.status,
        required this.activities,
        required this.categories,
    });

    factory Mapaton.fromJson(Map<String, dynamic> json) => Mapaton(
        uuid: json["uuid"],
        title: json["title"],
        locationText: json["location_text"],
        limits: Limits.fromJson(json["limits"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        activities: List<Activity>.from(json["activities"].map((x) => Activity.fromJson(x))),
        categories: List<CategoryElement>.from(json["categories"].map((x) => CategoryElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "location_text": locationText,
        "limits": limits.toJson(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "activities": List<dynamic>.from(activities.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Activity {
    String uuid;
    String title;
    String description;
    bool isPriority;
    ActivityCategory category;
    List<Block> blocks;
    String? mapatonUuid;
    String? mapatonTitle;
    String? mapatonLocationText;
    String? color;
    String? icon;

    Activity({
        required this.uuid,
        required this.title,
        required this.description,
        required this.isPriority,
        required this.category,
        required this.blocks,
    });

    factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        uuid: json["uuid"],
        title: json["title"],
        description: json["description"],
        isPriority: json["is_priority"],
        category: ActivityCategory.fromJson(json["category"]),
        blocks: List<Block>.from(json["blocks"].map((x) => Block.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "title": title,
        "description": description,
        "is_priority": isPriority,
        "category": category.toJson(),
        "blocks": List<dynamic>.from(blocks.map((x) => x.toJson())),
    };

    @override
  String toString() {
    // return "uuid: $uuid title: $title description: $description is_priority: $isPriority category: ${category.toJson()} blocks: ${List<dynamic>.from(blocks.map((x) => x.toJson()))}";
    return "---> blocks: ${List<dynamic>.from(blocks.map((x) => x.toJson()))}";
  }
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
    String description;
    Options? options;
    bool? isDecimal;
    bool? mandatory;
    dynamic value;

    Block({
        required this.uuid,
        required this.blockType,
        required this.title,
        required this.description,
        this.options,
        this.isDecimal = false,
        this.mandatory = false,
        this.value
    });

    factory Block.fromJson(Map<String, dynamic> json) => Block(
        uuid: json["uuid"],
        blockType: json["block_type"],
        title: json["title"],
        description: json["description"],
        options: json["options"] == null ? null : Options.fromJson(json["options"]),
        isDecimal: json["is_decimal"],
        mandatory: json["mandatory"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "block_type": blockType,
        "title": title,
        "description": description,
        "options": options?.toJson(),
        "mandatory": mandatory,
        "value": value,
    };

    @override
  String toString() {
    return '''
      "uuid": $uuid,
      "block_type": $blockType,
      "title": $title,
      "description": $description,
      "options": $options,
      "mandatory": $mandatory,
      "value": $value,
    ''';
  }
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
    String value;
    bool? checked;

    Choice({
        required this.label,
        required this.value,
        this.checked,
    });

    factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        label: json["label"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
    };
}

class ActivityCategory {
    String code;

    ActivityCategory({
        required this.code,
    });

    factory ActivityCategory.fromJson(Map<String, dynamic> json) => ActivityCategory(
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
    };
}

class CategoryElement {
    String code;
    String name;
    String description;
    String color;
    String icon;

    CategoryElement({
        required this.code,
        required this.name,
        required this.description,
        required this.color,
        required this.icon,
    });

    factory CategoryElement.fromJson(Map<String, dynamic> json) => CategoryElement(
        code: json["code"],
        name: json["name"],
        description: json["description"],
        color: json["color"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "description": description,
        "color": color,
        "icon": icon,
    };
}

class Limits {
    double north;
    double south;
    double east;
    double west;

    Limits({
        required this.north,
        required this.south,
        required this.east,
        required this.west,
    });

    factory Limits.fromJson(Map<String, dynamic> json) => Limits(
        north: json["north"]?.toDouble(),
        south: json["south"]?.toDouble(),
        east: json["east"]?.toDouble(),
        west: json["west"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "north": north,
        "south": south,
        "east": east,
        "west": west,
    };
}
