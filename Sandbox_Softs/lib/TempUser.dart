import 'package:flutter/material.dart';

class TempUserForm extends StatefulWidget {
  const TempUserForm({Key? key}) : super(key: key);

  @override
  _TempUserFormState createState() => _TempUserFormState();
}

class _TempUserFormState extends State<TempUserForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Enter Temporary Username',
              suffixIcon: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {},
              ),
            ),
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
          onPressed: () {},
          child: const Text('Create Temporary User'),
        ),
      ],
    );
  }
}
