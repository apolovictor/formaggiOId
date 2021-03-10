import 'package:flutter/material.dart';
import 'package:formaggi/models/products_model.dart';
import 'package:formaggi/models/orders_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'dart:html';
import 'package:formaggi/models/Data.dart' as model;
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase/firestore.dart' as f;
import 'dart:convert';
import 'dart:async';
import 'package:formaggi/models/Data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:formaggi/controllers/controller.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class ProductCard extends StatefulWidget {
  Controller controller;
  ProductCard({Key key, this.products}) : super(key: key);
  // const ProductCard({
  //   Key key,
  //   this.value,
  //   @required this.products,
  // }) : super(key: key);

  final Products products;

  @override
  ProductCardState createState() => ProductCardState();
}

class ProductCardState extends State<ProductCard> {
  final rxPrefs = RxSharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.idDoc);

    // Text(widget.jsonMap.toString());
    // var value == null ? value = _localStorage['jsonMap'] : Container();
    // var json = jsonDecode(widget.jsonMap);

    // var list = model.Data.fromJson(json);
    // final id = list.id;
    // final username = list.username;
    // final docId = list.docId;
    // final status = list.status;
    // print(id);
    // print(username);
    // var json = jsonDecode(widget.value);
    // var list = Data.fromJson(json);

    // final id = list.id;
    // final username = list.username;

    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 40),
      child: AspectRatio(
        aspectRatio: 3 / 1,
        child: Container(
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FutureBuilder<Uri>(
                        future: downloadUrl(),
                        builder: (context, snapshot) {
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          );
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Image.network(
                            snapshot.data.toString(),
                            fit: BoxFit.cover,
                          );
                        })),
              ),
              SizedBox(
                width: 10,
              ),
              AspectRatio(
                aspectRatio: 3 / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.products.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      widget.products.price,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              IconButton(
                  icon: Icon(Icons.add_circle),
                  color: Color(0xFFFA9501),
                  iconSize: 40,
                  onPressed: () {
                    setState(() {
                      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
                      String dateFormated = dateFormat.format(DateTime.now());
                      rxPrefs.getStringStream('idDoc').listen((event) async {
                        if (event != null) {
                          final QuerySnapshot docRef = await FirebaseFirestore
                              .instance
                              .collection('orders')
                              .where('idDocument', isEqualTo: event)
                              .get();
                          final item = OrdersOpened(
                            idTable: docRef.docs.single['idTable'],
                            username: docRef.docs.single['username'],
                            idDocument: event,
                            idProduct: widget.products.idProduct,
                            name: widget.products.name,
                            price: double.parse(widget.products.price),
                            amount: 1,
                            orderTimeStart: dateFormated.toString(),
                            status: 1,
                          ).toMap();

                          FirebaseFirestore.instance
                              .collection('orders')
                              .doc(event)
                              .collection('detailsOrder')
                              .doc()
                              .set(item);
                        }
                      });

                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.all(10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFFFA9501)),
                                padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                                child: Text(
                                    "Aguarde que um garçom irá entregar seu pedido. Muito obrigado!",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                    textAlign: TextAlign.center),
                              ),
                              Positioned(
                                  top: -110,
                                  child: Image.asset('images/bartender.png',
                                      width: 190, height: 190)),
                              Positioned(
                                bottom: 10,
                                right: 0,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uri> downloadUrl() {
    return fb
        .storage()
        .refFromURL('gs://formaggi-c048a.appspot.com')
        .child(widget.products.photo)
        .getDownloadURL();
  }

  Future<Uri> uploadImageFile(File image, {String imageName}) async {
    fb.StorageReference storageRef = fb.storage().ref('images/$imageName');
    fb.UploadTaskSnapshot uploadTaskSnapshot =
        await storageRef.put(image).future;

    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    return imageUri;
  }

  orderEntryButton(context) {}
}

// class CustomImage extends StatelessWidget {
//   final String imageUrl;

//   const CustomImage({Key key, this.imageUrl}) : super(key: key);

//   Widget build(BuildContext context) {
//     ui.platformViewRegistry.registerViewFactory(
//       imageUrl,
//       (int viewId) => ImageElement()..src = imageUrl,
//     );
//     return HtmlElementView(
//       viewType: imageUrl,
//     );
//   }
// }
