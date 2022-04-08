import 'dart:async';
import 'package:dart_utils/api/server_status_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToastService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showError(dynamic e) {
    if (e is Exception) {
      _showException(e);
    } else {
      if (e is String) {
        _showError(e);
      } else {
        if (e is Error) {
          _showError("Unexpected internal error: ${e.toString()}");
          if (kDebugMode) {
            print(e.stackTrace.toString);
          }
        } else {
          _showError(e.toString());
        }
      }
    }
    //debugPrint(e);
  }

  static void _showException(Exception e) {
    String msg;
    if (e is ServerStatusException) {
      msg =
          '''Server returns an unexpected error ${e.status}: ${e.reasonPhrase ?? ''}.
        Try it again later.
        ''';
    } else {
      if (e is TimeoutException) {
        msg = "Can't connect with the server. Is Internet available?";
      } else {
        msg = "Unexpected error: ${e.toString()}";
      }
    }
    _showError(msg);
  }

  static void _showError(String msg) {
    msg = msg.isEmpty ? "No message" : msg;
    // Be sure that the snackbar is applyed after building stater.
    Timer(const Duration(seconds: 0), () {
      scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Text(msg),
        backgroundColor: Colors.redAccent,
        padding: const EdgeInsets.all(40),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }

  static void showInfo(String msg) {
    // Be sure that the snackbar is applyed after building stater.
    Timer(const Duration(seconds: 0), () {
      scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
        content: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(msg),
          )
        ]),
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.all(40),
        behavior: SnackBarBehavior.floating,
      ));
    });
  }
}
