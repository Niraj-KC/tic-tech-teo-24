import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teach_assist/Screens/CommonScreens/CourseDetails/link_card.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';
import '../../../Models/Subject.dart';
import '../../../main.dart';

class CourseDetailScreen extends StatefulWidget {
  final Subject sub;
  const CourseDetailScreen({super.key, required this.sub});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool iscp = true; // is course policy selected
  bool ishw = false; // is homework selected
  bool isln = false; // is class notes selected
  String selectedTab = "Course Policy"; // Currently selected tab

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.theme['green'],
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void updateTab(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }



  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.theme['white'],
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Container(
                  child: Text(
                    (widget.sub.courseCode ?? "") + " - " + (widget.sub.name ?? ""),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Given by " + (widget.sub.departmentId ?? "") +  "  Department",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
               SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTab("Course Policy"),
                    SizedBox(width: 5),
                    _buildTab("Materials"),
                    SizedBox(width: 5),
                    _buildTab("Home Work"),
                  ],
                ),
                SizedBox(height: 20),

                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: buildTabContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabContent() {
    switch (selectedTab) {
      case "Course Policy":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Course Policy",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            LinkCard(text: "Course Policy", url: "https://drive.google.com/file/d/1KJ1rP_z1YREnss3EuNq5e2-VKZwzxSTu/view?usp=sharing")



          ],
        );
      case "Materials":
        return Container(
          child: Text(
            "Materials Content",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      case "Home Work":
        return Container(
          child: Text(
            "Home Work Content",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildTab(String tabName) {
    bool isSelected = selectedTab == tabName;
    return GestureDetector(
      onTap: () => updateTab(tabName),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColors.theme['green'] : AppColors.theme['white'],
          border: Border.all(color: AppColors.theme['black']),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Center(
          child: Text(
            tabName,
            style: TextStyle(
              color: isSelected ? AppColors.theme['white'] : AppColors.theme['black'],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }


}
