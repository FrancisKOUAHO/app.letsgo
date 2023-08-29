import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:LetsGo/globals.dart' as globals;

import '../../../../theme/LetsGo_theme.dart';
import '../../chat_screen.dart';

class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;

  const CreateGroup({required this.membersList, Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  void createGroup() async {
    setState(() {
      isLoading = true;
    });

    String groupId = const Uuid().v1();

    await _firestore.collection('groups').doc(groupId).set({
      'members': widget.membersList,
      'id': groupId,
    });

    for (int i = 0; i < widget.membersList.length; i++) {
      String id = widget.membersList[i]['id'];

      await _firestore
          .collection('users')
          .doc(id)
          .collection('groups')
          .doc(groupId)
          .set({
        'name': _groupName.text,
        'id': groupId,
      });
    }

    await _firestore.collection('groups').doc(groupId).collection('chats').add({
      'message': '${globals.userName} Created This Group.',
      'type': 'notify',
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const ChatScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: createGroup,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'Créer le groupe',
                        style: TextStyle(
                          color: Color(0xff4376FF),
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add_circle,
                        size: 22.0,
                        color: Color(0xff4376FF),
                      )
                    ],
                  )),
              const SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _groupName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              fillColor: LetsGoTheme.lightPurple,
                              filled: true,
                              contentPadding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              hintText: 'Entrez le nom du groupe',
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
