
class ChatroomModel{
  String roomName;
  String displayName;
  List<String> participants;
  String lastMsg;
  String dateTime;
  bool status;
  ChatroomModel({required this.status,required this.roomName,required this.lastMsg,required this.participants,required this.dateTime,required this.displayName});

  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'dateTime': dateTime,
      'participants': participants,
      'displayName': displayName,
      'status': status
    };
  }
  factory ChatroomModel.fromMap(Map<String, dynamic> map) {
    return ChatroomModel(
      roomName: map['roomName'] as String,
      lastMsg: map['lastMsg'] as String,
      dateTime: map['dateTime'] as String,
      displayName: map['displayName'] as String,
      status: map['status'] as bool,
      participants: List<String>.from(map['participants'] as List<dynamic>),
    );
  }
}