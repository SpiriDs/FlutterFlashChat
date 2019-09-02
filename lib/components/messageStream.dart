import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/components/messageBubble.dart';
import 'package:timeago/timeago.dart'
    as timeago; //! implement the timeago package for generate proper timestamps for the chat

final _firestore = Firestore.instance;

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        messages.sort(
          (a, b) => b.data['timestamp'].compareTo(a.data[
              'timestamp']), //! sort the messages in the chat via date solutuion froom Wonkun questiuons to 167
        );
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageTimestamp = message.data[
              'timestamp']; //!implement a timestamp in firebase important it have to be there a timestamp, not a number
          final elapsedTime = timeago.format(messageTimestamp
              .toDate()); //!Change format with timeago package!!! works perfect!!!
          //final date = messageTimestamp.toDate();
          //print(timeago.format(messageTimestamp.toDate()));

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            timestamp: elapsedTime, //!elapsed time i the bubble
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
