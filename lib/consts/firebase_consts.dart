import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

// collections
const userCollections = "users";
const productCollections = "products";
const cartCollections = "cart";
const chatCollections = "chats";
const messagesCollections = "messages";
const orderCollections = "orders";
