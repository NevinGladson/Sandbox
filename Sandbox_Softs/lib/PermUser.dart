import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class PermUserForm extends StatefulWidget {
  const PermUserForm({Key? key}) : super(key: key);

  @override
  _PermUserFormState createState() => _PermUserFormState();
}

class _PermUserFormState extends State<PermUserForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(join(dbPath, 'user_database.db'));
  }

  Future<bool> _checkUserExists(String username) async {
    final List<Map<String, dynamic>> result = await _database!.query(
      'users',
      columns: ['username'],
      where: 'username = ?',
      whereArgs: [username],
    );
    return result.isNotEmpty;
  }

  Future<void> _saveUserData(String username, String passwordHash) async {
    if (await _checkUserExists(username)) {
      _showDialog('User already exists. Please choose a different username.');
      return;
    }

    await _database?.insert(
      'users',
      {'username': username, 'passwordHash': passwordHash},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (!mounted) return; // Check if the widget is still mounted
    Navigator.pop(context); // Optionally navigate away or clear form
  }

  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    return sha256.convert(bytes).toString();
  }

  void _showDialog(String message) {
    if (!mounted) return; // Check if the widget is still mounted
    showDialog(
      context: context, // Use the BuildContext safely within the mounted check
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Permanent User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () async {
                final username = _usernameController.text.trim();
                if (username.isEmpty) {
                  _showDialog('Username cannot be empty.');
                  return;
                }
                final password = _passwordController.text;
                if (password.isEmpty) {
                  _showDialog('Password cannot be empty.');
                  return;
                }
                final passwordHash = _hashPassword(password);
                await _saveUserData(username, passwordHash);
              },
              child: const Text('Save User'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _database?.close();
    super.dispose();
  }
}
