
class ChatroomModel{
  String roomName;
  String displayName;
  List<String> participants;
  String lastMsg;
  String dateTime;
  String? docid;
  bool status;
  ChatroomModel({required this.status,required this.roomName,required this.lastMsg,required this.participants,required this.dateTime,required this.displayName, required this.docid});

  Map<String, dynamic> toMap() {
    return {
      'roomName': roomName,
      'lastMsg': lastMsg,
      'dateTime': dateTime,
      'participants': participants,
      'displayName': displayName,
      'status': status
      ,'docid':docid
      // 'docid': status
    };
  }
  factory ChatroomModel.fromMap(Map<String, dynamic> map) {
    return ChatroomModel(
     docid: map['docid'],
      roomName: map['roomName'] as String,
      lastMsg: map['lastMsg'] as String,
      dateTime: map['dateTime'].toString(),
      displayName: map['displayName'] as String,
      status: map['status'] as bool,
      participants: List<String>.from(map['participants'] as List<dynamic>),
    );
  }
}