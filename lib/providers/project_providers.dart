import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProjectProviders extends ChangeNotifier {
  List<File> _documentLists = [];

  List<File> get documentLists => _documentLists;

  void setDocument(File file) {
    _documentLists.add(file);
    notifyListeners();
  }
}
final projectProvider = ChangeNotifierProvider<ProjectProviders>((ref){
  return ProjectProviders();
});
