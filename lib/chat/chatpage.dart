import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class Chatpage extends StatefulWidget {
  final String talkId;
  final String category;
  final String? name;
  const Chatpage(
      {Key? key, required this.talkId, required this.category, this.name})
      : super(key: key);
  @override
  _ChatpageState createState() => _ChatpageState(talkId: talkId);
}

class _ChatpageState extends State<Chatpage> {
  String talkId;
  _ChatpageState({required this.talkId});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final curr = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name ?? "No name "),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.79,
             /* child: Messages(
                talkId: widget.talkId,
                category: widget.category,
              ),*/
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        if (message.text.isNotEmpty) {





                          
                          fs
                              .collection(
                                  '${widget.category}/${widget.talkId}/MessagesList/${curr?.uid}/Messages')
                              .add({
                            'message': message.text.trim(),
                            'time': FieldValue.serverTimestamp(),
                            "driver": widget.talkId,
                            'userId': curr?.uid,
                            "name": curr?.displayName ?? "No name",
                            "driverName": widget.name,
                            "isUser": true
                          });
                          fs
                              .collection(
                                  '${widget.category}/${widget.talkId}/MessagesList')
                              .doc(curr?.uid)
                              .set({
                            'lastMsgTime': FieldValue.serverTimestamp(),
                          });
                          message.clear();
                        }
                      },
                      icon: const Icon(Icons.attach_file),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple[100],
                        hintText: 'message',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        return null;
                      },
                      onSaved: (value) {
                        message.text = value!;
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (message.text.isNotEmpty) {
                        fs
                            .collection(
                                '${widget.category}/${widget.talkId}/MessagesList/${curr?.uid}/Messages')
                            .add({
                          'message': message.text.trim(),
                          'time': FieldValue.serverTimestamp(),
                          "driver": widget.talkId,
                          'userId': curr?.uid,
                          "name": curr?.displayName ?? "No name",
                          "driverName": widget.name,
                          "isUser": true
                        });
                        fs
                            .collection(
                                '${widget.category}/${widget.talkId}/MessagesList')
                            .doc(curr?.uid)
                            .set({
                          'lastMsgTime': FieldValue.serverTimestamp(),
                        });
                        message.clear();
                      }
                    },
                    icon: const Icon(Icons.send_sharp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
