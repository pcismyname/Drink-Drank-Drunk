import 'package:flutter/material.dart';
import 'backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _bots = prefs.getStringList('ff_bots')?.map((path) => path.ref).toList() ??
        _bots;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<DocumentReference> _bots = [
    FirebaseFirestore.instance.doc('/users/31Tj6KWrfFcIZVnxx2UCyhXuvud2'),
    FirebaseFirestore.instance.doc('/users/oqwERO2q1PWqgRLpMoju28Qggex2')
  ];
  List<DocumentReference> get bots => _bots;
  set bots(List<DocumentReference> _value) {
    _bots = _value;
    prefs.setStringList('ff_bots', _value.map((x) => x.path).toList());
  }

  void addToBots(DocumentReference _value) {
    _bots.add(_value);
    prefs.setStringList('ff_bots', _bots.map((x) => x.path).toList());
  }

  void removeFromBots(DocumentReference _value) {
    _bots.remove(_value);
    prefs.setStringList('ff_bots', _bots.map((x) => x.path).toList());
  }

  void removeAtIndexFromBots(int _index) {
    _bots.removeAt(_index);
    prefs.setStringList('ff_bots', _bots.map((x) => x.path).toList());
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
