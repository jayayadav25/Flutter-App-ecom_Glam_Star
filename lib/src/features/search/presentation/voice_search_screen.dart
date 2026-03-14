import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceSearchScreen extends StatefulWidget {
  const VoiceSearchScreen({Key? key}) : super(key: key);
  @override
  State<VoiceSearchScreen> createState() => _VoiceSearchScreenState();
}

class _VoiceSearchScreenState extends State<VoiceSearchScreen> {
  final SpeechToText _speech = SpeechToText();
  bool isListening = false;
  String text = 'Say something...';

  @override
  void initState() {
    super.initState();
    _init();
  }
  Future<void> _init() async {
    await _speech.initialize();
  }
  void _toggle() async {
    if (!isListening) {
      await _speech.listen(
          onResult: (r) => setState(() => text = r.recognizedWords));
    } else {
      await _speech.stop();
    } setState(() => isListening = !isListening);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Voice Search')),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isListening ? Icons.mic : Icons.mic_none,
                size: 80,
                color: Colors.blue),
            const SizedBox(height: 20),
            Text(text,
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: _toggle,
                child: Text(isListening ? 'Stop' : 'Start')
            ),
          ],
        ),
      ),
    );
  }
}