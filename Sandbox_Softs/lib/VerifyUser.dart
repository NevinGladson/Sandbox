import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for utf8.encode
import 'package:path/path.dart'; // Required for using 'join'

class VerifyUserPage extends StatefulWidget {
  final String username;

  const VerifyUserPage({Key? key, required this.username}) : super(key: key);

  @override
  _VerifyUserPageState createState() => _VerifyUserPageState();
}

class _VerifyUserPageState extends State<VerifyUserPage> {
  final TextEditingController _passwordController = TextEditingController();
  late Database _database;
  bool _obscureText = true; // Tracks whether password is hidden or visible

  @override
  void initState() {
    super.initState();
    _openDatabase();
  }

  Future<void> _openDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, 'user_database.db'));
  }

  Future<bool> _verifyPassword() async {
    final List<Map<String, dynamic>> users = await _database.query(
      'users',
      where: 'username = ?',
      whereArgs: [widget.username],
    );
    if (users.isNotEmpty) {
      final storedPasswordHash = users.first['passwordHash'];
      final enteredPasswordHash = sha256.convert(utf8.encode(_passwordController.text)).toString();
      return storedPasswordHash == enteredPasswordHash;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify User: ${widget.username}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (await _verifyPassword()) {
                  Navigator.pop(context, true); // Or navigate to another page if verification is successful
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Error'),
                      content: Text('Incorrect password.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Verify Password'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _database.close();
    super.dispose();
  }
}
