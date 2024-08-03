import 'package:flutter/material.dart';

class OnlineServerForm extends StatefulWidget {
  @override
  _OnlineServerFormState createState() => _OnlineServerFormState();
}

class _OnlineServerFormState extends State<OnlineServerForm> {
  String? _selectedCommunicationOption;
  String? _selectedModerationOption;
  bool _isMirror = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            '* This option is not valid for now',
            style: TextStyle(color: Colors.red),
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
            title: const Text('Would you like this local system to be a server mirror (grants Admin privileges)'),
            value: _isMirror,
            onChanged: (value) {
              setState(() {
                _isMirror = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }
}
