import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'message.dart';

class Chatpage extends StatefulWidget {
  final String getterId;
  final String sender;
  final String getter;
  final String? getterName;
  const Chatpage({
    Key? key,
    required this.getterId,
    required this.getter,
    this.getterName,
    required this.sender,
  }) : super(key: key);
  @override
  _ChatpageState createState() => _ChatpageState(getterId: getterId);
}

class _ChatpageState extends State<Chatpage> {
  String getterId;
  _ChatpageState({required this.getterId});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final curr = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.getterName ?? "No name "),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Messages(
                getter: widget.getter,
                getterId: widget.getterId,
                sender: widget.sender,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        final firebaseStorage = FirebaseStorage.instance;
                        final imagePicker = ImagePicker();
                        XFile? image;
                        //Check Permissions
                        await Permission.photos.request();
                        var imgUrl = "";
                        var permissionStatus = await Permission.photos.status;

                        if (permissionStatus.isGranted) {
                          //Select Image
                          image = await imagePicker.pickImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            var file = File(image.path);
                            print("*******************");
                            print(image.path);
                            var snapshot = await firebaseStorage
                                .ref()
                                .child(
                                    '${widget.getter}/${curr?.uid}/MessagesImg')
                                .putFile(file);

                            imgUrl = await snapshot.ref.getDownloadURL();
                            print(imgUrl.toString());
                          } else {
                            print('No Image Path Received');
                          }
                        } else {
                          print(
                              'Permission not granted. Try Again with permission access');
                        }
                        fs
                            .collection(
                                '${widget.getter}/${widget.getterId}/MessagesList/${curr?.uid}/Messages')
                            .add({
                          'message': "Image",
                          'time': FieldValue.serverTimestamp(),
                        
                          'getterId': curr?.uid,
                          "name": curr?.displayName ?? "No name",
                          "isMe": false,
                          "imgUrl": imgUrl,
                          "isImage": true
                        });
                        fs
                            .collection(
                                '${widget.getter}/${widget.getterId}/MessagesList')
                            .doc(curr?.uid)
                            .set({
                          //"name": curr?.displayName ?? "No name",
                          'lastMsgTime': FieldValue.serverTimestamp(),
                          'message': "Image",
                          'isRespone': true
                        }, SetOptions(merge: true));
                        fs
                            .collection(
                                '${widget.sender}/${curr?.uid}/MessagesList/${widget.getterId}/Messages')
                            .add({
                          'message': message.text.trim(),
                          'time': FieldValue.serverTimestamp(),
                          "getterId": widget.getterId,
                          
                          "name": widget.getterName ?? "NO Name",
                          "isMe": true,
                          "isImage": true,
                          "imgUrl": imgUrl,
                        });
                        fs
                            .collection(
                                '${widget.sender}/${curr?.uid}/MessagesList')
                            .doc(widget.getterId)
                            .set({
                          //"name": curr?.displayName ?? "No name",
                          'lastMsgTime': FieldValue.serverTimestamp(),
                          'message': "Image",
                          'isRespone': true
                        }, SetOptions(merge: true));
                        message.clear();
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
                                '${widget.getter}/${widget.getterId}/MessagesList/${curr?.uid}/Messages')
                            .add({
                          'message': message.text.trim(),
                          'time': FieldValue.serverTimestamp(),
                          
                          'getterId': curr?.uid,
                          "name": curr?.displayName ?? "No name",
                         
                          "isImage": false,
                          "imgUrl": "",
                          "isMe": false,
                        });
                        fs
                            .collection(
                                '${widget.getter}/${widget.getterId}/MessagesList')
                            .doc(curr?.uid)
                            .set({
                          //"name": curr?.displayName ?? "No name",
                          'lastMsgTime': FieldValue.serverTimestamp(),
                          'message': message.text.trim(),
                          'isRespone': true
                        }, SetOptions(merge: true));
                        fs
                            .collection(
                                '${widget.sender}/${curr?.uid}/MessagesList/${widget.getterId}/Messages')
                            .add({
                          'message': message.text.trim(),
                          'time': FieldValue.serverTimestamp(),
                          "getterId": widget.getterId,
                          
                          "name":  widget.getterName ?? "NO Name",
                          "isMe": true,
                          "isImage": false,
                          "imgUrl": "",
                        });
                        fs
                            .collection(
                                '${widget.sender}/${curr?.uid}/MessagesList')
                            .doc(widget.getterId)
                            .set({
                          //"name": widget.getterName ?? "No name",
                          'lastMsgTime': FieldValue.serverTimestamp(),
                          'message': message.text.trim(),
                          'isRespone': true
                        }, SetOptions(merge: true));
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
