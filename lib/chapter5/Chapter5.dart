import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_app/main.dart';
import 'Person.dart';
import 'ManagePeople.dart';
import 'AddPersonForm.dart';

class Chapter5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  bool _showHelp = false;
  final List<Map<String, dynamic>> _people = <Map<String, String>>[
    {"first": "Jim", "last": "Halpert"},
    {"first": "Kelly", "last": "Kapoor"},
    {"first": "Creed", "last": "Bratton"},
    {"first": "Dwight", "last": "Schrute"},
    {"first": "Andy", "last": "Bernard"},
    {"first": "Pam", "last": "Beasley"},
    {"first": "Jim", "last": "Halpert"},
    {"first": "Robert", "last": "California"},
    {"first": "David", "last": "Wallace"},
    {"first": "Erin", "last": ""},
    {"first": "Meredith", "last": "Palmer"},
    {"first": "Ryan", "last": "Howard"},
  ];

  _MyHomePage();

  @override
  Widget build(BuildContext context) {
    const String _title = "Gestures Demo";
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Stack(
        children: <Widget>[
          ManagePeople(
              people: _people,
              deletePerson: _deletePerson,
              addPerson: _addPerson,
              updatePerson: _updatePerson),
          (_showHelp == true) ? _helpDialog() : Text(""),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _showHelp = !_showHelp;
        }),
        child: Icon(Icons.help),
      ),
    );
  }

  void _deletePerson(BuildContext context, Map<String, dynamic> person) {
    setState(() {
      _people.remove(person);
      print("Deleted ${person['first']}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Deleted ${person['first']}")));
    });
  }

  void _addPerson(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        builder: (e) => AlertDialog(
              content: AddPersonForm(
                  addPerson: (Map<String, dynamic> newPerson) => setState(
                        () => _people.add(newPerson),
                      )),
            ));
  }

  void _updatePerson(Map<String, dynamic> person, {required String status}) {
    setState(() {
      person['status'] = status;
    });
  }

  Widget _helpDialog() {
    const String _helpText =
        "Swipe right to accept. Swipe left to reject. Unpich to enter a new person. Long press to delete.";
    return Positioned(
        bottom: 10,
        left: 0,
        right: 0,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.help_outline),
                title: Text("How to use this widget"),
                subtitle: Text(_helpText),
              ),
              ButtonTheme(
                  child: ButtonBar(
                children: <Widget>[
                  TextButton(
                      onPressed: () => setState(() {
                            _showHelp = !_showHelp;
                          }),
                      child: const Text("DISMISS"))
                ],
              )),
            ],
          ),
        ));
  }
}
