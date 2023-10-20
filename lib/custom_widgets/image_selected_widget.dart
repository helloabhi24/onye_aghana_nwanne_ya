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
import 'package:path_provider/path_provider.dart';

class WithOutImageWidget extends StatelessWidget {
  final VoidCallback? onChangedGallery;
  final VoidCallback? onChangedCamera;
  final bool? isAnyImage;
  const WithOutImageWidget(
      {super.key,
      required this.onChangedCamera,
      required this.onChangedGallery,
      required this.isAnyImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: !isAnyImage!
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.spaceAround,
      children: [
        !isAnyImage!
            ? Card(
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
              )
            : const SizedBox.shrink(),
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

class NoParameterImageWidget extends StatefulWidget {
  final String? questionName;
  final String? Function(String?)? validator;
  final String? base64String;
  final bool? isEdit;
  final int? index;
  final List? editableList; // Add validator function
  NoParameterImageWidget(
      {Key? key,
      required this.questionName,
      required this.index,
      this.validator,
      this.isEdit,
      this.base64String,
      this.editableList})
      : super(key: key);

  @override
  _NoParameterImageWidgetState createState() => _NoParameterImageWidgetState();
}

class _NoParameterImageWidgetState extends State<NoParameterImageWidget> {
  late var fileName;
  // convert() async {
  //   return await getFilePath();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.isEdit!) {
  //     String file = convert();
  //     fileName = base64ToImage(widget.base64String!, file);
  //   }
  // }

  late String selectedImagePath = widget.isEdit!
      ? widget.base64String ?? (widget.base64String!.split("|"))[1]
      : "";
  // String selectedImagePath = "";

  String base64string = "";
  var byte;

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
      byte = imagebytes;
      base64string = "data:image/jpeg;base64,${base64.encode(imagebytes)}";
      setState(() {
        formController.ohterWholeList[widget.index!]["value"] =
            "$base64string|$selectedImagePath";

        widget.isEdit!
            ? formController.updateValue(widget.editableList!,
                widget.questionName!, [base64string, selectedImagePath])
            : formController.addData(
                widget.questionName!, [base64string, selectedImagePath]);
        formController.removeEntriesWithQuestion(
            formController.editedData, widget.questionName!);
        formController.editedData.add({
          "question": widget.questionName!,
          "value": [base64string, selectedImagePath],
          "type": "image"
        });
        if (widget.isEdit!) {
          formController.removeEntriesWithQuestion(
              formController.editedSubmitData, widget.questionName!);
          formController.editedSubmitData.add({
            "question": widget.questionName!,
            "value": [base64string, selectedImagePath],
            "type": "image"
          });
        }

        // formController.addData(widget.questionName!, base64string);
      });
    }
  }

  Future<File> base64ToImage(String base64String, String filePath) async {
    String base64Strings = base64String;

// Remove the prefix
    String base64Data = base64Strings.substring(base64Strings.indexOf(',') + 1);
    final buffer = Uint8List.fromList(base64.decode(base64Data));
    final file = File(filePath);
    await file.writeAsBytes(buffer);
    return file;
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path + '/path_to_save_image.jpg';
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
        ? Column(
            children: [
              Row(
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
                      onPressed: () async {
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
              ),
              if (widget.validator != null && widget.validator!("") != null)
                Text(
                  widget.validator!("")!, // Display error message if provided
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
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
