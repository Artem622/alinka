import 'package:alinka/pages/FirstSitePage.dart';
import 'package:alinka/pages/SecondSitePage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request(); // if you need microphone permission
  await Permission.storage.request(); // if you need microphone permission
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alinka',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Slut trap"),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Future<Map<Permission, PermissionStatus>> statuses = [
                        Permission.camera,
                        Permission.microphone
                      ].request();

                      statuses.then((value) {
                        if (value.values.any((element) => element == PermissionStatus.denied ))
                          return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FirstSitePage()));
                      });
                    },
                    child: const Text("First site")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SecondSitePage()));
                    },
                    child: const Text("Second site"))
              ],
            ),
          ),
        );
      }),
    );
  }
}
