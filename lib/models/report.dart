class Report {
  final int? id;
  final int orderId;
  final String description;
  final String? imagePath;
  final String createdAt;

  Report({
    this.id,
    required this.orderId,
    required this.description,
    this.imagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'description': description,
      'image_path': imagePath,
      'created_at': createdAt,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      id: map['id'],
      orderId: map['order_id'],
      description: map['description'],
      imagePath: map['image_path'],
      createdAt: map['created_at'],
    );
  }
}
