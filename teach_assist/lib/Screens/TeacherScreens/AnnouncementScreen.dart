import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';

import '../../API/NotificationApi.dart';
import '../../Utils/ThemeData/colors.dart';


class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserProvider>(builder: (context,appUserProvider,child){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColors.theme['offWhite'],
          appBar: AppBar(
            surfaceTintColor: AppColors.theme['white'],
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.theme['white'],
            title: Text("Announcement",
                style: TextStyle(
                    color: AppColors.theme['white'],
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  size: 32,
                )),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: !_isLoading ? 7.0 : 20),
                child: InkWell(
                  onTap: ()async{
                    setState(() {
                      _isLoading = true;
                    });

                    //todo:
                    await NotificationApi.sendMassNotificationToAllUsers(_textController.text) ;

                    setState(() {

                    });
                    setState(() {
                      _isLoading = false;
                    });

                    _textController.text = "";
                    HelperFunction.showToast("Message sent") ;
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: 40,
                    width: !_isLoading ? 100 : 70,
                    child: !_isLoading
                        ? Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: AppColors.theme['white']
                          ),
                        ))
                        : Center(
                        child: Container(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.6,
                              color: AppColors.theme['green'],
                            ))),
                    decoration: BoxDecoration(
                      color: AppColors.theme['green'],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.theme['white']),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _textController,
                        cursorColor: AppColors.theme['white'],
                        maxLines: null,
                        decoration: InputDecoration(
                            hintText: 'Start writing here...',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );}) ;
  }
}