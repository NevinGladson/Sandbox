import 'package:flutter/material.dart';
import 'MainPage.dart'; // Import MainPage

class TempUserForm extends StatefulWidget {
  const TempUserForm({Key? key}) : super(key: key);

  @override
  _TempUserFormState createState() => _TempUserFormState();
}

class _TempUserFormState extends State<TempUserForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 300,
            child: TextField(
              decoration: const InputDecoration(labelText: 'Enter Temporary Username'),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 300,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      // Image picking functionality removed
                    },
                    child: const Text('Select Profile Picture'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Temporary Users will be deleted after a call (you will have the option to extend for another call). It will also be deleted if the session is closed.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()), // Updated to MyHomePage
              );
            },
            child: const Text('Create Temporary User'),
          ),
        ],
      ),
    );
  }
}
