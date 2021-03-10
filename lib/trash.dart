 // await FirebaseFirestore.instance
                                        //     .collection('ordersFinished')
                                        //     .orderBy('dateTimeFinish',
                                        //         descending: true)
                                        //     .limit(1)
                                        //     .get()
                                        //     .then((event) async {
                                        //   if (event.docs.isNotEmpty) {
                                        //     Map<String, dynamic> documentData =
                                        //         event.docs.single.data();

                                        //     // print(documentData[
                                        //     //     'id']);
                                        //     print(documentData['idOrder']);
                                        //     // print(documentData[
                                        //     //     'username']);
                                        //     // print(
                                        //     //   documentData[
                                        //     //       'dateTimeFinish'],
                                        //     // );

                                        //     FirebaseFirestore.instance
                                        //         .collection('ordersFinished')
                                        //         .doc()
                                        //         .set(<String, dynamic>{
                                        //       'idOrder':
                                        //           documentData['idOrder'] + 1,
                                        //       'idTable': id,
                                        //       'username': username,
                                        //       'dateTimeStart': widget
                                        //           .order.dateTimeStart
                                        //           .toString(),
                                        //       'itens': itemTotal,
                                        //       'total': sumTotal,
                                        //       'status': 4.toString(),
                                        //       'dateTimeFinish':
                                        //           DateTime.now().toString(),
                                        //     });
                                        //     final QuerySnapshot docRef =
                                        //         await FirebaseFirestore.instance
                                        //             .collection(
                                        //                 'ordersFinished')
                                        //             .orderBy('dateTimeFinish',
                                        //                 descending: true)
                                        //             .limit(1)
                                        //             .get();
                                        //     DocumentSnapshot document =
                                        //         docRef.docs.first;
                                        //     final docId = document.id;

                                        //     FirebaseFirestore.instance
                                        //         .collection('ordersFinished')
                                        //         .doc(docId)
                                        //         .update(<String, dynamic>{
                                        //       'idDocument': docId,
                                        //     });

                                        //     final ordersReceived = Provider.of<
                                        //             List<OrdersReceived>>(
                                        //         context,
                                        //         listen: false);

                                        //     var ordersDetails =
                                        //         ordersReceived.where((e) =>
                                        //             e.id == widget.order.id);

                                        //     ordersDetails.forEach(print);
                                        //     for (var orderDetails
                                        //         in ordersDetails) {
                                        //       FirebaseFirestore.instance
                                        //           .collection('ordersFinished')
                                        //           .doc(docId)
                                        //           .collection(
                                        //               'detailsOrdersFinished')
                                        //           .doc()
                                        //           .set(<String, dynamic>{
                                        //         'idDocument': docId,
                                        //         'idTable': orderDetails.id,
                                        //         'username':
                                        //             orderDetails.username,
                                        //         'name': orderDetails.name,
                                        //         'amount': orderDetails.amount,
                                        //         'price': orderDetails.price,
                                        //         'orderTime':
                                        //             orderDetails.orderTime,
                                        //         'status': orderDetails.status,
                                        //       });
                                        //     }
                                        //     var finishTable = Orders(
                                        //       id: widget.order.id,
                                        //       username: null,
                                        //       dateTimeStart: null,
                                        //       dateTimeFinish: null,
                                        //       status: 5.toString(),
                                        //     ).toMap();
                                        //     FirebaseFirestore.instance
                                        //         .collection('orders')
                                        //         .doc(widget.order.id.toString())
                                        //         .set(finishTable);

                                        //     ordersDetails.forEach((doc) {
                                        //       FirebaseFirestore.instance
                                        //           .collection('ordersOpened')
                                        //           .doc(doc.documentId)
                                        //           .delete();
                                        //     });
                                        //   } else {
                                        //     FirebaseFirestore.instance
                                        //         .collection('ordersFinished')
                                        //         .doc()
                                        //         .set(<String, dynamic>{
                                        //       'idOrder': 1,
                                        //       'idTable': widget.order.id,
                                        //       'username': widget.order.username,
                                        //       'dateTimeStart': widget
                                        //           .order.dateTimeStart
                                        //           .toString(),
                                        //       'itens': itemTotal,
                                        //       'total': sumTotal,
                                        //       'status': 4.toString(),
                                        //       'dateTimeFinish':
                                        //           DateTime.now().toString(),
                                        //     });

                                        //     final QuerySnapshot docRef =
                                        //         await FirebaseFirestore.instance
                                        //             .collection(
                                        //                 'ordersFinished')
                                        //             .orderBy('dateTimeFinish',
                                        //                 descending: true)
                                        //             .limit(1)
                                        //             .get();
                                        //     DocumentSnapshot document =
                                        //         docRef.docs.first;
                                        //     final docId = document.id;
                                        //     print(docRef.docs.first);
                                        //     FirebaseFirestore.instance
                                        //         .collection('ordersFinished')
                                        //         .doc(docId)
                                        //         .update(<String, dynamic>{
                                        //       'idDocument': docId,
                                        //     });

                                        //     final ordersReceived = Provider.of<
                                        //             List<OrdersReceived>>(
                                        //         context,
                                        //         listen: false);

                                        //     var ordersDetails =
                                        //         ordersReceived.where((e) =>
                                        //             e.id == widget.order.id);

                                        //     ordersDetails.forEach(print);
                                        //     for (var orderDetails
                                        //         in ordersDetails) {
                                        //       FirebaseFirestore.instance
                                        //           .collection('ordersFinished')
                                        //           .doc(docId)
                                        //           .collection(
                                        //               'detailsOrdersFinished')
                                        //           .doc()
                                        //           .set(<String, dynamic>{
                                        //         'idDocument': docId,
                                        //         'idTable': orderDetails.id,
                                        //         'username':
                                        //             orderDetails.username,
                                        //         'name': orderDetails.name,
                                        //         'amount': orderDetails.amount,
                                        //         'price': orderDetails.price,
                                        //         'orderTime':
                                        //             orderDetails.orderTime,
                                        //         'status': orderDetails.status,
                                        //       });
                                        //     }
                                        //     var finishTable = Orders(
                                        //       id: widget.order.id,
                                        //       username: null,
                                        //       dateTimeStart: null,
                                        //       dateTimeFinish: null,
                                        //       status: 5.toString(),
                                        //     ).toMap();
                                        //     FirebaseFirestore.instance
                                        //         .collection('orders')
                                        //         .doc(widget.order.id.toString())
                                        //         .set(finishTable);
                                        //   }
                                        // });