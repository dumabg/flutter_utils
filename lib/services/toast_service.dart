import 'dart:async';
import 'dart:io';
import 'package:dart_utils/api/server_status_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ToastService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static String internalError = 'Unexpected internal error';
  static String serverInternalError = 'Server returns an unexpected error';
  static String serverInternalErrorTryAgain = 'Try it again later';
  static String noInternetError =
      'Can' 't access Internet. Is Internet available?';

  static void showError(dynamic e) {
    if (e is Exception) {
      _showException(e);
    } else {
      if (e is String) {
        _showError(e);
      } else {
        if (e is Error) {
          _showError('$internalError: ${e.toString()}');
          if (kDebugMode) {
            print(e.stackTrace.toString);
          }
        } else {
          _showError(Error.safeToString(e));
        }
      }
    }
    //debugPrint(e);
  }

  static void _showException(Exception e) {
    String msg;
    if (e is ServerStatusException) {
      msg = '''$serverInternalError ${e.status}: ${e.reasonPhrase ?? ''}.
        $serverInternalErrorTryAgain.
        ''';
    } else {
      if ((e is TimeoutException) || (e is SocketException)) {
        msg = noInternetError;
      } else {
        msg = '$internalError: ${e.toString()}';
      }
    }
    _showError(msg);
  }

  static void _showError(String msg) {
    if (msg.isNotEmpty) {
      // Be sure the snackbar is applied after build state.
      Timer(const Duration(seconds: 0), () {
        scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
          content: Text(msg,
              style: const TextStyle(color: Colors.white, fontSize: 17)),
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.all(40),
          behavior: SnackBarBehavior.floating,
        ));
      });
    }
  }

  static void showInfo(String msg) {
    // Be sure the snackbar is applied after build state.
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
