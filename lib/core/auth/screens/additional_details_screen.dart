import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unikomb/core/auth/functions/auth/auth.dart';
import 'package:unikomb/core/auth/providers/registration_provider.dart';
import 'package:unikomb/core/auth/screens/login_screen.dart';
import 'package:unikomb/core/auth/screens/social_screen.dart';
import 'package:unikomb/core/storage/functions/media/media_database_api.dart';
import 'package:unikomb/utils/asset_path.dart';
import 'package:unikomb/utils/common_method_widgets.dart';
import 'package:unikomb/utils/constants.dart';
import 'package:unikomb/utils/validity_methods.dart';
import 'package:unikomb/widgets/designed_container.dart';
import 'package:unikomb/widgets/input_field.dart';
import 'package:unikomb/widgets/screen_page_setup.dart';

import '../../../utils/utility.dart';
import '../../../widgets/edit_img_button.dart';
import '../../../widgets/profile_pic.dart';
import '../../storage/storage_constants.dart';
import '../widgets/date_button.dart';

class AdditionalDetailsScreen extends StatefulWidget {
  static const id = "Additional Details Screen Id";
  const AdditionalDetailsScreen({super.key});

  @override
  State<AdditionalDetailsScreen> createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  Uint8List? imgBytes;
  String imgExt = "";

  TextEditingController _nameController = TextEditingController();
  TextEditingController _uidController = TextEditingController();
  TextEditingController _courseController = TextEditingController();
  DateTime dob = DateTime(2002, 01, 14);
  List<DropdownMenuItem<int>> _yrsOpts = [];
  int joinYr = 2000;
  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    int len = DateTime.now().year - kMinJoinYear + 1;
    _yrsOpts = List.generate(
      len,
      (index) => DropdownMenuItem(
        value: index + kMinJoinYear,
        child: Center(
          child: Text(
            (index + kMinJoinYear).toString(),
            style: kSemiBoldTextStyle,
            // textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Additional Details"),
      // ),
      body: Form(
        key: _key,
        child: ScreenPageSetup(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            const AuthAppTitle(),
            const SizedBox(height: 20),
            Stack(
              children: [
                GestureDetector(
                  onTap: (imgBytes == null) ? getImage : null,
                  child: ProfilePic(
                    image: (imgBytes == null
                        ? const AssetImage(apProfilePic)
                        : MemoryImage(imgBytes!)) as ImageProvider<Object>,
                    // image: ,
                  ),
                ),
                if (imgBytes != null)
                  EditImgButton(
                    onPressed: getImage,
                  ),
              ],
            ),
            const SizedBox(height: 20),
            InputField(
              validator: validateName,
              controller: _nameController,
              labelText: "Name *",
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 15),
            InputField(
              validator: (val) {
                if (val == null || val == "") {
                  return "Required parameter";
                }
                if (val.length < 3) {
                  return "at least 4 characters required";
                }
              },
              controller: _uidController,
              labelText: "Uid *",
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 15),
            InputField(
              validator: (val) {
                if (val == null || val == "") {
                  return "Required parameter";
                }
                if (val.length < 3) {
                  return "at least 4 characters required";
                }
              },
              controller: _courseController,
              labelText: "Course *",
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 15),
            DateButton(
              title: "DOB",
              widthRatio: 0.75,
              initialTime: dob,
              onChanged: (value) {
                setState(() {
                  dob = value;
                });
              },
            ),
            const SizedBox(height: 15),
            if (_yrsOpts.isNotEmpty)
              Row(
                children: [
                  Text(
                    "Join Year:",
                    style: kSemiBoldTextStyle,
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: DesignedContainer(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      // color: kBlueColor,
                      child: DropdownButton<int>(
                        isExpanded: true,
                        alignment: Alignment.center,
                        items: _yrsOpts,
                        value: joinYr,
                        underline: const SizedBox(),
                        onChanged: (val) {
                          setState(() {
                            joinYr = val ?? kMinJoinYear;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: const Text(
                  "Next",
                  style: kSemiBoldTextStyle,
                ),
                onPressed: () {
                  // go to next screen
                  if (!validateInput()) return;
                  if (imgBytes == null) {
                    showMyToast("Null Image", isError: true);
                    return;
                  }
                  showMyToast("Uploading Image...");
                  String path =
                      "$skProfileStorageDatabaseName/${Auth.getCurrentUserUid()}.jpg";
                  MediaDatabaseApi.uploadImage(
                      data: imgBytes!,
                      path: path,
                      onSuccess: (url) {
                        if (url == null) {
                          showMyToast("error on uploading image",
                              isError: true);
                          return;
                        }
                        showMyToast("Image successfully uploaded");
                        context.read<RegistrationProvider>().setCompulsoryParam(
                            _nameController.text,
                            _uidController.text,
                            url,
                            _courseController.text,
                            joinYr,
                            dob.millisecondsSinceEpoch);
                        Navigator.pushNamed(context, SocialScreen.id);
                      });
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  bool validateInput() {
    if (!(_key.currentState?.validate() ?? false)) {
      return false;
    }
    // if(dob.compareTo(DateTime.now()) )
    // if(dob.difference(DateTime.now()))
    return true;
  }

  void getImage() async {
    final t = await fetchImage();
    if (t == null) return;
    imgBytes = await compressImage(t.bytes!, quality: 20);
    setState(() {
      // imgBytes = t.bytes;
      imgExt = t.extension ?? "png";
    });
  }
}
