import 'package:flutter/material.dart';
import 'PermUser.dart'; // Make sure the file name matches the one you created
import 'TempUser.dart'; // Make sure the file name matches the one you created

class NewUserPage extends StatefulWidget {
  const NewUserPage({Key? key}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  bool isTemporary = false;  // Default to 'Permanent User'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userTypeButton('Permanent User', false),
                _userTypeButton('Temporary User', true),
              ],
            ),
            Expanded(
              child: isTemporary ? const TempUserForm() : const PermUserForm(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userTypeButton(String title, bool isTemp) {
    return GestureDetector(
      onTap: () => setState(() => isTemporary = isTemp),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isTemporary == isTemp ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isTemp ? 0 : 20.0),
            topRight: Radius.circular(isTemp ? 20.0 : 0),
            bottomLeft: Radius.circular(isTemp ? 0 : 20.0),
            bottomRight: Radius.circular(isTemp ? 20.0 : 0),
          ),
          border: Border.all(color: Colors.grey[400]!, width: 1),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isTemporary == isTemp ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
