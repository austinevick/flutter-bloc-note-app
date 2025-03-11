class NoteModel {
  final String? id;
  final String title;
  final String content;
  final bool isPinned;
  final bool isArchived;
  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.isPinned,
    required this.isArchived,
  });

  Map<String, dynamic> toMap() => {
    'title': title,
    'content': content,
    'isPinned': isPinned,
    'isArchived': isArchived,
  };
  @override
  String toString() {
    return 'NoteModel(id: $id, title: $title, content: $content, isPinned: $isPinned, isArchived: $isArchived)';
  }
}

class NoteResponseModel {
  NoteResponseModel({required this.status, required this.message, this.data});

  final int status;
  final String message;
  final List<NoteResponseData>? data;

  factory NoteResponseModel.fromJson(Map<String, dynamic> json) {
    return NoteResponseModel(
      status: json["status"] ?? 0,
      message: json["message"] ?? "",
      data:
          json["data"] == null
              ? []
              : List<NoteResponseData>.from(
                json["data"]!.map((x) => NoteResponseData.fromJson(x)),
              ),
    );
  }
  factory NoteResponseModel.fromMap(Map<String, dynamic> map) {
    return NoteResponseModel(
      status: map['status'] as int,
      message: map['message'] as String,
    );
  }
}

class NoteResponseData {
  NoteResponseData({
    required this.id,
    required this.title,
    required this.content,
    required this.isPinned,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String title;
  final String content;
  final bool isPinned;
  final bool isArchived;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int v;

  factory NoteResponseData.fromJson(Map<String, dynamic> json) {
    return NoteResponseData(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      content: json["content"] ?? "",
      isPinned: json["isPinned"] ?? false,
      isArchived: json["isArchived"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"] ?? 0,
    );
  }
}
