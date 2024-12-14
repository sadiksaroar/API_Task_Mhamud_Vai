import 'dart:convert';

import 'package:api_complex/reusbalow.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API_user extends StatefulWidget {
  const API_user({super.key});

  @override
  State<API_user> createState() => _API_userState();
}

class _API_userState extends State<API_user> {
  var data;

  Future<void> getUsir() async {
    final respone =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (respone.statusCode == 200) {
      data = jsonDecode(respone.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("API Task Mhamud Vai"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsir(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loadinf");
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                title: 'name',
                                value: data[index]['name'].toString(),
                              ),
                              ReusableRow(
                                  title: 'username',
                                  value: data[index]['username'].toString())
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
