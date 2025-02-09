import 'package:flutter/material.dart';
import 'package:dart_openai/dart_openai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set your OpenAI API Key here
    OpenAI.apiKey = "your-openai-api-key"; // Replace with your actual API key
  }

  Future<void> sendMessage() async {
    String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "message": userMessage});
      isLoading = true;
    });
    _controller.clear();

    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: "gpt-4", // Use "gpt-3.5-turbo" for a cheaper option
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            role: OpenAIChatMessageRole.user,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(userMessage)
            ],
          ),
        ],
      );

      // Extract AI response correctly
String aiResponse = chatCompletion.choices.first.message.content != null
    ? chatCompletion.choices.first.message.content!
        .map((item) => item.text)
        .join(" ")
    : "No response from AI.";


      setState(() {
        messages.add({"sender": "ai", "message": aiResponse});
      });
    } catch (error) {
      setState(() {
        messages.add({"sender": "ai", "message": "Error: Unable to process request."});
      });
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EduVibe AI Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]['message'] ?? ''),
                  subtitle: Text(messages[index]['sender'] == "user" ? "You" : "EduVibe AI"),
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
