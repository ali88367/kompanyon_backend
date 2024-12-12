import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kompanyon_app/const/color.dart';
import 'package:kompanyon_app/const/image.dart';
import 'package:kompanyon_app/widgets/custom_button.dart';
import 'package:kompanyon_app/widgets/custom_inter_text.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:kompanyon_app/widgets/custom_textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/user_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? selectedRole;
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  final UserController userController = Get.find<UserController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = userController.userName.value;
    _descriptionController.text = userController.userDescription.value;
    selectedRole = userController.userRole.value;
    userController.userDescription.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: primaryColor,
              size: 35,
            )),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: InterCustomText(
                    text: "Edit Profile",
                    textColor: primaryColor,
                    fontsize: 26.sp,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Obx(() {
                  return Container(
                    key: ValueKey<String>(_pickedImage?.path ?? 'default'),
                    width: 100.w,
                    height: 120.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor, width: 4),
                      borderRadius: BorderRadius.circular(12.r),
                      image: DecorationImage(
                        image: _pickedImage != null
                            ? FileImage(File(_pickedImage!.path))
                            : userController.profileImageUrl.value.isNotEmpty
                            ? NetworkImage(userController.profileImageUrl.value)
                            : AssetImage(AppImages.profilePic)
                        as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: 15.h,
                ),
                CustomButton(
                  text: "Change Photo",
                  onPressed: () {
                    _selectImage();
                  },
                  height: 70.h,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  textColor: secondaryText,
                  color: Colors.white,
                  width: 150.w,
                  border: Border.all(color: containerBorder),
                ),
                SizedBox(
                  height: 15.h,
                ),
                InputField(
                  controller: _nameController,
                  hint: "Display Name",
                  keyboard: TextInputType.name,
                  label: "Full Name",
                ),
                SizedBox(
                  height: 10.h,
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 10.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: containerBorder,
                        ),
                        borderRadius: BorderRadius.circular(12.r)),
                    // border: OutlineInputBorder(borderSide: BorderSide(color: containerBorder)),
                    // border: OutlineInputBorder(borderSide: BorderSide(color: containerBorder)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12.r)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  hint: InterCustomText(
                    text: '[role]',
                    textColor: primaryColor,
                  ),
                  // Placeholder text
                  value: selectedRole,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue;
                    });
                  },
                  items: <String>['Admin', 'User', 'Guest']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: InterCustomText(
                        text: value,
                        textColor: primaryColor,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ValueListenableBuilder(
                  valueListenable: ValueNotifier(userController.userDescription.value),
                  builder: (BuildContext context, String value, Widget? child) {
                    return InputField(
                      controller: _descriptionController,
                      hint: "Short Description",
                      keyboard: TextInputType.name,
                      label: "Short Description",
                      maxlines: 3,

                    );
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                CustomButton(
                  text: "Save Changes",
                  onPressed: () async {
                    if (isLoading) return;  // Prevent multiple taps

                    setState(() {
                      isLoading = true;
                    });

                    String name = _nameController.text;
                    String role = selectedRole ?? userController.userRole.value;
                    String description = _descriptionController.text;

                    // Call the update method
                    await userController.updateUserData(
                      name: name,
                      role: role,
                      description: description,
                      imageFile: _pickedImage != null ? File(_pickedImage!.path) : null,
                    );

                    // Update the userController's description value
                    userController.userDescription.value = description;

                    // Optionally, show a success message or navigate back
                    Get.snackbar('Success', 'Profile updated successfully');
                    Navigator.pop(context);

                    setState(() {
                      isLoading = false;
                    });
                  },
                  height: 70.h,
                  fontSize: 20.sp,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }
}