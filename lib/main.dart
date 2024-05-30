import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  bool switchValue = true;
  Timer? _timer;
  int _start = 60;

  void toggleIndex(int value) {
    selectedIndex = value;
    setState(() {});
  }

  void toggleSwitch(bool value) {
    switchValue = value;
    setState(() {});
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start <= 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(.3),
              radius: 18,
              child: const Icon(
                Icons.person,
                color: Colors.deepOrange,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Living Room",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.withOpacity(.8)),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "4 devices are active now",
                style:
                    TextStyle(fontSize: 16, color: Colors.grey.withOpacity(.8)),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  HomeItem(
                    icon: Icons.wind_power,
                    title: "AC",
                    onTap: () => toggleIndex(0),
                    selected: selectedIndex == 0,
                  ),
                  HomeItem(
                    icon: Icons.lightbulb,
                    title: "Lights",
                    onTap: () => toggleIndex(1),
                    selected: selectedIndex == 1,
                  ),
                  HomeItem(
                    icon: Icons.music_note,
                    title: "Music",
                    onTap: () => toggleIndex(2),
                    selected: selectedIndex == 2,
                  ),
                  HomeItem(
                    icon: Icons.lock,
                    title: "Security",
                    onTap: () => toggleIndex(3),
                    selected: selectedIndex == 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Align(
                alignment: Alignment.center,
                child: CircularCountdown(
                  countdown: _start,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedIndex == 0
                            ? "Samsung Ac"
                            : selectedIndex == 1
                                ? "Samsung lights"
                                : selectedIndex == 2
                                    ? "Samsung music"
                                    : "Samsung security",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.withOpacity(.8)),
                      ),
                      Text(
                        "Connected",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.withOpacity(.8)),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: switchValue,
                    activeColor: Colors.deepOrange,
                    onChanged: toggleSwitch,
                  ),
                ],
              ),
              GestureDetector(
                onTap: startTimer,
                child: Container(
                  height: 60,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 32),
                  decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _timer == null ? "Start" : "Started",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const HomeItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? Colors.deepOrange : Colors.grey.withOpacity(.3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularCountdown extends StatelessWidget {
  final int countdown;

  const CircularCountdown({super.key, required this.countdown});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.deepOrange),
          ),
          Text(
            '$countdown',
            style: const TextStyle(
              fontSize: 48,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
