import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leet/main.dart';
import 'package:leet/views/imageeditor.dart';
import 'package:leet/views/texteditor.dart';
// import 'package:leet/views/trimmerview.dart';
import 'package:leet/views/videoeditor.dart';
import 'package:path/path.dart';
// import 'package:video_trimmer/video_trimmer.dart';
import 'audioeditor.dart';
import 'colors.dart';

bool isVideo = false;
final ImagePicker _picker = ImagePicker();
PickedFile _imageFile;
PickedFile _videoFile;
dynamic _pickImageError;
bool isUploaded = false;
File sampleFile, videoFile, imageFile;
// Trimmer _trimmer = Trimmer();

void newPostModalBottomSheet({BuildContext context}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: APP_WHITE,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: REAL_BLACK,
                  ),
                  title: new Text(
                    'Text',
                    style: TextStyle(color: APP_BLACK),
                  ),
                  onTap: () {
                    // Navigator.of(context).popUntil((route) => route.isFirst);
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TextEditor()),
                    );
                  }),
              new ListTile(
                leading: new Icon(
                  Icons.file_upload,
                  color: APP_GREY,
                ),
                title: new Text(
                  'Upload Video or Photo',
                  style: TextStyle(color: APP_BLACK),
                ),
                onTap: () async {
                  // // Navigator.of(context).pop();
                  await getFile(context: context);
                  if (isUploaded & isVideo) {
                    // await _trimmer.loadVideo(videoFile: videoFile);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return VideoEditor(
                        file: videoFile,
                      );
                    }));
                    // // setState(() {
                    // //   isUploaded = false;
                    // // });
                    // // Navigator.of(context).pop();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return TrimmerView(
                    //     trimmer: _trimmer,
                    //   );
                    // }));
                  } else {
                    if (isUploaded & !isVideo) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ImageEditor(
                          file: sampleFile,
                        );
                      }));
                    }
                  }
                },
              ),
              new ListTile(
                  leading: Icon(
                    Icons.music_note,
                    // size: ,
                    color: APP_GREEN,
                  ),
                  title: new Text(
                    'Audio',
                    style: TextStyle(color: APP_BLACK),
                  ),
                  onTap: () {
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioEditor(
                                profilePic: myProfilePic,
                              )),
                    );
                  }),
              ListTile(
                leading: new Icon(
                  Icons.camera_alt,
                  color: APP_RED,
                ),
                title: new Text(
                  'Take Video or Photo',
                  style: TextStyle(color: APP_BLACK),
                ),
                onTap: () {
                  newCameraModalBottomSheet(context: context);
                },
              ),
            ],
          ),
        );
      });
}

void newCommentModalBottomSheet(
    {BuildContext context, isComment = false, post_id, author_id}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          decoration: BoxDecoration(
              color: APP_WHITE,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: REAL_BLACK,
                  ),
                  title: new Text(
                    'Text',
                    style: TextStyle(color: APP_BLACK),
                  ),
                  onTap: () {
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TextEditor(
                              isComment: true,
                              post_id: post_id,
                              author_id: author_id)),
                    );
                  }),
              new ListTile(
                leading: new Icon(
                  Icons.file_upload,
                  color: APP_GREY,
                ),
                title: new Text(
                  'Upload Video or Photo',
                  style: TextStyle(color: APP_BLACK),
                ),
                onTap: () async {
                  // Navigator.of(context).pop();
                  await getFile(
                      context: context,
                      isComment: true,
                      post_id: post_id,
                      author_id: author_id);

                  if (isUploaded & isVideo) {
                    // await _trimmer.loadVideo(videoFile: videoFile);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return VideoEditor(
                        file: videoFile,
                        isComment: isComment,
                        post_id: post_id,
                        author_id: author_id,
                      );
                    }));
                    // setState(() {
                    // //   isUploaded = false;
                    // // });
                    // // Navigator.of(context).pop();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return TrimmerView(
                    //     trimmer: _trimmer,
                    //     isComment: isComment,
                    //     post_id: post_id,
                    //     author_id: author_id,
                    //   );
                    // }));
                  } else {
                    if (isUploaded & !isVideo) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return ImageEditor(
                          file: sampleFile,
                          isComment: isComment,
                          post_id: post_id,
                          author_id: author_id,
                        );
                      }));
                    }
                  }
                },
              ),
              new ListTile(
                  leading: Icon(
                    Icons.music_note,
                    // size: ,
                    color: APP_GREEN,
                  ),
                  title: new Text(
                    'Audio',
                    style: TextStyle(color: APP_BLACK),
                  ),
                  onTap: () {
                    // Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AudioEditor(
                              isComment: true,
                              post_id: post_id,
                              author_id: author_id,
                              profilePic: myProfilePic)),
                    );
                  }),
              ListTile(
                leading: new Icon(
                  Icons.camera_alt,
                  color: APP_RED,
                ),
                title: new Text(
                  'Take Video or Photo',
                  style: TextStyle(color: APP_BLACK),
                ),
                onTap: () {
                  newCameraModalBottomSheet(
                      context: context,
                      isComment: true,
                      post_id: post_id,
                      author_id: author_id);
                },
              ),
            ],
          ),
        );
      });
}

