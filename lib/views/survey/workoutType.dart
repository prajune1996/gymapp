import 'package:flutter/material.dart';
import 'dart:math';

class Item {
  static final random = Random();
  double? _size;
  Color? _color;
  int min = 10, max = 35;
  AlignmentGeometry? _alignment;

  Item() {
    _color = Color.fromARGB(random.nextInt(255), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
    _alignment =
        Alignment(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1);

    int _size = random.nextInt(35) + 10;
  }
}

class WorkoutType extends StatefulWidget {
  final num? numberOfItems;

  const WorkoutType({Key? key, this.numberOfItems}) : super(key: key);

  @override
  _WorkoutTypeState createState() => _WorkoutTypeState();
}

class _WorkoutTypeState extends State<WorkoutType>
    with SingleTickerProviderStateMixin {
  var items = <Item>[];
  var started = false;
  int? buttonValue;
  AnimationController? animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Scaffold(
                body: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 120),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'How was your workout today?',
                            style:
                                TextStyle(fontSize: 40, fontFamily: 'NexaBold'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFF44336),
                                ),
                                shape: const StadiumBorder(),
                                primary: buttonValue == 1
                                    ? const Color(0xFFF44336)
                                    : Colors.white,
                                shadowColor: const Color(0xFFF44336),
                              ),
                              child: Text(
                                'Intense',
                                style: TextStyle(
                                    fontSize: 34,
                                    fontFamily: 'NexaBold',
                                    color: buttonValue == 1
                                        ? Colors.white
                                        : Color(0xFFF44336)),
                              ),
                              onPressed: () => makeItems(1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFFF6F00),
                                ),
                                shadowColor: const Color(0xFFFF6F00),
                                shape: const StadiumBorder(),
                                primary: buttonValue == 2
                                    ? const Color(0xFFFF6F00)
                                    : Colors.white,
                              ),
                              child: Text(
                                'Medium',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: 'NexaBold',
                                  color: buttonValue == 2
                                      ? Colors.white
                                      : Color(0xFFFF6F00),
                                ),
                              ),
                              onPressed: () => makeItems(2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2.0,
                                  color: Color(0xFFFFC107),
                                ),
                                shape: const StadiumBorder(),
                                primary: buttonValue == 3
                                    ? const Color(0xFFFFC107)
                                    : Colors.white,
                                shadowColor: const Color(0xFFFFC107),
                              ),
                              child: Text(
                                'Okay okay',
                                style: TextStyle(
                                  color: buttonValue == 3
                                      ? Colors.white
                                      : Color(0xFFFFC107),
                                  fontSize: 34,
                                  fontFamily: 'NexaBold',
                                ),
                              ),
                              onPressed: () => makeItems(3),
                            ),
                          ),
                        )
                      ],
                    ))),
            ...buildItems()
          ],
        ),
      ),
    );
  }

  List<Widget> buildItems() {
    return items.map((item) {
      var tween = Tween<Offset>(
              begin: Offset(0, Random().nextDouble() * -1 - 1),
              end: Offset(Random().nextDouble() * 0.5, 2))
          .chain(CurveTween(curve: Curves.linear));
      return SlideTransition(
        position: animationController!.drive(tween),
        child: AnimatedAlign(
          alignment: item._alignment!,
          duration: const Duration(seconds: 10),
          child: AnimatedContainer(
              duration: const Duration(seconds: 10),
              child: Text(
                buttonValue == 1
                    ? '💪'
                    : buttonValue == 2
                        ? '😁'
                        : buttonValue == 3
                            ? '😣'
                            : '',
                style: const TextStyle(fontSize: 35),
              )),
        ),
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
  }

  void makeItems(int value) {
    setState(() {
      items.clear();
      for (int i = 0; i < widget.numberOfItems!; i++) {
        items.add(Item());
      }
      buttonValue = value;
    });
    animationController!.reset();
    animationController!.forward();
  }
}
