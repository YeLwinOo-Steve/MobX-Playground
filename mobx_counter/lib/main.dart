import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_counter/utils.dart';

import 'action_enums.dart';
import 'counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter MobX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Counter MobX'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Counter counter = Counter();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  type: ActionTypes.add,
                  bgColor: Colors.green.shade100,
                  foregroundColor: Colors.green,
                  onTap: counter.increment,
                ),
                SizedBox(
                  width: 200,
                  child: Center(
                    child: Observer(
                      builder: (_) => Text(
                        '${counter.value}',
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Colors.teal,
                            ),
                      ),
                    ),
                  ),
                ),
                ActionButton(
                  type: ActionTypes.subtract,
                  bgColor: Colors.red.shade100,
                  foregroundColor: Colors.red,
                  onTap: counter.decrement,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.type,
    required this.bgColor,
    required this.foregroundColor,
    required this.onTap,
  }) : super(key: key);
  final ActionTypes type;
  final VoidCallback onTap;
  final Color bgColor;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
        ),
        child: Center(
          child: Icon(
            Utils.getIconFromAction(type),
            color: foregroundColor,
          ),
        ),
      ),
    );
  }
}
