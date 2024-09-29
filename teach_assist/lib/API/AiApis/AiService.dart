// import 'dart:io' as df;
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// // import 'package:path_provider/path_provider.dart' as pp;
//
// class AiService{
//
//   static Future<void> processVideo(df.File videoFile) async {
//     String ngrokUrl = "http://192.168.113.93:8000/process_video/";
//     // String videoFilePath = "/storage/emulated/0/Download/test_video3.mp4";  // Update with actual path
//
//     // Read the video file
//     //  = File(videoFilePath);
//
//     if (!await videoFile.exists()) {
//       print("Video file not found at path: ${videoFile.path}");
//       return;
//     }
//
//     // Prepare the multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(ngrokUrl));
//     request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));
//
//     // Send the request
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       // Prompt the user to choose the path for saving the PDF
//       // Save the PDF content
//       List<int> pdfBytes = await response.stream.toBytes();
//       String? outputPdfPath = await getSavePath("output_file_lh3f.pdf", pdfBytes);
//       if (outputPdfPath == null) {
//         print("User cancelled the file save action.");
//         return;
//       }
//
//       df.File pdfFile = df.File(outputPdfPath);
//       await pdfFile.writeAsBytes(pdfBytes);
//
//       print("PDF saved successfully to $outputPdfPath");
//     } else {
//       print("Failed to process video. Status Code: ${response.statusCode}");
//       String responseBody = await response.stream.bytesToString();
//       print("Response Content: $responseBody");
//     }
//   }
//
//   static Future<String?> getSavePath(String defaultFileName, List<int> bytes) async {
//     // Prompt the user to pick a location to save the file
//     String? result = await FilePicker.platform.saveFile(
//       dialogTitle: "Save PDF file",
//       fileName: defaultFileName,
//       type: FileType.custom,
//       bytes: Uint8List.fromList(bytes),
//       allowedExtensions: ['pdf'],  // Filter for saving as PDF
//     );
//
//     return result;
//   }
//
// }


import 'dart:io' as df;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';  // Firebase Storage import

class AiService {

  static Future<String?> processVideo(df.File videoFile, String filename) async {
    String ngrokUrl = "http://192.168.113.93:8000/process_video/";

    if (!await videoFile.exists()) {
      print("Video file not found at path: ${videoFile.path}");
      return null;
    }

    // Prepare the multipart request
    var request = http.MultipartRequest('POST', Uri.parse(ngrokUrl));
    request.files.add(await http.MultipartFile.fromPath('file', videoFile.path));

    // Send the request
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Get the bytes of the response (PDF content)
      List<int> pdfBytes = await response.stream.toBytes();

      // Upload to Firebase Storage directly
      String firebaseUrl = await uploadPdfToFirebase(pdfBytes, "$filename.pdf");
      print("PDF uploaded to Firebase Storage: $firebaseUrl");
      return firebaseUrl;
    } else {
      print("Failed to process video. Status Code: ${response.statusCode}");
      String responseBody = await response.stream.bytesToString();
      print("Response Content: $responseBody");
    }
  }

  // Function to upload the PDF to Firebase Storage
  static Future<String> uploadPdfToFirebase(List<int> pdfBytes, String fileName) async {
    try {
      // Reference to Firebase Storage location
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("pdfs/$fileName");

      // Upload the file as a byte array
      UploadTask uploadTask = ref.putData(Uint8List.fromList(pdfBytes));

      // Wait until the upload completes
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      // Get the downloadable URL of the uploaded PDF
      String downloadUrl = await snapshot.ref.getDownloadURL();


      return downloadUrl;
    } catch (e) {
      print("Failed to upload PDF to Firebase: $e");
      return "";
    }
  }
}
