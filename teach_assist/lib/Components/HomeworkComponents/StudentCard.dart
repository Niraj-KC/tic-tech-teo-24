import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class StudentCard extends StatefulWidget {
  const StudentCard({super.key});

  @override
  State<StudentCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  // Example student data
  List<Map<String, dynamic>> students = [
    {
      'name': 'Hitesh Mori',
      'marks': '8/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Doe',
      'marks': '7/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jane Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
    {
      'name': 'Niraj kc',
      'marks': '8.5/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Mori',
      'marks': '3/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jishan Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
    {
      'name': 'Hitesh Mori',
      'marks': '8/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Doe',
      'marks': '7/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jane Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
    {
      'name': 'Niraj kc',
      'marks': '8.5/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Mori',
      'marks': '3/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jishan Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
    {
      'name': 'Hitesh Mori',
      'marks': '8/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Doe',
      'marks': '7/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jane Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
    {
      'name': 'Niraj kc',
      'marks': '8.5/10',
      'url': 'DRIVE_URL_1'
    },
    {
      'name': 'John Mori',
      'marks': '3/10',
      'url': 'DRIVE_URL_2'
    },
    {
      'name': 'Jishan Smith',
      'marks': '9/10',
      'url': 'DRIVE_URL_3'
    },
  ];

  @override
  void initState() {
    super.initState();
    _sortStudentsByMarks();
  }

  void _sortStudentsByMarks() {
    students.sort((a, b) {
      double marksA = double.parse(a['marks'].split('/')[0]);
      double marksB = double.parse(b['marks'].split('/')[0]);
      return marksB.compareTo(marksA);
    });


    for (int i = 0; i < students.length; i++) {
      students[i]['rank'] = i + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            border: TableBorder.all(color: Colors.black54, width: 1),
            columnWidths: {
              0: FixedColumnWidth(50),
              1: FlexColumnWidth(2),
              2: FixedColumnWidth(80),
              3: FixedColumnWidth(40),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Table Header
              TableRow(
                decoration: BoxDecoration(
                  color:AppColors.theme['offWhite']
                ),
                children: [
                  _buildHeaderCell("Rank"),
                  _buildHeaderCell("Name"),
                  _buildHeaderCell("Marks"),
                  _buildHeaderCell("Link"),
                ],
              ),
              // Populate student data
              for (var student in students)
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  children: [
                    _buildDataCell(student['rank'].toString()),
                    _buildDataCell(student['name']),
                    _buildDataCell(student['marks']),
                    _buildLinkCell(student['url']),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }


  Widget _buildDataCell(String data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildLinkCell(String url) {
    return IconButton(
      icon: Icon(Icons.link, color: Colors.blue),
      onPressed: () {
        HelperFunction.launchURL(url);
      },
    );
  }
}
