import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onye_aghana_nwanne_ya/contoller/form_controller.dart';
import 'package:onye_aghana_nwanne_ya/custom_widgets/custom_text_widget.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

import '../utils/size_helper.dart';

class WithOutImageWidget extends StatelessWidget {
  final VoidCallback? onChangedGallery;
  final VoidCallback? onChangedCamera;
  const WithOutImageWidget(
      {super.key,
      required this.onChangedCamera,
      required this.onChangedGallery});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomText(
                  text: "No image selected",
                  color: redColor,
                ),
                CustomText(
                  text: "(Optional)",
                  color: redColor,
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 3,
          child: IconButton(
              onPressed: onChangedGallery,
              icon: const Icon(
                Icons.photo,
                size: 30,
              )),
        ),
        Card(
          elevation: 3,
          child: IconButton(
              onPressed: onChangedCamera,
              icon: const Icon(
                Icons.camera_alt,
                size: 30,
              )),
        )
      ],
    );
  }
}

class WithImageWidget extends StatelessWidget {
  final VoidCallback? onChangedGallery;
  final VoidCallback? onChangedCamera;
  final String? fileValue;
  final VoidCallback? onChangedCancel;
  const WithImageWidget(
      {super.key,
      required this.fileValue,
      required this.onChangedCamera,
      required this.onChangedCancel,
      required this.onChangedGallery});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Image.file(File(fileValue!)),
        ),
        getheight(context, 0.010),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              elevation: 3,
              child: IconButton(
                  onPressed: onChangedCancel,
                  icon: Icon(
                    Icons.cancel,
                    size: 30,
                    color: redColor,
                  )),
            ),
            // Card(
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: SizedBox(
            //       width: Get.height * .25,
            //       child: CustomText(
            //         text:
            //             "File Selected \n${driverInfoController.selectedImagePath.value.split('/').last.split('_').last}",
            //         fontSize: 15,
            //         fontWeight: FontWeight.w500,
            //         color: greenColor,
            //         textOverflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //   ),
            // ),
            Card(
              elevation: 3,
              child: IconButton(
                  onPressed: onChangedGallery,
                  icon: const Icon(
                    Icons.photo,
                    size: 30,
                  )),
            ),
            Card(
              elevation: 3,
              child: IconButton(
                  onPressed: onChangedCamera,
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  )),
            )
          ],
        )
      ],
    );
  }
}

// class NoParameterImageWidget extends StatelessWidget {
//   NoParameterImageWidget({
//     super.key,
//   });

//   String selectedImagePath = "";
//   String base64string = "";
//   Future getImageforSignUp(ImageSource imageSource) async {
//     var pickeImage = await ImagePicker().pickImage(source: imageSource);
//     if (pickeImage != null) {
//       File? img = await getCroppedImage(pickeImage);

//       // pathName.value = pickeImage.name;

//       // selectedImagePath.value = await img!.path;
//       selectedImagePath = img!.path;

//       // File imagefile = File(selectedImagePath.value); //convert Path to File
//       File imagefile = File(img.path); //convert Path to File

//       Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
//       base64string = "data:image/jpeg;base64,${base64.encode(imagebytes)}";

//       // imageListforSignUp.add("base64,${base64stringforSignUp.value}");
//     } else {
//       // customToast("No Image Selected");
//     }
//   }

