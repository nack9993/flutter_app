import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _testCollection =
      FirebaseFirestore.instance.collection('test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _testCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final document = data[index];
                      final docData = document.data() as Map<String, dynamic>;

                      return ListTile(
                        subtitle: Text(docData['message'] ?? 'No other field'),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: _addData,
                    child: const Text('Add Data to Firestore')),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addData() async {
    await _firestore.collection('test').add({
      'timestamp': FieldValue.serverTimestamp(),
      'message': 'Hello, Firestore!',
    });
  }
}
