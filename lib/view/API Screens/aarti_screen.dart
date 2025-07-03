import 'package:aarati_app/widgets/recent_play_widget.dart';
import 'package:aarati_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class Aarti extends StatefulWidget {
  const Aarti({super.key});

  @override
  State<Aarti> createState() => _AartiState();
}

class _AartiState extends State<Aarti> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Aarti")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SearchBarWidget(),
            Container(
              color: Colors.white,
              width: mq.width * .94,
              height: mq.height * .32,
              padding: const EdgeInsets.all(8),
              child: Column(children: [RecentPlayWidgetForAarti()]),
            ),
          ],
        ),
      ),
    );
  }
}
