import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_flutter/resources/firestore_methods.dart';

import 'like_animation.dart';

class CommentCard extends StatefulWidget {
  final snap;
  final String postId;

  const CommentCard({Key? key, required this.snap, required this.postId})
      : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  String daysBetween(DateTime from, DateTime to) {
    return (to.difference(from).inDays / 7.round() >= 1)
        ? '${((to.difference(from).inDays) / 7).toStringAsFixed(0)}w'
        : (to.difference(from).inDays).round() >= 1
            ? '${(to.difference(from).inDays).toStringAsFixed(0)}d'
            : (to.difference(from).inHours).round() >= 1
                ? '${(to.difference(from).inHours).toStringAsFixed(0)}h'
                : (to.difference(from).inMinutes).round() >= 1
                    ? '${(to.difference(from).inMinutes).toStringAsFixed(0)}m'
                    : (to.difference(from).inSeconds).round() >= 1
                        ? '${(to.difference(from).inSeconds).toStringAsFixed(0)}s'
                        : "";
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    bool isLikeAnimating = false;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(widget.snap['profilePic'])),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.snap['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${widget.snap['text']}'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                    ),
                    child: Row(
                      children: [
                        Text(
                          daysBetween(widget.snap['datePublished'].toDate(),
                              DateTime.now()),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        widget.snap['likes'].length == 0
                            ? SizedBox()
                            : Text('${widget.snap['likes'].length} likes'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Reply'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          LikeAnimation(
            isAnimating: widget.snap['likes'].contains(uid),
            smallLike: true,
            child: IconButton(
              onPressed: () async {
                FirestoreMethods().likeComment(widget.postId,
                    widget.snap['commentId'], uid, widget.snap['likes']);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              icon: widget.snap['likes'].contains(uid)
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 16,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                      size: 16,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
