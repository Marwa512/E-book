class BookModel {
  String? name;
  String? authorName;
  String? aboutAuthor;
  String? aboutBook;

  String? coverImage;
  String? category;
  String? pdf;
  String? voice;
  String? id;
    String? price;

  BookModel({
    this.name,
    this.coverImage,
    this.category,
    this.authorName,
    this.pdf,
    this.voice,
    this.aboutAuthor,
    this.aboutBook,
    this.id,
    this.price,
  });
  BookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    authorName = json['authorName'];
    coverImage = json['coverImage'];
    pdf = json['pdf'];
    voice = json['voice'];
    aboutAuthor = json['aboutAuthor'];
    aboutBook = json['aboutBook'];
    id = json['id'];
    price=json['price'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'coverImage': coverImage,
      'authorName': authorName,
      'category': category,
      'pdf': pdf,
      'voice': voice,
      'aboutAuthor': aboutAuthor,
      'aboutBook': aboutBook,
      'id': id,
      'price':price,
    };
  }
}
