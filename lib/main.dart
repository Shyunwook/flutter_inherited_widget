// ignore_for_file: library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: GrandGrandParent(
            child: GrandParent(
              child: Parent(
                child: Me(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GrandGrandParent extends StatelessWidget {
  final Widget child;

  const GrandGrandParent({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    print('[BOBBY] GrandGrandParent ==== build ====');

    return Container(
      height: 300,
      width: 300,
      color: Colors.purple[300],
      child: child,
    );
  }
}

class GrandParent extends StatefulWidget {
  final Widget child;

  const GrandParent({
    super.key,
    required this.child,
  });

  @override
  State<GrandParent> createState() => _GrandParentState();
}

class _GrandParentState extends State<GrandParent> {
  Color childColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    print('[BOBBY] GrandParent ==== build ====');

    return Center(
      child: Container(
        height: 220,
        width: 220,
        color: Colors.red[300],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  childColor = Color(Random().nextInt(0xffffffff));
                });
              },
              child: const Text(
                'CHANGE COLOR',
                style: TextStyle(
                  color: Colors.indigoAccent,
                ),
              ),
            ),
            Center(
              child: ChildColor(
                color: childColor,
                child: widget.child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Parent extends StatelessWidget {
  final Widget child;

  const Parent({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    print('[BOBBY] Parent ==== build ====');

    return Center(
      child: Container(
        height: 150,
        width: 150,
        color: Colors.orange[300],
        child: child,
      ),
    );
  }
}

class Me extends StatelessWidget {
  const Me({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('[BOBBY] Me ==== build ====');

    return Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          color: ChildColor.of(context)?.color ?? Colors.redAccent,
        ),
      ),
    );
  }
}

class ChildColor extends InheritedWidget {
  final Color color;

  const ChildColor({
    super.key,
    required this.color,
    required child,
  }) : super(
          child: child,
        );

  Widget build(BuildContext context) {
    return child;
  }

  @override
  bool updateShouldNotify(ChildColor oldWidget) {
    return color != oldWidget.color;
  }

  static ChildColor? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChildColor>();
  }
}
