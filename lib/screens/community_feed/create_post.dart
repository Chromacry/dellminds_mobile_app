import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostScreen extends StatefulWidget {
  static const String routeName = '/create-post';

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final form = GlobalKey<FormState>();
  File? itemPhoto;
  String? title;
  String? caption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'New Post',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: itemPhoto != null
                        ? Image.file(
                            itemPhoto!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.camera_alt,
                            size: 60,
                            color: Colors.grey,
                          ),
                  ),
                  SizedBox(height: 8),
                  TextButton.icon(
                    icon: Icon(Icons.camera_alt),
                    onPressed: pickImage,
                    label: Text('Select Image'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) {
                  title = value;
                },
              ),
              SizedBox(height: 16),
              // Add CategoryDropdown widget here
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Caption'),
                maxLines: 4,
                onSaved: (value) {
                  caption = value;
                },
              ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  addItem(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          itemPhoto = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void addItem(BuildContext context) {
    final isValid = form.currentState!.validate();
    if (!isValid) {
      return;
    }

    form.currentState!.save();

    // Add logic to create a new post with the gathered data and update the post list using a provider (similar to the previous example).

    // // For example:
    // final newPost = Post(
    //   title: title!,
    //   content: description!,
    //   remarks: '', // Add remarks if needed
    //   created_by: '', // Add user information if needed
    //   image: itemPhoto != null ? itemPhoto!.path : '',
    // );

    // // Use a provider to add the new post to the list
    // final communityFeedProvider = Provider.of<CommunityFeedProvider>(context, listen: false);
    // communityFeedProvider.addPost(newPost);

    // Navigate back to the previous screen or perform other actions as needed.
    Navigator.of(context).pop();
  }
}
