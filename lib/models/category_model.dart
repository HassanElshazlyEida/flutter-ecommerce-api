class CategoryModel {
  int? id;
  String? name;
  String? image;
  

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}