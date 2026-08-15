import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AIService aiService = AIService();
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> loadHistory() async {
    try {
      final chats = await aiService.getHistory();

      List<Map<String, dynamic>> loadedMessages = [];

      for (var chat in chats) {
        loadedMessages.add({
          "role": "user",
          "text": chat["question"],
          "time": chat["createdAt"],
        });

        loadedMessages.add({
          "role": "bot",
          "text": chat["response"],
          "time": chat["createdAt"],
        });
      }

      setState(() {
        messages = loadedMessages;
      });

      scrollToBottom();
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendMessage() async {
    final message = controller.text.trim();

    if (message.isEmpty) return;

    setState(() {
      messages.add({
        "role": "user",
        "text": message,
        "time": DateTime.now().toIso8601String(),
      });

      isLoading = true;
    });

    scrollToBottom();
    controller.clear();

    try {
      final response = await aiService.sendMessage(message);

      setState(() {
        messages.add({
          "role": "bot",
          "text": response,
          "time": DateTime.now().toIso8601String(),
        });
      });

      scrollToBottom();
    } catch (e) {
      setState(() {
        messages.add({
          "role": "bot",
          "text": "Error: $e",
          "time": DateTime.now().toIso8601String(),
        });
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Campus AI Assistant")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];

                final text = msg["text"] ?? "";
                final isUser = msg["role"] == "user";
                final time = msg["time"] ?? "";
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  child: Column(
                    crossAxisAlignment: isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            child: Text(isUser ? "👤" : "🤖"),
                          ),

                          const SizedBox(width: 6),

                          Text(
                            isUser ? "You" : "Campus AI",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.blue : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text,
                                style: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                time.isNotEmpty
                                    ? DateTime.parse(
                                        time,
                                      ).toLocal().toString().substring(11, 16)
                                    : "",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isUser
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          if (isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(radius: 14, child: Text("🤖")),

                  const SizedBox(width: 8),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Campus AI is typing...",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Ask about the campus...",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),

                const SizedBox(width: 8),

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

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
