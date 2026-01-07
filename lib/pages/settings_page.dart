import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool enableMemory = true;
  bool saveVoiceRecordings = true;
  bool digaRecommendations = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Settings'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSwitchTile('Enable Memory', enableMemory, (value) {
              setState(() => enableMemory = value);
            }),
            _buildSwitchTile('Save voice recordings', saveVoiceRecordings, (value) {
              setState(() => saveVoiceRecordings = value);
            }),
            _buildSwitchTile('DiGa-Recommendations', digaRecommendations, (value) {
              setState(() => digaRecommendations = value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.green,
    );
  }
} 
