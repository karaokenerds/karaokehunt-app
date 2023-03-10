import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

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
    _playlist = prefs.getStringList('ff_playlist')?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        }).toList() ??
        _playlist;
    _songsdb = prefs.getStringList('ff_songsdb')?.map((x) {
          try {
            return jsonDecode(x);
          } catch (e) {
            print("Can't decode persisted json. Error: $e.");
            return {};
          }
        }).toList() ??
        _songsdb;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  List<dynamic> _playlist = [];
  List<dynamic> get playlist => _playlist;
  set playlist(List<dynamic> _value) {
    _playlist = _value;
    prefs.setStringList(
        'ff_playlist', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToPlaylist(dynamic _value) {
    _playlist.add(_value);
    prefs.setStringList(
        'ff_playlist', _playlist.map((x) => jsonEncode(x)).toList());
  }

  void removeFromPlaylist(dynamic _value) {
    _playlist.remove(_value);
    prefs.setStringList(
        'ff_playlist', _playlist.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromPlaylist(int _index) {
    _playlist.removeAt(_index);
    prefs.setStringList(
        'ff_playlist', _playlist.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _songsdb = [];
  List<dynamic> get songsdb => _songsdb;
  set songsdb(List<dynamic> _value) {
    _songsdb = _value;
    prefs.setStringList(
        'ff_songsdb', _value.map((x) => jsonEncode(x)).toList());
  }

  void addToSongsdb(dynamic _value) {
    _songsdb.add(_value);
    prefs.setStringList(
        'ff_songsdb', _songsdb.map((x) => jsonEncode(x)).toList());
  }

  void removeFromSongsdb(dynamic _value) {
    _songsdb.remove(_value);
    prefs.setStringList(
        'ff_songsdb', _songsdb.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromSongsdb(int _index) {
    _songsdb.removeAt(_index);
    prefs.setStringList(
        'ff_songsdb', _songsdb.map((x) => jsonEncode(x)).toList());
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
