import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Simulated correct answer
  int selectedOption = -1; // -1 means no selection yet
  int correctOption = 1; // Simulating that option at index 1 is correct
  bool isAnswered = false;

  List<String> options = [
    'Found at 1926',
    'Found at 1860',
    'Found at 1935',
    'Found at 1911'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        centerTitle: true,
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Display
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  'When PACE found ?',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 24),
            // Options
            Column(
              children: List.generate(options.length, (index) {
                return GestureDetector(
                  onTap: () {
                    if (!isAnswered) {
                      setState(() {
                        selectedOption = index;
                        isAnswered = true;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isAnswered
                            ? (index == correctOption
                            ? Colors.green
                            : (index == selectedOption
                            ? Colors.red
                            : Colors.grey))
                            : Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(options[index]),
                      trailing: isAnswered
                          ? (index == correctOption
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : (index == selectedOption
                          ? Icon(Icons.cancel, color: Colors.red)
                          : null))
                          : null,
                    ),
                  ),
                );
              }),
            ),
            Spacer(),
            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Move to next question
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}