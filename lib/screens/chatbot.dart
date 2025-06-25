// ----------------------------- flora_bot.dart -----------------------------
// Chat screen autonome : à pousser depuis n'importe où dans l’app.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ---------------- DATA MODEL ----------------
class Message {
  final String text;
  final bool isUser;
  const Message({required this.text, required this.isUser});
}

// ------------- ENTRY POINT WIDGET -----------
class FloraBotScreen extends StatelessWidget {
  const FloraBotScreen({super.key});

  @override
  Widget build(BuildContext context) => const ChatScreen();
}

// --------------- VIEW STATES ---------------
enum ChatViewState { initial, chat, voice }

// ---------------- CHAT SCREEN --------------
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textCtrl = TextEditingController();
  final _messages = <Message>[];
  ChatViewState _state = ChatViewState.initial;

  // Palette
  static const userBubbleColor = Color(0xFF446A46);
  static const botBubbleColor = Color(0xFFF1F1F1);

  // ---------------- SEND -------------------
  void _handleSend() {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _state = ChatViewState.chat;
      _messages.insert(0, Message(text: text, isUser: true));
      _textCtrl.clear();
      _addBotResponse(text);
    });
  }

  // ----------- BOT INTENTS + RESPONSES -----
  void _addBotResponse(String userMessage) {
    final msg = userMessage.toLowerCase();

    String bot =
        "Je suis là pour vous aider avec le jardinage. Que puis-je faire pour vous ?";

    if (msg.contains('bonjour')) {
      bot =
          "Bonjour ! Comment puis-je vous aider avec votre jardin aujourd’hui ?";
    } else if ((msg.contains('aventure') || msg.contains('exploration'))) {
      bot =
          "Que diriez-vous de « Rosier Explorateur » ? Il évoque l’aventure et la découverte. Besoin d’autres idées ?";
    } else if (msg.contains('élégant') || msg.contains('intemporel')) {
      bot =
          "Pour un style élégant et intemporel : « Jardin d’Éden » ou « Fleur de Lys ».";
    }
    // ---- NOUVELLE INTENTION : ARBRES À ARROSER ----
    else if (msg.contains('arbres') && msg.contains('arroser')) {
      bot = """
Voici les arbres qui nécessitent un arrosage cette semaine :
• **Ginkgo biloba** (jeunes sujets)  
• **Jacaranda mimosifolia**  
• **Ficus macrophylla** (en pot)  
• **Washingtonia robusta**  
• **Citrus sinensis** (orangeraie pédagogique)
Astuce : arrosez tôt le matin pour limiter l’évaporation 🌞
""";
    }

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _messages.insert(0, Message(text: bot, isUser: false)));
    });
  }

  void _handleSuggestionTap(String suggestion) {
    _textCtrl.text = suggestion;
    _handleSend();
  }

  // ---------------- BUILD ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: userBubbleColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('ELHamma AI',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: _buildBody(),
            ),
          ),
          _buildTextInput(),
        ],
      ),
    );
  }

  // ------------- BODY VARIANTS -------------
  Widget _buildBody() {
    switch (_state) {
      case ChatViewState.initial:
        return _buildInitial();
      case ChatViewState.voice:
        return _buildVoice();
      case ChatViewState.chat:
        return _buildChat();
    }
  }

  Widget _buildInitial() => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/robot.png', height: 100),
            const SizedBox(height: 30),
            const ChatBubble(
              message: Message(
                text: "✨ Bonjour, je suis FloraBot ! Posez-moi vos questions.",
                isUser: false,
              ),
            ),
            const SizedBox(height: 12),
            const ChatBubble(
              message: Message(
                text: "✨ Voici quelques sujets que nous pouvons aborder :",
                isUser: false,
              ),
              showSuggestions: true,
            ),
          ],
        ),
      );

  Widget _buildChat() => ListView.builder(
        reverse: true,
        padding: const EdgeInsets.all(16),
        itemCount: _messages.length,
        itemBuilder: (_, i) => ChatBubble(message: _messages[i]),
      );

  Widget _buildVoice() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Je vous écoute...",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700])),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 5)),
                ],
              ),
              child:
                  const Icon(Icons.mic_none, color: userBubbleColor, size: 60),
            ),
            const SizedBox(height: 40),
            Text("Parlez, je vous écoute.",
                style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          ],
        ),
      );

  // ------------- INPUT AREA ----------------
  Widget _buildTextInput() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _textCtrl,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Écrivez votre message...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.mic, color: Colors.grey[600]),
                        onPressed: () => setState(() => _state =
                            _state == ChatViewState.voice
                                ? ChatViewState.initial
                                : ChatViewState.voice),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: _textCtrl.text.isNotEmpty ? _handleSend : null,
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _textCtrl.text.isNotEmpty
                        ? userBubbleColor
                        : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.send, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ),
      );
}

// ---------------- CHAT BUBBLE ----------------
class ChatBubble extends StatelessWidget {
  final Message message;
  final bool showSuggestions;
  const ChatBubble(
      {super.key, required this.message, this.showSuggestions = false});

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      'Fréquence d\'arrosage',
      'Périodes de floraison',
      'Meilleurs engrais',
      'Taille des plantes',
      'Lutte parasites',
      'Conseils pour semis',
      'Quels arbres à arroser ?', // ← on ajoute la nouvelle question
    ];
    final isUser = message.isUser;

    return Column(
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isUser
                      ? _ChatScreenState.userBubbleColor
                      : _ChatScreenState.botBubbleColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(message.text,
                    style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87)),
              ),
            ),
            if (!isUser)
              IconButton(
                icon: Icon(Icons.copy_outlined,
                    color: Colors.grey[400], size: 18),
                onPressed: () {},
                splashRadius: 18,
              ),
          ],
        ),
        if (showSuggestions)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: suggestions
                  .map((s) => SuggestionChip(
                        label: s,
                        onTap: () => (context as Element)
                            .findAncestorStateOfType<_ChatScreenState>()!
                            ._handleSuggestionTap(s),
                      ))
                  .toList(),
            ),
          ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// ---------------- SUGGESTION CHIP -----------
class SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const SuggestionChip({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(label, style: const TextStyle(color: Colors.black54)),
        ),
      );
}
