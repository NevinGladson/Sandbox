  import 'package:flutter/material.dart';

  class BecomeServerForm extends StatefulWidget {
    @override
    _BecomeServerFormState createState() => _BecomeServerFormState();
  }

  class _BecomeServerFormState extends State<BecomeServerForm> {
    String? _selectedCommunicationOption;
    String? _selectedModerationOption;
    bool _isAdmin = false;
    final TextEditingController _serverNameController = TextEditingController();

    @override
    void dispose() {
      _serverNameController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _serverNameController,
              decoration: const InputDecoration(
                labelText: 'Server Name',
                hintText: 'Default : Server',
              ),
            ),
            ListTile(
              title: const Text('All communications go through the server'),
              leading: Radio<String>(
                value: 'server',
                groupValue: _selectedCommunicationOption,
                onChanged: (value) {
                  setState(() {
                    _selectedCommunicationOption = value;
                    _selectedModerationOption = null;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Communications are moderated'),
                    leading: Radio<String>(
                      value: 'moderated',
                      groupValue: _selectedModerationOption,
                      onChanged: _selectedCommunicationOption == 'server'
                          ? (value) {
                        setState(() {
                          _selectedModerationOption = value;
                        });
                      }
                          : null,
                    ),
                  ),
                  ListTile(
                    title: const Text('Communications are stored in logs'),
                    leading: Radio<String>(
                      value: 'stored',
                      groupValue: _selectedModerationOption,
                      onChanged: _selectedCommunicationOption == 'server'
                          ? (value) {
                        setState(() {
                          _selectedModerationOption = value;
                        });
                      }
                          : null,
                    ),
                  ),
                  ListTile(
                    title: const Text('Communications are both moderated and stored'),
                    leading: Radio<String>(
                      value: 'both',
                      groupValue: _selectedModerationOption,
                      onChanged: _selectedCommunicationOption == 'server'
                          ? (value) {
                        setState(() {
                          _selectedModerationOption = value;
                        });
                      }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Communications do not go through the server'),
              leading: Radio<String>(
                value: 'direct',
                groupValue: _selectedCommunicationOption,
                onChanged: (value) {
                  setState(() {
                    _selectedCommunicationOption = value;
                    _selectedModerationOption = null;
                  });
                },
              ),
            ),
            CheckboxListTile(
              title: const Text('Would you like the server to have Admin Privileges'),
              value: _isAdmin,
              onChanged: (value) {
                setState(() {
                  _isAdmin = value ?? false;
                });
              },
            ),
          ],
        ),
      );
    }
  }
