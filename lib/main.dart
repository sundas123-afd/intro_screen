import 'package:flutter/material.dart';

void main() => runApp(OnboardingApp());

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  List<Map<String, String>> pages = [
    {
      "title": "Welcome to TravelGo",
      "subtitle": "Discover amazing places around the world.",
      "image": "https://cdn-icons-png.flaticon.com/512/854/854878.png"
    },
    {
      "title": "Plan Your Trip",
      "subtitle": "Find and book the best hotels & flights.",
      "image": "https://cdn-icons-png.flaticon.com/512/201/201623.png"
    },
    {
      "title": "Enjoy Your Journey",
      "subtitle": "Make memories that last a lifetime.",
      "image": "https://cdn-icons-png.flaticon.com/512/2331/2331937.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        onPageChanged: (index) => setState(() => currentPage = index),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(page["image"]!, height: 200),
                SizedBox(height: 40),
                Text(
                  page["title"]!,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                Text(
                  page["subtitle"]!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: currentPage == pages.length - 1
          ? TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 60)),
              onPressed: () {
                // Yahan next screen navigate kar sakte ho (like LoginPage)
              },
              child: Text("Get Started", style: TextStyle(color: Colors.white)),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _controller.jumpToPage(pages.length - 1),
                    child: Text("Skip"),
                  ),
                  Row(
                    children: List.generate(
                      pages.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Colors.blueAccent
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        _controller.nextPage(duration: Duration(milliseconds: 400), curve: Curves.easeIn),
                    child: Text("Next"),
                  ),
                ],
              ),
            ),
    );
  }
}
