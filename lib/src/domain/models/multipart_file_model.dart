class MultipartFileModel {
  MultipartFileModel({
    required this.mapatonUuid,
    required this.field,
    required this.bytes,
    required this.filename,
    required this.path,
  });

  String mapatonUuid;
  String field;
  List<int>? bytes;
  String filename;
  String path;
}