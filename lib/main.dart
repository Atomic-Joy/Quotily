import 'dart:ui'; // To use the BackdropFilter
import 'dart:math';
import 'package:flutter/material.dart';
import 'models/quote.dart';
import 'data/quote_data.dart';

void main() {
  runApp(QuotilyApp());
}

class QuotilyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotily',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuoteListScreen(),
    );
  }
}

class QuoteListScreen extends StatefulWidget {
  @override
  _QuoteListScreenState createState() => _QuoteListScreenState();
}

class _QuoteListScreenState extends State<QuoteListScreen> {
  final Random _random = Random();
  late Quote currentQuote;

  @override
  void initState() {
    super.initState();
    currentQuote = getRandomQuote();
  }

  Quote getRandomQuote() {
    return sampleQuotes[_random.nextInt(sampleQuotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/PinkBlackGradientBackground.jpg'),
                  fit: BoxFit.cover,  // Make sure the image covers the entire screen
                ),
              ),
            ),
          ),
          // AppBar without curve
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent, // Set transparent background for gradient
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.black], // Gradient from pink to black
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              elevation: 10, // Increased elevation for a shadow effect
              title: Text(
                'Quotily - Daily Quotes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lobster', // Use a custom font
                ),
              ),
              centerTitle: true, // Center the title
            ),
          ),
          // Content
          Positioned.fill(
            top: 120, // Start below the AppBar
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    QuoteCard(quote: currentQuote), // Your custom QuoteCard with translucency
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuote = getRandomQuote();
                        });
                      },
                      child: Text('Inspire Me'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final Quote quote;

  QuoteCard({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners for the card
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Apply rounded corners to the content
        child: Stack(
          children: [
            // Apply a gradient background with transparency (similar to AppBar)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color.fromARGB(255, 202, 23, 83).withOpacity(0.8), const Color.fromARGB(255, 151, 15, 147).withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            // Apply a blur effect using BackdropFilter for a translucent look
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Blur effect
                child: Container(
                  color: Colors.black.withOpacity(0.3), // 30% opacity to make the card translucent
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
                crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
                children: [
                  // Display the quote text in the center
                  Text(
                    '"${quote.text}"',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white, // Change text color to white for visibility
                    ),
                    textAlign: TextAlign.center,  // Center align the quote text
                  ),
                  SizedBox(height: 8),
                  // Display the author name centered
                  Text(
                    '- ${quote.author}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,  // Make the author name bold
                      color: const Color.fromARGB(255, 0, 0, 0),    // Change the text color for the author
                      fontFamily: 'Lobster',       // Custom font for the author
                    ),
                    textAlign: TextAlign.center,  // Center align the author name
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
