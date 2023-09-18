import 'package:dellminds_mobile_app/screens/home/home.dart';
import 'package:flutter/material.dart';

List<String> imagePaths = List.generate(
  21,
  (index) => 'assets/tutorial_slides/${index + 1}.png',
);

class TutorialPage extends StatefulWidget {
  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < imagePaths.length - 1) {
      setState(() {
        _currentPage++;
      });
    } else {
      // Navigate to HomeScreen when at the end of the tutorial
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePaths[_currentPage]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: _currentPage > 0
                ? ElevatedButton(
                    onPressed: _previousPage,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  )
                : SizedBox(),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Icon(
                _currentPage == imagePaths.length - 1
                    ? Icons.done
                    : Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
