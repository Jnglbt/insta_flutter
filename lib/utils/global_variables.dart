import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_flutter/screens/add_post_screen.dart';
import 'package:insta_flutter/screens/feed_screen.dart';
import 'package:insta_flutter/screens/profile_screen.dart';
import 'package:insta_flutter/screens/search_screen.dart';

const webScreenSize = 600;
const mobileScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('notif'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

List<Widget> webScreenItems = [
  const FeedScreen(),
  const Text('messages'),
  const AddPostScreen(),
  const SearchScreen(),
  const Text('notif'),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
