import 'package:flutter/material.dart';
import 'forms/online_server_form.dart';
import 'forms/become_server_form.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> with SingleTickerProviderStateMixin {
  late TabController _formTabController;

  @override
  void initState() {
    super.initState();
    _formTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _formTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          controller: _formTabController,
          tabs: const [
            Tab(text: "Online Server"),
            Tab(text: "Become Server"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _formTabController,
        children: [
          OnlineServerForm(),
          BecomeServerForm(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true on Apply
              },
              child: const Text('Apply'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false on Cancel
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
