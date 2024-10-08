import 'package:flutter/material.dart';
import 'package:teach_assist/Screens/CommonScreens/CourseDetails/CourseDetailsScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import '../Models/Subject.dart';
import '../Utils/ThemeData/colors.dart';

class CourseCard extends StatefulWidget {
  final Subject sub;
  final bool isStudent ;
  const CourseCard({super.key, required this.sub, required this.isStudent});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {

  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Center(
        child: Transform.scale(
          scale: _scale,
          child: Container(
            height: 250,
            // width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: InkWell(
              onTap: (){
                Navigator.push(context, LeftToRight(CourseDetailScreen(sub: widget.sub, isStudent: widget.isStudent,))) ;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.theme['offWhite'],
                      borderRadius: BorderRadius.circular(10).copyWith(
                        bottomLeft: Radius.zero,
                        bottomRight: Radius.zero,
                      ),
                      // Add a child here to center the image properly
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        !widget.isStudent ? "assets/images/course cover.jpg" : "assets/images/student_course_cover.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.sub.name ?? "",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                        ),
                        Text(widget.sub.courseCode ?? ""),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
