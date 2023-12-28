import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/boredclass.dart';

class bored extends StatefulWidget {
  const bored({super.key});

  @override
  State<bored> createState() => _boredState();
}

class _boredState extends State<bored> {

  Future<Bored> boredDetails() async {
    var response = await http.get(Uri.parse('https://www.boredapi.com/api/activity'));
    return Bored.fromJson(jsonDecode(response.body));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Bored>(
            future:boredDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.activity.toString()),
                    Text(snapshot.data!.type.toString()),
                    Text(snapshot.data!.participants.toString()),
                    Text(snapshot.data!.price.toString()),
                    Text(snapshot.data!.link.toString()),
                    Text(snapshot.data!.key.toString()),
                    Text(snapshot.data!.accessibility.toString()),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
  }

