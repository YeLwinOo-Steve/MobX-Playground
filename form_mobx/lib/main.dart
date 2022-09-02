import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'form_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form MobX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final FormStore store = FormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidators();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form MobX'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.name = value,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter a username',
                  errorText: store.error.username,
                ),
              ),
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.email = value,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter an email',
                  errorText: store.error.email,
                ),
              ),
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => store.password = value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter a password',
                  errorText: store.error.password,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
