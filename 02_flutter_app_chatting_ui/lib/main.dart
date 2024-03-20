import 'package:flutter/material.dart';

void main() async {
  runApp(const MaterialApp(
    home: Scaffold(
      body: ChatPage(),
    ),
  ));
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // 메시지 내용을 저장할 리스트
  List messageList = [];

  // 메시지 내용 추가
  void setStateMessage(message) {
    setState(() => messageList.add(message));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // 메시지 표시 영역
        ChatArea(
          messageList: messageList,
        ),
        // 메시지 입력 영역
        InputTextArea(
          updateMessag: setStateMessage,
        )
      ],
    );
  }
}

class ChatArea extends StatefulWidget {
  final List messageList;
  const ChatArea({super.key, required this.messageList});

  @override
  State<ChatArea> createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  // 스크롤을 제어하기 위한 스크롤 컨트롤러
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // 리스트뷰에 메시지가 추가되면 스크롤을 가장 아래로 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: scrollController,
          itemCount: widget.messageList.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                // 유저 아이디
                const Text('tester'),
                Card(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    // 메시지 내용
                    child: Text(widget.messageList[index]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class InputTextArea extends StatefulWidget {
  final Function updateMessag;
  const InputTextArea({super.key, required this.updateMessag});

  @override
  State<InputTextArea> createState() => _InputTextAreaState();
}

class _InputTextAreaState extends State<InputTextArea> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            // 메시지 입력 필드
            child: TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(labelText: 'Enter your message'),
            ),
          ),
          // 입력 메시지 전송 버튼
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                widget.updateMessag(_controller.text);
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
