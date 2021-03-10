// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../constants/page_titles.dart';
// import '../constants/route_names.dart';
// import 'app_route_observer.dart';
// import 'package:provider/provider.dart';

// /// The navigation drawer for the app.
// /// This listens to changes in the route to update which page is currently been shown
// class AppDrawer extends StatefulWidget {
//   const AppDrawer({@required this.permanentlyDisplay, Key key, this.orders})
//       : super(key: key);

//   final bool permanentlyDisplay;
//   final orders;

//   @override
//   _AppDrawerState createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> with RouteAware {
//   String _selectedRoute;
//   AppRouteObserver _routeObserver;
//   String selectedRouteCurrent;
//   TextEditingController usernameController;
//   TextEditingController tableController;
//   @override
//   void initState() {
//     super.initState();
//     _routeObserver = AppRouteObserver();
//     usernameController = TextEditingController();
//     tableController = TextEditingController();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _routeObserver.subscribe(this, ModalRoute.of(context));
//   }

//   @override
//   void dispose() {
//     _routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   void didPush() {
//     _updateSelectedRoute();
//   }

//   @override
//   void didPop() {
//     _updateSelectedRoute();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
//     // orders.forEach(print);
//     return Drawer();
//     // if (widget.permanentlyDisplay)
//     // const VerticalDivider(
//     //   width: 1,
//     // )
//   }

//   // refreshData(table, username, context) {
//   //   if (table == "") {
//   //     Toast.show("Por favor escolha uma mesa", context,
//   //         duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//   //   } else {
//   //     final item = Orders(
//   //       id: int.parse(table),
//   //       username: username,
//   //       dateTimeStart: DateTime.now().toString(),
//   //       status: 1.toString(),
//   //     ).toMap();
//   //     FirebaseFirestore.instance.collection('orders').doc(table).set(item);
//   //     setState(() {
//   //       tableController.text = "";
//   //       tableController.text = "";
//   //     });
//   //     return Navigator.pop(context, false);
//   //   }
//   // }

//   /// Closes the drawer if applicable (which is only when it's not been displayed permanently) and navigates to the specified route
//   /// In a mobile layout, the a modal drawer is used so we need to explicitly close it when the user selects a page to display
//   Future<void> _navigateTo(BuildContext context, String routeName) async {
//     if (widget.permanentlyDisplay) {
//       Navigator.pop(context);
//     }
//     await Navigator.pushNamed(context, routeName);
//   }

//   void _updateSelectedRoute() {
//     setState(() {
//       _selectedRoute = ModalRoute.of(context).settings.name;
//     });
//   }
// }
