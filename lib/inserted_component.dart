import 'dart:developer';
import 'package:flutter/material.dart';

class ImportElement extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(

            children: [Expanded(child: Text('elo'))],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'data',
                style: TextStyle(color: Colors.redAccent),
              )),
              Expanded(
                  child: Text(
                'data2',
                style: TextStyle(color: Colors.redAccent),
              )),
              Expanded(
                  child: Text(
                  'qwerqwer',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          )
        ],
      );
}
