import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/comment/widget/bottom_sheet_wrapper.dart';
import 'package:flutter_boilerplate/feature/comment/widget/comment_widget.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/feature/florist/state/one_order_state.dart';
import 'package:flutter_boilerplate/feature/order_details/widget/button_processing.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/http/app_exception.dart';
import 'package:flutter_boilerplate/shared/model/attachment.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_boilerplate/shared/widget/ZoomableAssetImageScreen.dart';
import 'package:flutter_boilerplate/shared/widget/ZoomableFileImageScreen.dart';
import 'package:flutter_boilerplate/shared/widget/ZoomableNetworkImageScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';

final imageFileListProvider = StateProvider<List<XFile>?>((ref) {
  return null;
});

class OrderDetailsPage extends ConsumerWidget {
  OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  final String orderId;
  final ImagePicker _picker = ImagePicker();
  Order? _order;
  String userId = '';

  Future<void> _onImageButtonPressed(ImageSource source, WidgetRef ref) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      _setImageFileListFromFile(pickedFile, ref);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(oneOrderProvider.notifier).initTimer(orderId);
    final _imageFileList = ref.watch(imageFileListProvider);
    final order = ref.watch(oneOrderProvider);
    ref.watch(tokenProvider).when(
        loading: () {},
        hasValue: (token) {
          userId = token.id;
        },
        empty: (error) {});
    order.when(
      loading: () {
        if (_order == null) {
          ref.read(oneOrderProvider.notifier).getOrderById(orderId);
          // if (ref.read(imageFileListProvider) != null) {
          //   ref.read(imageFileListProvider.state).state = null;
          // }
        }
      },
      orderLoaded: (order) {
        if (order.status == OrderStatus.DONE.name) {
          ref.read(oneOrderProvider.notifier).getOrderById(orderId);
          // return Get.back();
        }
        if (orderId != order.id) {
          ref.read(oneOrderProvider.notifier).getOrderById(orderId);
        } else {
          _order = order;
        }
      },
      error: (AppException error) {},
    );
    Widget _bodyWidget = order.when(loading: () {
      return _widgetShimmer(context, ref);
    }, orderLoaded: (order) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _titleAndTextWidget(
                            title: 'Khách hàng: ${order.buyer.fullName ?? ''}',
                            text: 'Thời gian: ${order.deliveryDateTime}',
                          ),
                          _titleAndTextWidget(
                            title: 'Đơn giá',
                            text: 'Giá: ${order.price ?? ''}',
                          ),
                          _titleAndTextWidget(
                            title: 'Liên Hệ',
                            text:
                                'SĐT Sale: ${order.supportedSale.phoneNumber ?? ''}',
                          ),
                          _titleAndTextWidget(
                            title: 'Ghi chú',
                            text:
                                'Ghi chú cho thợ: ${order.noteForFlorist ?? ''}\nGhi chú của khách: ${order.customerMessage ?? ''}',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  VerticalDivider(width: 2.w),
                                  Builder(
                                    builder: (ctx) => IconButton(
                                      icon: const Icon(
                                          Icons.chat_bubble_outline_outlined,
                                          color: Colors.grey),
                                      onPressed: () => {_openComment(ctx)},
                                    ),
                                  ),
                                  VerticalDivider(width: 1.w),
                                  Text('${order.comments.length} bình luận',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              if (order.status == OrderStatus.DOING.name ||
                                  order.status ==
                                      OrderStatus.CUSTOMER_REJECTED.name ||
                                  order.status ==
                                      OrderStatus.SALE_REJECTED.name)
                                Builder(
                                  builder: (ctx) => ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(50, 50),
                                        shape: const CircleBorder(),
                                        primary: Colors.white,
                                        side: BorderSide(
                                            width: 2.0,
                                            color: Colors.blueAccent)),
                                    child: const Icon(Icons.upload_outlined,
                                        color: Colors.blueAccent),
                                    onPressed: () =>
                                        {_openBottomSheetUploadImage(ctx, ref)},
                                  ),
                                ),
                            ],
                          ),
                          Divider(color: Colors.black26, thickness: 0.25.w),
                          _imageFromAttachment(ref),
                          _previewImages(ref),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonProcessing(
            orderId: order.id,
            currentStatus: order.status,
            version: order.version,
            files: _imageFileList,
            assignedId: order.supportedSale.id,
            onPressed: () {
              ref.read(imageFileListProvider.state).state = null;
            },
          )
        ],
      );
    }, error: (error) {
      return _widgetShimmer(context, ref);
    });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Thông tin đơn hàng'),
          leading: BackButton(onPressed: () {
            Get.back();
            ref.read(oneOrderProvider.notifier).cancelTimer();
          }),
        ),
        body: _bodyWidget);
  }

  Widget _imageFromAttachment(WidgetRef ref) {
    final _imageFileList = ref.watch(imageFileListProvider);
    if (_order != null) {
      final attachments = _order!.attachments;
      attachments?.sort((a, b) {
        final result = a.createdOn.compareTo(b.createdOn);
        if (result == 0) {
          return a.url.hashCode.compareTo(b.url.hashCode);
        }
        return result;
      });
      _order!.assignmentHistories
          .sort((a, b) => a.createdOn.compareTo(b.createdOn));
      final lastAssignment = _order!.assignmentHistories.last;
      final floristUploadList = attachments
          ?.where((element) =>
              element.uploadedBy?.id == userId &&
              element.createdOn.compareTo(lastAssignment.createdOn) > 0)
          .whereType<Attachment>()
          .toList();
      if ((floristUploadList == null || floristUploadList.isEmpty) &&
          (_imageFileList == null || _imageFileList.isEmpty) &&
          _order?.status != OrderStatus.DONE.name) {
        return Center(
          child: Column(
            children: [
              const Text('Khi làm xong bạn cần tải lên ít nhất 1 bức ảnh'),
              const Text('* Thêm ít nhất một ảnh',
                  style: TextStyle(color: Colors.red)),
              if (attachments != null && attachments.isNotEmpty)
                _listImageViewFromAttachments(attachments, ref)
            ],
          ),
        );
      }
      if (attachments != null && attachments.isNotEmpty) {
        return _listImageViewFromAttachments(attachments, ref);
      }
    }
    return const Text('');
  }

  Widget _listImageViewFromAttachments(
      List<Attachment> attachments, WidgetRef ref) {
    return GestureDetector(
      child: Card(
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: attachments.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                if (attachments[index].uploadedBy?.id != userId ||
                    _order?.status != OrderStatus.DOING.name) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: GestureDetector(
                          child: Image.network(
                            attachments[index].url,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ZoomableNetworkImageScreen(
                                  imageUrl: attachments[index].url,
                                ),
                              ),
                            );
                          }),
                    ),
                  );
                }

                return Stack(children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: GestureDetector(
                            child: Image.network(
                              attachments[index].url,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ZoomableNetworkImageScreen(
                                    imageUrl: attachments[index].url,
                                  ),
                                ),
                              );
                            }),
                      )),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.delete_forever, size: 8.w),
                      onPressed: () {
                        ref
                            .read(oneOrderProvider.notifier)
                            .deleteImage(attachments[index].id!);
                        _order!.attachments!.remove(attachments[index]);
                      },
                      color: Colors.red,
                    ),
                  )
                ]);
              }),
        ),
      ),
      onTap: () {},
    );
  }

  Widget _previewImages(WidgetRef ref) {
    final _imageFileList = ref.watch(imageFileListProvider);
    if (_imageFileList != null && _imageFileList.isNotEmpty) {
      return GestureDetector(
        child: Card(
          elevation: 10,
          child: Container(
            alignment: Alignment.center,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _imageFileList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: GestureDetector(
                            child: Image.file(
                              File(_imageFileList[index].path),
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ZoomableFileImageScreen(
                                    path: _imageFileList[index].path,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete_forever, size: 8.w),
                        onPressed: () {
                          _imageFileList.remove(_imageFileList[index]);
                          _setImageFileListFromFile(null, ref);
                        },
                        color: Colors.red,
                      ),
                    )
                  ]);
                }),
          ),
        ),
        onTap: () {},
      );
    }

    return const Text('');
  }

  Widget _titleWidget(title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _titleAndTextWidget({
    required String title,
    required String text,
    String? description,
  }) {
    return GFListTile(
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.w),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      description: Text(description ?? ''),
      subTitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.w),
        child: Text(text,
            style: const TextStyle(color: Colors.black54, fontSize: 16)),
      ),
    );
  }

  Widget _widgetShimmer(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }

  void _setImageFileListFromFile(XFile? value, WidgetRef ref) {
    final _imageFileList = ref.watch(imageFileListProvider);
    ref.read(imageFileListProvider.state).state = value == null
        ? [...?_imageFileList]
        : <XFile>[...?_imageFileList, value];
  }

  void _openComment(BuildContext ctx) {
    if (_order != null) {
      Get.to(() => ChatDetailView(orderId: _order!.id));
      // Scaffold.of(ctx)
      //     .showBottomSheet((context) => );
    }
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
}
