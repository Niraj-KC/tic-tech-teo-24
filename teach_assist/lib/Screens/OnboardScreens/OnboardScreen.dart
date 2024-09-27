import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../../Utils/ThemeData/colors.dart';
import '../AuthScreens/LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _IntroState();
}

class _IntroState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: SafeArea(
          child: IntroductionScreen(
            dotsDecorator: DotsDecorator(
              activeColor: AppColors.theme["black"],
              size: Size(10.0, 10.0),
              activeSize: Size(12.0, 12.0),
              spacing: EdgeInsets.all(5.0),
            ),
            showNextButton: true,
            showSkipButton: true,
            skip: Text(
              "skip",
              style: TextStyle(
                color: AppColors.theme["black"],
              ),
            ),
            next: Text(
              "Next",
              style: TextStyle(
                color: AppColors.theme["black"],
              ),
            ),
            showDoneButton: true,
            done: Text(
              "Done",
              style: TextStyle(
                color: AppColors.theme["black"],
              ),
            ),
            globalBackgroundColor: AppColors.theme["offWhite"],
            freeze: false,
            animationDuration: 10,
            onSkip: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            onDone: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            pages: [
              PageViewModel(
                bodyWidget: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                            radius: 150,
                            backgroundColor: AppColors.theme['white']
                                .withOpacity(0.2),
                            // child: Image.asset("assets/images/ask.png")
                        ),
                      ),
                      SizedBox(height: 60,),
                      Text("Feature 1",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Here add feature very short info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Here add feature very short info",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                title: "",
              ),
              PageViewModel(
                bodyWidget: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                            radius: 150,
                            backgroundColor: AppColors.theme['white']
                                .withOpacity(0.2),
                            // child: Image.asset("assets/images/onboar2.png")
                        ),
                      ),
                      SizedBox(height: 60,),
                      Text("Discuss: Solve Together",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Join discussions, ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "find solutions from community.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                title: "",
              ),
              PageViewModel(
                bodyWidget: Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CircleAvatar(
                            radius: 150,
                            backgroundColor: AppColors.theme['white']
                                .withOpacity(0.2),
                            // child: Image.asset("assets/images/onboard3.png")
                        ),
                      ),
                      SizedBox(height: 60,),
                      Text("Connect: Unite Globally",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Bridge gaps, connect worldwide",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "know new perspectives.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                title: "",
              ),
              PageViewModel(
                title: "Screen 4",
                // image: Transform.scale(scale:2,child: Image.asset('')),
                body: "Introduction Screen 4",
                // footer: Container(color: Colors.white,height: 600,width: 200,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}