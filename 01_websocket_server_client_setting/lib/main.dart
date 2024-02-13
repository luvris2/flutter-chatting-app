import 'dart:io';

void main() async {
  // 웹 소켓 서버 연결
  WebSocket socket = await WebSocket.connect('ws://192.168.10.103:4001');

  // 소켓 서버에 데이터 송신
  socket.add("Hello?");

  socket.listen((data) {
    print("서버로부터 받은 값 : $data");
  });
}
