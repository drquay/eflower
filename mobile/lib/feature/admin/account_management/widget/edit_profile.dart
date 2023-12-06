import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/admin/account_management/provider/account_mangament_provider.dart';
import 'package:flutter_boilerplate/feature/comment/widget/bottom_sheet_wrapper.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/model/user_response.dart';
import 'package:flutter_boilerplate/shared/provider/account_provider.dart';
import 'package:flutter_boilerplate/shared/util/image_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class EditProfileUI extends ConsumerWidget {
  EditProfileUI({Key? key, required this.userName}) : super(key: key);
  final String userName;
  final _phoneController = TextEditingController();
  List<Role> options = roleDescriptions.keys.toList();
  List<Role> selectedValues = [];
  final ImagePicker _picker = ImagePicker();
  final _uploadSingleImageProvider = StateProvider<XFile?>((ref) {
    return null;
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _userFuture = ref
        .read(accountProvider.notifier)
        .getAccountWithoutState(userName: userName);
    final _updateImage = ref.watch(_uploadSingleImageProvider);

    return Scaffold(
        appBar: AppBar(
            title: Text('Chỉnh sửa thông tin tài khoản'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                ref.read(accountManagementProvider.notifier).getListAccount();
                Get.back();
              },
            )),
        body: Container(
            padding: EdgeInsets.only(left: 15, top: 20, right: 15),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: FutureBuilder<UserResponse?>(
                    future: _userFuture,
                    builder: (context, snapshot) {
                      User? _user = null;
                      if (snapshot.data != null &&
                          snapshot.data!.items.isNotEmpty) {
                        _user = snapshot.data!.items.first;
                        if (_user.roles != null && _user.roles!.isNotEmpty) {
                          selectedValues = _user.roles!
                              .map((str) => Role.values.firstWhere((role) =>
                                  role.toString().split('.').last == str))
                              .toList();
                          _phoneController.text = _user.phoneNumber!;
                        }
                      }
                      return ListView(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _updateImage != null
                                          ? FileImage(
                                              File(_updateImage.path),
                                            )
                                          : (_user != null &&
                                                  _user.avatar != null
                                              ? NetworkImage(_user.avatar!)
                                              : ImageUtil.defaultImage()
                                                  as ImageProvider<Object>),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 4, color: Colors.white),
                                          color: Colors.blue),
                                      child: IconButton(
                                        icon: Icon(Icons.edit,
                                            color: Colors.white),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          _openBottomSheetUploadImage(
                                              context, ref);
                                        },
                                        tooltip: 'Chỉnh sửa ảnh',
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.vpn_key,
                                    color: Colors.blueAccent,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.block,
                                      color: Colors.blueAccent)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.gpp_good,
                                      color: Colors.blueAccent)),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _user != null ? buildForm(ref, _user) : Container(),
                        ],
                      );
                    }))));
  }

  Future<void> _onImageButtonPressed(ImageSource source, WidgetRef ref) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      _setImageFileListFromFile(pickedFile, ref);
    } catch (e) {}
  }

  void _setImageFileListFromFile(XFile? value, WidgetRef ref) {
    ref.watch(_uploadSingleImageProvider.notifier).state = value;
  }

  Widget _buildListBottomItem(BuildContext context,
      {required Widget title,
      required Widget leading,
      required VoidCallback onPress}) {
    final theme = Theme.of(context);

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.dividerColor,
              width: 0.5,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => onPress(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              leading,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: DefaultTextStyle(
                  style: theme.textTheme.headline6!,
                  child: title,
                ),
              ),
            ],
          ),
        ));
  }

  void _openBottomSheetUploadImage(BuildContext ctx, WidgetRef ref) {
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 10,
        context: ctx,
        builder: (context) => BottomSheetWrapper(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildListBottomItem(context,
                    title: const Text('Tải ảnh từ máy ảnh'),
                    leading:
                        const Icon(Icons.camera_alt, color: Colors.blueAccent),
                    onPress: () {
                  _onImageButtonPressed(ImageSource.camera, ref);
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: _buildListBottomItem(context,
                    title: const Text('Tải ảnh từ máy từ thư viện'),
                    leading: const Icon(Icons.image, color: Colors.red),
                    onPress: () {
                  _onImageButtonPressed(ImageSource.gallery, ref);
                }),
              )
            ])));
  }

  Widget buildForm(WidgetRef ref, User user) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tên đăng nhập',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: EdgeInsets.only(bottom: 5),
                enabled: false,
                hintStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              initialValue: user.username,
              enabled: false,
              readOnly: true,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Số điện thoại',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              controller: _phoneController,
            ),
            SizedBox(height: 30),
            MultiSelectDialogField(
              buttonText: Text('Chọn vai trò'),
              title: Text('Danh sách vai trò'),
              items: options
                  .map((option) => MultiSelectItem<Role>(
                      option, roleDescriptions[option].toString()))
                  .toList(),
              initialValue: selectedValues,
              onConfirm: (List<Role> values) {
                selectedValues = values;
              },
            ),
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Huỷ",
                    style: TextStyle(
                        fontSize: 15, letterSpacing: 2, color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final _updateImage = ref.watch(_uploadSingleImageProvider);
                    if (_updateImage != null) {
                      final url = await ref
                          .read(accountManagementProvider.notifier)
                          .updateAvatar(File(_updateImage.path));
                      final updatedAccount = user.copyWith(
                          phoneNumber: _phoneController.text,
                          roles: selectedValues.map((e) => e.name).toList(),
                          avatar: url);
                      await ref
                          .read(accountManagementProvider.notifier)
                          .updateAccount(updatedAccount);
                    } else {
                      final updatedAccount = user.copyWith(
                          phoneNumber: _phoneController.text,
                          roles: selectedValues.map((e) => e.name).toList());
                      await ref
                          .read(accountManagementProvider.notifier)
                          .updateAccount(updatedAccount);
                    }
                  },
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                        fontSize: 15, letterSpacing: 2, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
