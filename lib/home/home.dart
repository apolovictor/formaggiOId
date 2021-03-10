import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formaggi/models/orders_model.dart';
import 'package:formaggi/controllers/controller.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import 'package:flutter_tags/flutter_tags.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  // final GlobalKey<NavigatorState> navigatorKey =
  //     new GlobalKey<NavigatorState>();
  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController tableController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: this.usernameController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Seu Nome",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final tables = Provider.of<List<Tables>>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/4formaggi.jpeg"),
                      fit: BoxFit.fill)),
            ),
          ),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                onPressed: () => {},
              ),
            )
            // IconButton(
            //     icon: FractionallySizedBox(
            //       heightFactor: 0.75,
            //       child: SvgPicture.asset(
            //         iconBartender,
            //         color: Colors.white,
            //       ),
            //     ),
            //     onPressed: () {} //do something,
            //     ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: emailField,
              ),
              SizedBox(height: 40),
              Center(
                child:
                    Text('Escolha a sua mesa:', style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 10),
              if (tables != null)
                Tags(
                  // key: _tagStateKey,
                  itemCount: tables.length,
                  symmetry: true,
                  columns: 3,
                  itemBuilder: (int index) {
                    final item = tables[index];
                    return item.status == 5
                        ? ItemTags(
                            key: Key(index.toString()),
                            active: false,
                            singleItem: true,
                            // borderRadius: BorderRadius.all(Radius.circular(70)),
                            border: Border.all(width: 2.0, color: Colors.white),
                            color: Colors.white,
                            activeColor: Color(0xFFFA9501),
                            splashColor: Colors.white,
                            textStyle: TextStyle(fontSize: 26),
                            combine: ItemTagsCombine.withTextAfter,

                            // active: orders[index].id,

                            index: index,
                            title: "${item.idTable}",

                            // icon: ItemTagsIcon(
                            //   icon: Icons.restaurant,
                            // ),
                            onPressed: (item) =>
                                tableController.text = item.title,
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Column(children: [
                              Text('Ocupado'),
                              LinearProgressIndicator()
                            ]));
                  },
                ),
              // ProductCard(orders: product),
              if (tables == null) Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 1.5,
        onPressed: () {
          setState(() {
            refreshData(tableController.text, usernameController.text, context);
          });

          Navigator.pushNamed(context, '/menu/menu/');
        },
        tooltip: 'Ir para o Menu',
        child: Icon(Icons.login),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  refreshData(table, username, context) {
    if (table == "") {
      Toast.show("Por favor escolha uma mesa", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return true;
    } else {
      FirebaseFirestore.instance
          .collection('orders')
          .orderBy('idOrder', descending: true)
          .limit(1)
          .get()
          .then((event) {
        if (event.docs.isNotEmpty) {
          Map<String, dynamic> documentData = event.docs.single.data();
          createOrder(table, username, documentData['idOrder']);
        } else {
          createOrder(table, username, null);
        }
      });
      return true;
    }
  }
}

createOrder(table, username, idOrder) async {
  idOrder = idOrder == null ? 1 : idOrder + 1;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String dateFormated = dateFormat.format(DateTime.now());
  final item = Orders(
    idOrder: idOrder,
    idTable: int.parse(table),
    username: username,
    dateTimeStart: dateFormated,
    status: 1,
  ).toMap();
  FirebaseFirestore.instance.collection('orders').doc().set(item);
  final QuerySnapshot docRef = await FirebaseFirestore.instance
      .collection('orders')
      .where('idOrder', isEqualTo: idOrder)
      .get();
  DocumentSnapshot document = docRef.docs.first;
  final docId = document.id;

  await FirebaseFirestore.instance
      .collection('orders')
      .doc(docId)
      .update(<String, dynamic>{
    'idDocument': docId,
  });
  FirebaseFirestore.instance
      .collection('tables')
      .doc(table)
      .update(<String, dynamic>{
    'status': 1,
  });
  var map = {
    'id': int.parse(table),
    'username': username,
    'docRef': docId.toString(),
    'status': docRef.docs.single['status'].toString()
  };
  final rxPrefs = RxSharedPreferences.getInstance();
  var jsonMap = jsonEncode(map);
  rxPrefs.setString('idDoc', docId.toString());
  Controller().save(docId.toString());
  Controller().save2(jsonMap);
}

// class IdRepository {
//   final html.Storage _localStorage = html.window.localStorage;

//   Future save(String jsonMap) async {
//     _localStorage['jsonMap'] = jsonMap;
//   }

//   // Future save2(String docId, String status) async {
//   //   _localStorage['docId'] = docId;
//   //   _localStorage['status'] = status;
//   // }
//   Future<String> getJsonMap() async => _localStorage['jsonMap'];
//   // Future<String> getDocId() async => _localStorage['docId'];
//   // Future<String> getStatus() async => _localStorage['status'];

//   Future invalidate() async {
//     _localStorage.remove('jsonMap');
//     // _localStorage.remove('docId');
//     // _localStorage.remove('status');
//   }
// }
