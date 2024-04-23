import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Coming soon',
                        style: TextStyle(color: Colors.purpleAccent, fontSize: 40)
                    ),
                    TextSpan(
                      text: '⏱️', // emoji characters
                      style: TextStyle(
                        fontFamily: 'EmojiOne',
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("Return back")),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
