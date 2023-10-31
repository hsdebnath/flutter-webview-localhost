import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

final InAppLocalhostServer localhostServer = new InAppLocalhostServer();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // start the localhost server
  await localhostServer.start();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  // Get the application documents directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  print('Application Documents Directory: ${appDocDir.path}');

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    // Set the app to landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse("http://localhost:8080/assets/index.html"),
          ),
          onWebViewCreated: (controller) {},
          onLoadStart: (controller, url) {},
          onLoadStop: (controller, url) {},
          initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
            ),
          ),
        ),
      ),
    );
  }
}
