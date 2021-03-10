import 'dart:html' as html;
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller {
  final rxPrefs = RxSharedPreferences.getInstance();
  final html.Storage _localStorage = html.window.localStorage;

  save(String documentId) {
    // rxPrefs.setString('idDoc', documentId);
    _localStorage['idDoc'] = documentId;
  }

  save2(jsonMap) {
    _localStorage['jsonMap'] = jsonMap;
  }

  Future getStatus() async => _localStorage['jsonMap'];
  Future<String> getDocId() async => _localStorage['docId'];
  // getDocId() {}

  // getDocId() async {
  //   // return _idDoc.value = _localStorage['idDoc'];
  //   await storage.ready;
  //   return storage.getItem('docRef').toString();
  // }

  invalidate() {
    _localStorage.remove('idDoc');
    _localStorage.remove('jsonMap');
  }
}
