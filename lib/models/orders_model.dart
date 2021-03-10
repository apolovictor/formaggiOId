import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final int idOrder;
  final int idTable;
  final String username;
  final String dateTimeStart;
  final String dateTimeFinish;
  final int status;
  final String documentId;

  Orders(
      {this.idOrder,
      this.idTable,
      this.username,
      this.dateTimeStart,
      this.dateTimeFinish,
      this.status,
      this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'idOrder': idOrder,
      'idTable': idTable,
      'username': username,
      'dateTimeStart': dateTimeStart,
      'dateTimeFinish': dateTimeFinish,
      'status': status,
    };
  }

  static Orders fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return Orders(
        idOrder: doc.data()['idOrder'],
        idTable: doc.data()['idTable'],
        username: doc.data()['username'],
        dateTimeStart: doc.data()['dateTimeStart'],
        dateTimeFinish: doc.data()['dateTimeFinish'],
        status: doc.data()['status'],
        documentId: doc.id);

    // return Orders(
    //   id: doc.data()['id'],
    //   username: doc.data()['username'],
    //   dateTimeStart: doc.data()['dateTimeStart'],
    //   dateTimeFinish: doc.data()['dateTimeFinish'],
    //   status: doc.data()['status'],
    //   documentId: doc.id,
    // );
  }

  @override
  String toString() =>
      'Orders(idOrder: $idOrder, idTable: $idTable, username: $username, dateTimeStart: $dateTimeStart, dateTimeFinish: $dateTimeFinish, status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Orders &&
        o.idOrder == idOrder &&
        o.idTable == idTable &&
        o.username == username &&
        o.dateTimeStart == dateTimeStart &&
        o.dateTimeFinish == dateTimeFinish &&
        o.status == status;
  }

  @override
  int get hashCode =>
      idOrder.hashCode ^
      idTable.hashCode ^
      username.hashCode ^
      dateTimeStart.hashCode ^
      dateTimeFinish.hashCode ^
      status.hashCode;
}

class Tables {
  final int idTable;
  final int status;
  final String documentID;

  Tables({
    this.idTable,
    this.status,
    this.documentID,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTable': idTable,
      'status': status,
    };
  }

  static Tables fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return Tables(
        idTable: doc.data()['idTable'],
        status: doc.data()['status'],
        documentID: doc.id);
  }

  @override
  String toString() => 'Tables(idTable: $idTable,  status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Tables && o.idTable == idTable && o.status == status;
  }

  @override
  int get hashCode => idTable.hashCode ^ status.hashCode;
}

class OrdersOpened {
  final int idTable;
  final String username;
  final String idDocument;
  final int idProduct;
  final String name;
  final double price;
  final int amount;
  final String orderTimeStart;
  final String orderTimeFinish;
  final int status;

  final String documentId;
  OrdersOpened({
    this.idTable,
    this.username,
    this.idDocument,
    this.idProduct,
    this.name,
    this.price,
    this.amount,
    this.orderTimeStart,
    this.orderTimeFinish,
    this.status,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'idTable': idTable,
      'username': username,
      'idDocument': idDocument,
      'idProduct': idProduct,
      'name': name,
      'price': price,
      'amount': amount,
      'orderTimeStart': orderTimeStart,
      'orderTimeFinish': orderTimeFinish,
      'status': status,
    };
  }

  static OrdersOpened fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return OrdersOpened(
      idTable: doc.data()['idTable'],
      username: doc.data()['username'],
      idDocument: doc.data()['idDocument'],
      idProduct: doc.data()['idProduct'],
      name: doc.data()['name'],
      price: doc.data()['price'],
      amount: doc.data()['amount'],
      orderTimeStart: doc.data()['orderTimeStart'],
      orderTimeFinish: doc.data()['orderTimeFinish'],
      status: doc.data()['status'],
      documentId: doc.id,
    );
  }

  @override
  String toString() =>
      'OrdersOpened(idTable: $idTable, idProduct: $idProduct, idDocument: $idDocument, username: $username, name: $name, price: $price, amount: $amount, orderTimeStart: $orderTimeStart, orderTimeFinish: $orderTimeFinish,  status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OrdersOpened &&
        o.idTable == idTable &&
        o.username == username &&
        o.idDocument == idDocument &&
        o.idProduct == idProduct &&
        o.name == name &&
        o.price == price &&
        o.amount == amount &&
        o.orderTimeStart == orderTimeStart &&
        o.orderTimeFinish == orderTimeFinish &&
        o.status == status;
  }

  @override
  int get hashCode =>
      idTable.hashCode ^
      username.hashCode ^
      idDocument.hashCode ^
      idProduct.hashCode ^
      name.hashCode ^
      price.hashCode ^
      amount.hashCode ^
      orderTimeStart.hashCode ^
      orderTimeFinish.hashCode ^
      status.hashCode;
}

class BartenderReq {
  final bool id;
  final int idTable;
  final String username;
  final String idDocument;
  final String orderTimeStart;
  final String orderTimeFinish;
  final int status;

  final String documentId;
  BartenderReq({
    this.id,
    this.idTable,
    this.username,
    this.idDocument,
    this.orderTimeStart,
    this.orderTimeFinish,
    this.status,
    this.documentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idTable': idTable,
      'username': username,
      'idDocument': idDocument,
      'orderTimeStart': orderTimeStart,
      'orderTimeFinish': orderTimeFinish,
      'status': status,
    };
  }

  static BartenderReq fromDoc(DocumentSnapshot doc) {
    if (doc == null) return null;

    return BartenderReq(
      id: doc.data()['id'],
      idTable: doc.data()['idTable'],
      username: doc.data()['username'],
      idDocument: doc.data()['idDocument'],
      orderTimeStart: doc.data()['orderTimeStart'],
      orderTimeFinish: doc.data()['orderTimeFinish'],
      status: doc.data()['status'],
      documentId: doc.id,
    );
  }

  @override
  String toString() =>
      'BartenderReq(id: $id, id: $idTable,  idDocument: $idDocument, username: $username,  orderTimeStart: $orderTimeStart, orderTimeFinish: $orderTimeFinish,  status: $status)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BartenderReq &&
        o.id == id &&
        o.idTable == idTable &&
        o.username == username &&
        o.idDocument == idDocument &&
        o.orderTimeStart == orderTimeStart &&
        o.orderTimeFinish == orderTimeFinish &&
        o.status == status;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      idTable.hashCode ^
      username.hashCode ^
      idDocument.hashCode ^
      orderTimeStart.hashCode ^
      orderTimeFinish.hashCode ^
      status.hashCode;
}
