import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/OnboardScreens/SplashScreen.dart';
import 'package:teach_assist/Screens/temp2.dart';

import 'API/FireStoreAPIs/subjectServices.dart';
import 'firebase_options.dart';

late Size mq ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // AppFirebaseAuth.signUp("teach1@abc.com", "12345678", Teacher(name: "t1", departmentId: "d1", subjects: ["daa"]), null, false);
  // AppFirebaseAuth.signUp("stud1@abc.com", "12345678", null, Student(name: "s1", departmentId: "d1", allocatedSubjects: [AllocatedSubjects(courseCode: "daa")]), true);
  // print("user created");

  // print("Subject start");
  // await subjectTest();
  // print("Subject end");


  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context)=>CurrentUserProvider())], child: MyApp())) ;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // home: AttendanceApp()
      // home: AttendanceApp(),

    );
  }
}
