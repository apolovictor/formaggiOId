import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants/route_names.dart';
import 'widgets/app_route_observer.dart';
import 'home/home.dart';
import 'menu/menu.dart';
import 'package:formaggi/models/orders_model.dart';
import 'package:formaggi/models/products_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tables = FirebaseFirestore.instance
        .collection('tables')
        .orderBy('idTable')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Tables.fromDoc(doc)).toList();
    });
    final products = FirebaseFirestore.instance
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Products.fromDoc(doc)).toList();
    });
    return MultiProvider(
      providers: [
        StreamProvider<List<Tables>>(
          create: (_) => tables,
        ),
        StreamProvider<List<Products>>(
          create: (_) => products,
        ),
      ],
      child: MaterialApp(
        title: '4Formaggi Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF0D0400),
          accentColor: Color(0xFFFC1B0D),
          pageTransitionsTheme: PageTransitionsTheme(
            // makes all platforms that can run Flutter apps display routes without any animation
            builders: Map<TargetPlatform,
                    _InanimatePageTransitionsBuilder>.fromIterable(
                TargetPlatform.values.toList(),
                key: (dynamic k) => k,
                value: (dynamic _) => const _InanimatePageTransitionsBuilder()),
          ),
        ),
        initialRoute: RouteNames.home,
        navigatorObservers: [AppRouteObserver()],
        routes: {
          RouteNames.home: (_) => Home(),
          RouteNames.menu: (_) => Menu(),
        },
      ),
    );
  }
}

/// This class is used to build page transitions that don't have any animation
class _InanimatePageTransitionsBuilder extends PageTransitionsBuilder {
  const _InanimatePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
