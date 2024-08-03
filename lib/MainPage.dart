import 'package:flutter/material.dart';
import 'CreatingSandbox.dart';
import 'form_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandbox',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sandbox'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.wb_sunny),
            onPressed: () {
              context.findAncestorStateOfType<_MyAppState>()?.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Sandbox',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FormWidget()),
                );

                if (result == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreatingSandbox()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Create a Sandbox'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showEnterPasswordDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Join Sandbox'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnterPasswordDialog(BuildContext context) {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Sandbox Password"),
          content: TextField(
            controller: passwordController,
            obscureText: true, // This ensures the text is hidden (password field)
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            onSubmitted: (value) {
              // Optionally handle password submission (e.g., log in) here
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Here, you'd typically validate the password and then close the dialog
                // For now, we'll just close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Enter'),
            ),
          ],
        );
      },
    );
  }
}
