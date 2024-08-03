import 'package:flutter/material.dart';
import 'tabs/gui_tab.dart';
import 'tabs/template_tab.dart';
import 'tabs/text_editing_tab.dart';
import 'form_widget.dart';

class CreatingSandbox extends StatefulWidget {
  const CreatingSandbox({Key? key}) : super(key: key);

  @override
  _CreatingSandboxState createState() => _CreatingSandboxState();
}

class _CreatingSandboxState extends State<CreatingSandbox> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Sandbox'),
        backgroundColor: Colors.blue[800], // Dark blue for the AppBar
      ),
      body: Column(
        children: [
          Material(
            color: Colors.blue[300], // Lighter blue for the TabBar
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white, // Indicator color
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white, // Lighter for unselected tabs
              tabs: const [
                Tab(text: 'Template'),
                Tab(text: 'GUI'),
                Tab(text: 'Text Editing'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                TemplateTab(),
                GUITab(),
                TextEditingTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormWidget()),
          );

          if (result == true) {
            // Optionally handle the result here
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form applied successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Form was cancelled')),
            );
          }
        },
        child: const Icon(Icons.storage),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
