import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ubereats/controller/provider/profileProvider/profileProvider.dart';
import 'package:ubereats/utils/colors.dart';
import 'package:ubereats/utils/textStyles.dart';
import 'package:ubereats/widgets/commonTextField.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: Text(
            'Register',
            style: AppTextStyles.body16Bold,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 3.w,
            vertical: 2.h,
          ),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Consumer<ProfileProvider>(
                builder: (context, profileProvider, child) {
              return InkWell(
                onTap: () async {
                  await context
                      .read<ProfileProvider>()
                      .pickFoodImageFromGallery(context);
                },
                child: CircleAvatar(
                    radius: 5.h,
                    backgroundColor: black,
                    child: CircleAvatar(
                        backgroundColor: white,
                        radius: 5.h - 2,
                        backgroundImage: profileProvider.profileImage != null
                            ? FileImage(profileProvider.profileImage!)
                            : null,
                        child: profileProvider.profileImage == null
                            ? FaIcon(
                                FontAwesomeIcons.user,
                                size: 4.h,
                                color: black,
                              )
                            : null)),
              );
            }),
            SizedBox(
              height: 4.h,
            ),
            CommonTextfield(
              controller: nameController,
              title: 'Name',
              hintText: 'User Name',
              keyboardType: TextInputType.name,
            ),
          ],
        ),
      ),
    );
  }
}
