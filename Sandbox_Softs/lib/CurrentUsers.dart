import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'VerifyUser.dart';

class CurrentUsersPage extends StatefulWidget {
  const CurrentUsersPage({Key? key}) : super(key: key);

  @override
  _CurrentUsersPageState createState() => _CurrentUsersPageState();
}

class _CurrentUsersPageState extends State<CurrentUsersPage> {
  Database? _database;
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'user_database.db'),
    );
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final List<Map<String, dynamic>> users = await _database?.query('users') ?? [];
    setState(() {
      _users = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Current Users"),
      ),
      body:ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(user['avatarPath'])),
              backgroundColor: Colors.transparent,
            ),
            title: Text(user['username']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyUserPage(username: user['username']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _database?.close();
    super.dispose();
  }
}
