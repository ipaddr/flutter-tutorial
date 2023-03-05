import 'package:flutter/material.dart';

class AddPersonForm extends StatefulWidget {
  final Function addPerson;

  AddPersonForm({required this.addPerson});

  @override
  State<StatefulWidget> createState() {
    return _AddPersonFormState();
  }
}

class _AddPersonFormState extends State<AddPersonForm> {
  var _person = Map<String, String>();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Form(
          key: _key,
          child: Container(
            child: ListView(
              children: <Widget>[
                Text("Add a new person",
                    style: Theme.of(context).textTheme.headlineMedium),
                _buildFirstNameText(),
                _buildLastNameText(),
                ElevatedButton(
                    onPressed: () => _savePerson(context), child: Text("Save")),
              ],
            ),
          )),
    );
  }

  void _savePerson(BuildContext context) {
    if (_key.currentState?.validate() == true) {
      _key.currentState?.save();
      print("Save ${_person['first']} here");
      widget.addPerson(_person);
      Navigator.pop(context, true);
    }
  }

  Widget _buildFirstNameText() {
    return TextFormField(
      onSaved: (value) {
        _person['first'] = value!!;
      },
      decoration: InputDecoration(labelText: "First name"),
      validator: (value) {
        if (value?.isEmpty == true) return "We need a first name, plase";
      },
    );
  }

  Widget _buildLastNameText() {
    return TextFormField(
      onSaved: (value) {
        _person['last'] = value!!;
      },
      decoration: InputDecoration(labelText: "Last name"),
      validator: (value) {
        if (value?.isEmpty == true) return "We need a last name, plase";
      },
    );
  }
}
