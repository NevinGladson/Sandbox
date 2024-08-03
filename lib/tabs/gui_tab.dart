import 'package:flutter/material.dart';

class GUITab extends StatelessWidget {
  const GUITab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Center(
          child: Text('GUI features here'),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: ElevatedButton(
            onPressed: () {
              _showAddGroupDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white, // Set text color to white
            ),
            child: const Text('Add Group'),
          ),
        ),
      ],
    );
  }

  void _showAddGroupDialog(BuildContext context) {
    TextEditingController groupNameController = TextEditingController();
    String? selectedRule;
    bool notAudio = false;
    bool noChatVideo = false;
    bool noChatAudio = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Group Name'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: groupNameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter group name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Rules', style: TextStyle(fontWeight: FontWeight.bold)),
                    ListTile(
                      title: const Text('Video'),
                      leading: Radio<String>(
                        value: 'Video',
                        groupValue: selectedRule,
                        onChanged: (value) {
                          setState(() {
                            selectedRule = value;
                          });
                        },
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('Not Audio'),
                      value: notAudio,
                      onChanged: (selectedRule == 'Video')
                          ? (value) {
                        setState(() {
                          notAudio = value ?? false;
                        });
                      }
                          : null,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.only(left: 32.0),
                    ),
                    CheckboxListTile(
                      title: const Text('No Chat'),
                      value: noChatVideo,
                      onChanged: (selectedRule == 'Video')
                          ? (value) {
                        setState(() {
                          noChatVideo = value ?? false;
                        });
                      }
                          : null,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.only(left: 32.0),
                    ),
                    ListTile(
                      title: const Text('Audio'),
                      leading: Radio<String>(
                        value: 'Audio',
                        groupValue: selectedRule,
                        onChanged: (value) {
                          setState(() {
                            selectedRule = value;
                          });
                        },
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text('No Chat'),
                      value: noChatAudio,
                      onChanged: (selectedRule == 'Audio')
                          ? (value) {
                        setState(() {
                          noChatAudio = value ?? false;
                        });
                      }
                          : null,
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: const EdgeInsets.only(left: 32.0),
                    ),
                    ListTile(
                      title: const Text('Chat'),
                      leading: Radio<String>(
                        value: 'Chat',
                        groupValue: selectedRule,
                        onChanged: (value) {
                          setState(() {
                            selectedRule = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Ensure the group name and one of the radio buttons are selected
                if (groupNameController.text.isNotEmpty && selectedRule != null) {
                  // Handle the submission of the group name and selected rule here
                  String groupName = groupNameController.text;
                  // Process the group name and selected rule as needed
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show an alert or snackbar to indicate that group name and rule are required
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Group name and rule are required.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white, // Set text color to white
              ),
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
