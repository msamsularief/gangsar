import 'package:flutter/material.dart';
import 'package:klinik/models/chat_message.dart';
import 'package:klinik/ui/widget/klinik_appbar.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final List<ChatMessage> _messages = [
    ChatMessage(
        message: "Hai, dengan Saya dr. John Doe 1, ada yang bisa Saya bantu?",
        type: "doctor"),
    ChatMessage(
        message:
            "Iya nih, dok Saya mau tanya kenapa kulit Saya kok bentol-bentol kemerahan ya?",
        type: "me"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KlinikAppBar(
        title: "Chat Detail",
        centerTitle: false,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          _buildListMessage(),
          _buildInput(),
        ],
      ),
    );
  }

  _buildListMessage() {
    return Expanded(
      child: ListView.builder(
        itemCount: _messages.length,
        itemBuilder: (_, index) => _buildMessageBubble(index),
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
      ),
    );
  }

  _buildMessageBubble(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 10, 14, 10),
      child: Align(
        alignment: _messages[index].type == "me"
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            _messages[index].message,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _messages[index].type == "doctor"
                  ? Colors.grey.shade200
                  : Theme.of(context).primaryColor.withOpacity(0.1)),
        ),
      ),
    );
  }

  _buildInput() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tuliskan pesan Anda...",
                contentPadding: EdgeInsets.only(right: 10.0, left: 10.0),
                hintStyle: TextStyle(color: Colors.black45),
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 15.0),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send, color: Colors.black45, size: 18.0),
          ),
        ],
      ),
    );
  }
}
