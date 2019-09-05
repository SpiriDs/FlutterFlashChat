import 'package:flash_chat/screens/chat_screen.dart';
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

          //!implement a timestamp in firebase important it have to be there a timestamp, not a number
          final messageTimestamp = message.data['timestamp'];

          //!Change format with timeago package!!! works perfect!!!
          final elapsedTime = timeago.format(messageTimestamp.toDate());

          //! here is to identify if the current user
          final currentUser = loggedInUser.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            //!elapsed time in the bubble
            timestamp: elapsedTime,
            //! the value of the property isMe is true or false if it is written like this. So no if-statement is necessary
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