//   getCroppedImage(XFile image) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//         maxHeight: 150,
//         maxWidth: 150,
//         sourcePath: image.path,
//         aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 2));
//     if (croppedFile == null) return null;
//     return File(croppedFile.path);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return selectedImagePath.isEmpty
//         ? Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       CustomText(
//                         text: "No image selected",
//                         color: redColor,
//                       ),
//                       CustomText(
//                         text: "(Optional)",
//                         color: redColor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Card(
//                 elevation: 3,
//                 child: IconButton(
//                     onPressed: () {
//                       getImageforSignUp(ImageSource.gallery);
//                     },
//                     icon: const Icon(
//                       Icons.photo,
//                       size: 30,
//                     )),
//               ),
//               Card(
//                 elevation: 3,
//                 child: IconButton(
//                     onPressed: () {
//                       getImageforSignUp(ImageSource.camera);
//                     },
//                     icon: const Icon(
//                       Icons.camera_alt,
//                       size: 30,
//                     )),
//               )
//             ],
//           )
//         : Column(
//             children: [
//               Card(
//                 elevation: 5,
//                 child: Image.file(File(selectedImagePath)),
//               ),
//               getheight(context, 0.010),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Card(
//                     elevation: 3,
//                     child: IconButton(
//                         onPressed: () {
//                           selectedImagePath = "";
//                         },
//                         icon: Icon(
//                           Icons.cancel,
//                           size: 30,
//                           color: redColor,
//                         )),
//                   ),
//                   // Card(
//                   //   child: Padding(
//                   //     padding: const EdgeInsets.all(8.0),
//                   //     child: SizedBox(
//                   //       width: Get.height * .25,
//                   //       child: CustomText(
//                   //         text:
//                   //             "File Selected \n${driverInfoController.selectedImagePath.value.split('/').last.split('_').last}",
//                   //         fontSize: 15,
//                   //         fontWeight: FontWeight.w500,
//                   //         color: greenColor,
//                   //         textOverflow: TextOverflow.ellipsis,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                   Card(
//                     elevation: 3,
//                     child: IconButton(
//                         onPressed: () {
//                           getImageforSignUp(ImageSource.gallery);
//                         },
//                         icon: const Icon(
//                           Icons.photo,
//                           size: 30,
//                         )),
//                   ),
//                   Card(
//                     elevation: 3,
//                     child: IconButton(
//                         onPressed: () {
//                           getImageforSignUp(ImageSource.camera);
//                         },
//                         icon: const Icon(
//                           Icons.camera_alt,
//                           size: 30,
//                         )),
//                   )
//                 ],
//               )
//             ],
//           );
//   }
// }

class NoParameterImageWidget extends StatefulWidget {
  final String? questionName;
  NoParameterImageWidget({Key? key, required this.questionName})
      : super(key: key);

  @override
  _NoParameterImageWidgetState createState() => _NoParameterImageWidgetState();
}

class _NoParameterImageWidgetState extends State<NoParameterImageWidget> {
  String selectedImagePath = "";
  String base64string = "";

  FormController formController = Get.find();

  Future getImageforSignUp(ImageSource imageSource) async {
    var pickeImage = await ImagePicker().pickImage(source: imageSource);
    if (pickeImage != null) {
      File? img = await getCroppedImage(pickeImage);

      setState(() {
        selectedImagePath = img!.path;
      });

      File imagefile = File(img!.path);
      Uint8List imagebytes = await imagefile.readAsBytes();
      base64string = "data:image/jpeg;base64,${base64.encode(imagebytes)}";
      setState(() {
        formController.addData(widget.questionName!, base64string);
      });
    } else {
      // Handle the case when no image is selected
    }
  }

  Future<File?> getCroppedImage(XFile image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        maxHeight: 150,
        maxWidth: 150,
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 2, ratioY: 2));
    if (croppedFile == null) return null;
    return File(croppedFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return selectedImagePath.isEmpty
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CustomText(
                        text: "No image selected",
                        color: redColor,
                      ),
                      CustomText(
                        text: "(Optional)",
                        color: redColor,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: IconButton(
                  onPressed: () {
                    getImageforSignUp(ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo,
                    size: 30,
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: IconButton(
                  onPressed: () {
                    getImageforSignUp(ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ),
              )
            ],
          )
        : Column(
            children: [
              Card(
                elevation: 5,
                child: Image.file(File(selectedImagePath)),
              ),
              getheight(context, 0.010),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    elevation: 3,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedImagePath = "";
                        });
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: redColor,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: IconButton(
                      onPressed: () {
                        getImageforSignUp(ImageSource.gallery);
                      },
                      icon: const Icon(
                        Icons.photo,
                        size: 30,
                      ),
                    ),
                  ),
                  Card(
                    elevation: 3,
                    child: IconButton(
                      onPressed: () {
                        getImageforSignUp(ImageSource.camera);
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
  }
}
