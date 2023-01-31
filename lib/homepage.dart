import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:randomdata/model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getrandomdata();
  }

  String number = '';
  List<Result> name = [];
  Welcome data = Welcome();
  final amountcontroller = TextEditingController();

  TextStyle text = TextStyle(color: Colors.purple.shade900, fontSize: 20);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'RandomData Generator',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  controller: amountcontroller,
                  onChanged: (value) {
                    number = value;
                    setState(() {
                      _getrandomdata();
                    });
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Number',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  child: ListView.builder(
                    itemCount: name.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Card(
                              elevation: 4,
                              child: Image.network(
                                  "${name[index].picture!.large}")),
                        ),
                        Text("Gender : ${name[index].gender}", style: text),
                        Text("Title : ${name[index].name!.title}", style: text),
                        Text("FirstName : ${name[index].name!.first}",
                            style: text),
                        Text("LastName : ${name[index].name!.last}",
                            style: text),
                        Text(
                            "Address : ${name[index].location!.street!.number},${name[index].location!.street!.name}",
                            style: text),
                        Text("City : ${name[index].location!.city}",
                            style: text),
                        Text("State : ${name[index].location!.state}",
                            style: text),
                        Text("Country : ${name[index].location!.country}",
                            style: text),
                        Text("Postcode : ${name[index].location!.postcode}",
                            style: text),
                        Text(
                            "Latitude : ${name[index].location!.coordinates!.latitude}",
                            style: text),
                        Text(
                            "Longitude : ${name[index].location!.coordinates!.longitude}",
                            style: text),
                        Text("Email : ${name[index].email}", style: text),
                        Text("Username : ${name[index].login!.username}",
                            style: text),
                        Text("Password : ${name[index].login!.password}",
                            style: text),
                        Text("Date : ${name[index].dob!.date}", style: text),
                        Text("Age : ${name[index].dob!.age}", style: text),
                        Text("Phone : ${name[index].phone}", style: text),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _getrandomdata() async {
    String uri = "https://randomuser.me/api/?results=${amountcontroller.text}";
    var url = Uri.parse(uri);
    var response = await http.get(url);
    var responseBody = json.decode(response.body);
    data = welcomeFromJson(response.body);
    // data = Welcome.fromJson(json.decode(response.body));
    name.addAll(data.results!);
    print(name);
    // print(data.results![0]);
    // print(responseBody['results'][0]['gender']);
    setState(() {
      // print(response.body);
      // print(responseBody['gender']);
      // result = (amountcontroller.text *
      //     (responseBody["rates"][_secondcurrency.currency_name]));
    });
    return data;
    // return "Success";
  }
}

class Currency {
  String currency_name;
  Icon currency_logo;
  Currency(
    this.currency_name,
    this.currency_logo,
  );
}