void newCameraModalBottomSheet(
    {context, bool isComment = false, String post_id, String author_id}) {
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          // padding: EdgeInsets.symmetric(vertical: 32),
          padding: EdgeInsets.only(left: 8, right: 8, top: 32, bottom: 32),
          decoration: BoxDecoration(
              color: APP_WHITE,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () async {
                  isVideo = false;
                  await _onImageButtonPressed(ImageSource.camera,
                      context: context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ImageEditor(
                      file: sampleFile,
                      isComment: isComment,
                      post_id: post_id,
                      author_id: author_id,
                    );
                  }));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      color: LIGHT_BLUE,
                      size: 40,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Photo',
                      style: TextStyle(fontSize: 18, color: APP_GREY),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  isVideo = true;
                  await _onImageButtonPressed(ImageSource.camera);
                  if (isUploaded) {
                    // String ext = extension(sampleFile.path);

                    // await _trimmer.loadVideo(videoFile: videoFile);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return VideoEditor(
                        file: videoFile,
                        isComment: isComment,
                        post_id: post_id,
                        author_id: author_id,
                      );
                    }));
                    // setState(() {
                    //   isUploaded = false;
                    // });
                    // Navigator.of(context).pop();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return TrimmerView(
                    //     trimmer: _trimmer,
                    //     isComment: isComment,
                    //     post_id: post_id,
                    //     author_id: author_id,
                    //   );
                    // }));
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.videocam,
                      color: APP_GREEN,
                      size: 40,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Video',
                      style: TextStyle(fontSize: 18, color: APP_GREY),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
}

Future<void> getFile(
    {context, bool isComment = false, String post_id, String author_id}) async {
  File tempFile = await FilePicker.getFile(
    type: FileType.custom,
    allowedExtensions: ['mp4', 'png', 'jpg', 'jpeg', 'gif'],
  );
  // setState(() {
  sampleFile = tempFile;
  isUploaded = true;
  // });

  if (sampleFile != null) {
    String ext = extension(sampleFile.path);
    if (ext.contains('mp4')) {
      videoFile = sampleFile;
      isVideo = true;
      // await _trimmer.loadVideo(videoFile: sampleFile);
      // // setState(() {
      // //   isUploaded = false;
      // // });
      // // Navigator.of(context).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return TrimmerView(
      //       trimmer: _trimmer,
      //       isComment: isComment,
      //       post_id: post_id,
      //       author_id: author_id);
      // }));
    } else {
      // //image
      // // setState(() {
      // //   isUploaded = false;
      // // });
      // // Navigator.of(context).pop();
      imageFile = sampleFile;
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return ImageEditor(
      //     file: sampleFile,
      //     isComment: isComment,
      //     post_id: post_id,
      //     author_id: author_id,
      //   );
      // }));
    }
  }
} //getFile

Future<void> _onImageButtonPressed(ImageSource source,
    {BuildContext context,
    bool isComment = false,
    String post_id,
    String author_id}) async {
  // if (_controller != null) {
  //   await _controller.setVolume(0.0);
  // }
  if (isVideo) {
    final PickedFile file = await _picker.getVideo(
        source: source, maxDuration: const Duration(seconds: 182));
    // await _playVideo(file);
    // setState(() {
    _videoFile = file;
    sampleFile = File(file.path);
    videoFile = sampleFile;
    isUploaded = true;
    // });

    if (_videoFile != null) {
      // String ext = extension(sampleFile.path);

      // await _trimmer.loadVideo(videoFile: sampleFile);
      // // setState(() {
      // //   isUploaded = false;
      // // });
      // // Navigator.of(context).pop();
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      //   return TrimmerView(
      //     trimmer: _trimmer,
      //     isComment: isComment,
      //     post_id: post_id,
      //     author_id: author_id,
      //   );
      // }));
    }
  } else {
    try {
      final pickedFile = await _picker.getImage(source: source);
      // setState(() {
      _imageFile = pickedFile;
      sampleFile = File(pickedFile.path);
      imageFile = sampleFile;
      isUploaded = true;
      // });
      // Navigator.of(context).pop();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ImageEditor(
          file: sampleFile,
          isComment: isComment,
          post_id: post_id,
          author_id: author_id,
        );
      }));
    } catch (e) {
      // setState(() {
      _pickImageError = e;
      // });
    }
  }
}
