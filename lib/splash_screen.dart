import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:connectivity/connectivity.dart';
import 'home_screen.dart'; // Import the home screen file

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5), // Set the animation duration as needed
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Animation completed, navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });

    initConnectivity();
  }

  Future<void> initConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isOffline = true;
        _animationController.repeat(); // Make the animation loop forever
      });
    } else {
      setState(() {
        _isOffline = false;
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isOffline
            ? SizedBox(
                width: 200,
                height: 200,
                child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_kQqOcL.json',
                  controller: _animationController,
                  repeat: true,
                ),
              )
            : Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_DMgKk1.json',
                controller: _animationController,
              ),
      ),
    );
  }
}
