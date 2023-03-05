import 'package:flutter/material.dart';
import 'Person.dart';

class ManagePeople extends StatelessWidget {
  final List<Map<String, dynamic>> people;
  final Function deletePerson;
  final Function addPerson;
  final Function updatePerson;

  ManagePeople(
      {required this.people,
      required this.deletePerson,
      required this.addPerson,
      required this.updatePerson});

  @override
  Widget build(BuildContext context) {
    double _swipeStartX = 0.0;
    String _swipeDirection = "Right";
    return GestureDetector(
      onScaleUpdate: (ScaleUpdateDetails e) {
        if (e.scale > 2.0) addPerson(context);
      },
      onDoubleTap: () => addPerson(context),
      child: ListView(
        children: people
            .map((Map<String, dynamic> person) => GestureDetector(
                child: Person(person: person),
                onLongPress: () => deletePerson(context),
                onHorizontalDragStart: (e) =>
                    (_swipeStartX = e.globalPosition.dx),
                onHorizontalDragUpdate: (e) => _swipeDirection =
                    (e.globalPosition.dx > _swipeStartX) ? "Right" : "Left",
                onHorizontalDragEnd: (e) => {
                      if (_swipeDirection == "Right")
                        updatePerson(person, status: "nice")
                      else
                        updatePerson(person, status: "naughty")
                    }))
            .toList(),
      ),
    );
  }
}
