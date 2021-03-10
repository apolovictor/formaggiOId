import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final int idProduct;
  final String photo;
  final String name;
  final String price;
  final String status;
  final String documentId;
  Products({
    this.idProduct,
    this.photo,
    this.name,
    this.price,
    this.status,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'idProduct': idProduct,
      'photo': photo,
      'name': name,
      'price': price,
      'status': status,
    };
  }

  static Products fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return Products(
      idProduct: doc.data()['idProduct'],
      photo: doc.data()['photo'],
      name: doc.data()['name'],
      price: doc.data()['price'],
      status: doc.data()['status'],
      documentId: doc.id,
    );
  }

  @override
  String toString() =>
      'Products(photo: $photo, idProduct: $idProduct, name: $name, price: $price, status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Products &&
        o.idProduct == idProduct &&
        o.photo == photo &&
        o.name == name &&
        o.price == price &&
        o.status == status;
  }

  @override
  int get hashCode =>
      photo.hashCode ^
      idProduct.hashCode ^
      name.hashCode ^
      price.hashCode ^
      status.hashCode;
}
