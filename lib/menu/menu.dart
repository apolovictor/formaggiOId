import 'package:flutter/material.dart';
import 'package:formaggi/controllers/controller.dart';
import 'package:rect_getter/rect_getter.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formaggi/models/orders_model.dart';
import 'package:provider/provider.dart';
import 'package:formaggi/models/products_model.dart';
import 'package:formaggi/menu/product_card.dart';
import 'package:formaggi/models/Data.dart' as model;
import "package:collection/collection.dart";
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  // final String value;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final Duration animationDuration = Duration(milliseconds: 500);
  final Duration delay = Duration(milliseconds: 500);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey(); //<--Create a key
  Rect rect;

  void _onTap() {
    setState(() => rect = RectGetter.getRectFromKey(
        rectGetterKey)); //<-- set rect to be size of fab
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //<-- on the next frame...
      setState(() => rect = rect.inflate(1.3 *
          MediaQuery.of(context).size.longestSide)); //<-- set rect to be big
      Future.delayed(animationDuration + delay,
          _goToNextPage); //<-- after delay, go to next page
    });
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(FadeRouteBuilder(page: BillPage()))
        .then((_) => setState(() => rect = null));
  }

  @override
  Widget build(BuildContext context) {
    // print("Mesa ${widget.value}");
    final products = Provider.of<List<Products>>(context);
    GlobalKey _scaffold = GlobalKey();
    return Stack(
      children: [
        Scaffold(
          key: _scaffold,
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
                // IconButton(
                //     icon: SvgPicture.asset(
                //       iconBartender,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {} //do something,
                //     ),
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.help,
                      color: Colors.white,
                    ),
                    onPressed: () => {},
                  ),
                )
              ],
            ),
          ),
          body: Center(
            child: Center(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: 40),
                    if (products != null)
                      for (var product in products)
                        ProductCard(
                          products: product,
                        ),
                    if (products == null)
                      Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: RectGetter(
            key: rectGetterKey,
            child: FloatingActionButton(
              onPressed: _onTap,
              child: Icon(Icons.request_page),
              elevation: 1.5,
              tooltip: 'Minha Conta',
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        _ripple(),
      ],
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      //<--replace Positioned with AnimatedPositioned
      duration: animationDuration, //<--specify the animation duration
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}

class BillPage extends StatefulWidget {
  BillPageState createState() => BillPageState();
}

class BillPageState extends State<BillPage> {
  @override
  Widget build(BuildContext context) {
    final html.Storage _localStorage = html.window.localStorage;

    final rxPrefs = RxSharedPreferences.getInstance();
    rxPrefs.getStringStream('idDoc').listen((event) async {});

    // print(_localStorage['docId']);
    var value = _localStorage['jsonMap'];
    var docId = _localStorage['idDoc'];
    // var value == null ? value = _localStorage['jsonMap'] : Container();
    var json = jsonDecode(value);

    var list = model.Data.fromJson(json);
    final idTable = list.id;
    final username = list.username;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Conta'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
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
          //     icon: SvgPicture.asset(
          //       iconBartender,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {} //do something,
          //     ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.secondary,
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.1,
                0,
                MediaQuery.of(context).size.width * 0.1,
                0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('orders')
                        .doc(docId)
                        .collection('detailsOrder')
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      } else {
                        var datas = snapshot.data.docs
                            .map((doc) => OrdersOpened.fromDoc(doc))
                            .toList();
                        if (datas.length > 0) {
                          // print(datas.length);

                          var map = datas
                              .map((o) => {
                                    'id': o.idTable,
                                    'username': o.username,
                                    'name': o.name,
                                    'price': o.price,
                                    'amount': o.amount,
                                    'orderTime': o.orderTimeStart.toString(),
                                    'status': o.status,
                                  })
                              .toList();
                          var jsonMap = jsonEncode(map);
                          var json = jsonDecode(jsonMap);
                          Map newMap = groupBy(json, (obj) => obj['name']);
                          Map groupedAndSum = Map();

                          newMap.forEach((k, v) {
                            groupedAndSum[k] = {
                              'list': v.fold(0.00,
                                  (prev, element) => 0.00 + element['price']),
                              'sum': v.fold(0,
                                  (prev, element) => prev + element['amount']),
                              'total': v.fold(
                                  0.00,
                                  (prev, element) => prev = prev +
                                      element['price'] * element['amount']),
                            };
                          });

                          var jsonMap2 = jsonEncode(groupedAndSum);
                          var json2 = jsonDecode(jsonMap2);
                          double sumTotal = 0.00;
                          int itemTotal = 0;
                          for (var data in json2.keys) {
                            sumTotal = sumTotal + json2[data]['total'];
                            itemTotal = itemTotal + json2[data]['sum'];
                            // print(json2[data]['list']);
                            print(data);
                            // print(json2[data]['sum']);
                            // print(sumTotal);
                            // print(itemTotal);
                          }

                          return Expanded(
                            child: ListView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 50),
                                  child: json2.keys != null
                                      ? Wrap(children: [
                                          for (var data in json2.keys)
                                            Center(
                                                // color: Colors.white,
                                                // // elevation: 5,
                                                // shape: RoundedRectangleBorder(
                                                //   borderRadius:
                                                //       BorderRadius.circular(
                                                //           10.0),
                                                // ),
                                                // margin: EdgeInsets.symmetric(
                                                //     horizontal: 10,
                                                //     vertical: 10),
                                                child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                    child: Text(
                                                                      data,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  '${json2[data]['sum'].toString()}  x',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(),
                                                                child: Text(
                                                                  json2[data][
                                                                          'list']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  " = ${json2[data]['total'].toString()}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ])
                                                      ],
                                                    ))),
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Text(
                                                'Total R\$ $sumTotal'
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ])
                                      : Wrap(
                                          children: [],
                                        ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 50.0,
                                  width: 200.0,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 8,
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                      ),
                                      onPressed: () {
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: Colors.white),
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 50, 20, 20),
                                                  child: Text(
                                                      "Deseja finalizar a sua conta?",
                                                      style: TextStyle(
                                                          fontSize: 22,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                Positioned(
                                                    top: -110,
                                                    child: Image.asset(
                                                      'images/bartender.png',
                                                      width: 190,
                                                      height: 190,
                                                      color: Colors.black,
                                                    )),
                                                Positioned(
                                                  bottom: 10,
                                                  right: 0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: Text(
                                                            'Não',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            rxPrefs
                                                                .getStringStream(
                                                                    'idDoc')
                                                                .listen(
                                                                    (event) {
                                                              if (event !=
                                                                  null) {
                                                                print(event);
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'orders')
                                                                    .doc(event)
                                                                    .update(<
                                                                        String,
                                                                        dynamic>{
                                                                  'status': 4
                                                                });
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'orders')
                                                                    .doc(event)
                                                                    .collection(
                                                                        'detailsOrder')
                                                                    .where(
                                                                        'idDocument',
                                                                        isEqualTo:
                                                                            event)
                                                                    .get()
                                                                    .then(
                                                                        (res) {
                                                                  res.docs.forEach(
                                                                      (result) {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'orders')
                                                                        .doc(
                                                                            event)
                                                                        .collection(
                                                                            'detailsOrder')
                                                                        .doc(result
                                                                            .id)
                                                                        .update(<
                                                                            String,
                                                                            dynamic>{
                                                                      'status':
                                                                          4,
                                                                    });
                                                                  });

                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'tables')
                                                                      .doc(idTable
                                                                          .toString())
                                                                      .update(<
                                                                          String,
                                                                          dynamic>{
                                                                    'status': 5,
                                                                  });

                                                                  Controller()
                                                                      .invalidate();
                                                                  rxPrefs
                                                                      .dispose();
                                                                  rxPrefs.remove(
                                                                      'idDoc');
                                                                });
                                                              }
                                                            });

                                                            Navigator.pushNamed(
                                                                context, '/');
                                                          },
                                                          child: Text(
                                                            'Sim',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: datas.length > 0
                                          ? Text("Fechar Conta",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red[800],
                                              ))
                                          : null),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                              child: Text(
                            'Nenhum pedido foi realizado',
                            style: TextStyle(fontSize: 36, color: Colors.white),
                          ));
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
