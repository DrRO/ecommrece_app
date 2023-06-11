class Products {
  int? item_id;
  String? name;
  double? rating;
  List<String>? tags;
  double? price;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  String? image;

  Products({
    this.item_id,
    this.name,
    this.rating,
    this.tags,
    this.price,
    this.sizes,
    this.colors,
    this.description,
    this.image,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        item_id: int.parse(json["item_id"]),
        name: json["name"],
        rating: double.parse(json["rating"]),
        tags: json["tags"].toString().split(", "),
        price: double.parse(json["price"]),
        sizes: json["sizes"].toString().split(", "),
        colors: json["colors"].toString().split(", "),
        description: json['description'],
        image: json['image'],
      );
}
