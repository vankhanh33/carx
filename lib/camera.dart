import 'dart:io';

import 'package:carx/data/model/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final ImagePicker _picker = ImagePicker();
  File? fileImage;
  List<File>? images;
// Hàm chụp ảnh từ camera
  Future<File?> captureImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<List<File>?> list() async {
    final List<XFile>? image = await _picker.pickMultiImage();
    if (image != null) {
      return image.map((e) => File(e.path)).toList();
    }
    return null;
  }

// Hàm lấy ảnh từ thư viện ảnh
  Future<File?> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

// Chụp ảnh từ camera
  void captureImage() async {
    fileImage = await captureImageFromCamera();
    setState(() {});
  }

// Lấy ảnh từ thư viện ảnh
  void pickImage() async {
    fileImage = await pickImageFromGallery();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(),
          body: Column(children: [
            Container(
              child: fileImage != null
                  ? Image.file(
                      fileImage!,
                      width: 120,
                      height: 120,
                    )
                  : Text("data"),
            ),
            Container(
              width: 120,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  if (fileImage != null) {
                    await uploadImage(fileImage!);
                  }
                },
                child: Text('Camera'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      captureImage();
                    },
                    child: Text('Camera'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      fileImage = await pickImageFromGallery();
                      setState(() {});
                    },
                    child: Text('Camera'),
                  ),
                )
              ],
            ),
            images != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Image.file(
                        images![index],
                        width: 30,
                        height: 30,
                      );
                    },
                    itemCount: images!.length,
                    shrinkWrap: true,
                  )
                : Text("data"),
          ])),
    );
  }

  Future<void> uploadImage(File image) async {
    try {
      User user = User(
          id: 'ybtTS4N6kcWbV6qvE9NBKrJEpzT2',
          address: 'Huế',
          email: 'vk@gmaddddddđil.com',
          gender: 'Male',
          name: 'VK',
          phone: '0364887456');
      Map<String, dynamic> toJson = user.toJsonNotImage();
      toJson['image'] =
          await MultipartFile.fromFile(image.path);
      Dio dio = Dio();
      final response = await dio.post(
        'https://flexicarrent.000webhostapp.com/data/post/update-user.php',
        data: FormData.fromMap(toJson),
      );
      if (response.statusCode == 200) {
        print('success ${response.data}');
      } else {
        print('failure');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> upload(File image) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        'https://flexicarrent.000webhostapp.com/upload.php',
        data: FormData.fromMap(
          {'image': await MultipartFile.fromFile(image.path)},
        ),
      );
      if (response.statusCode == 200) {
        print('success ${response.data}');
      } else {
        print('failure');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

void main() {
  runApp(MyWidget());
}
