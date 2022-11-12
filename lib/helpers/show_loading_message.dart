// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  //
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Espere porvaor'),
        content: Text('Calculando ruta'),
        actions: [
          //
          Container(
            //width: 100,
            height: 100,
            //color: Colors.red,
            alignment: Alignment.topCenter,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              //
              Text('Cargando ruta...'),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(
                color: Colors.black,
              )
            ]),
          )
        ],
      ),
    );
    return;
  }

  showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text('Espere porvaor'),
      content: Text('Calculando ruta'),
    ),
  );
}
