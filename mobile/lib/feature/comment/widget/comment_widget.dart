import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/comment/model/comment_model.dart';
import 'package:flutter_boilerplate/feature/florist/provider/one_order_provider.dart';
import 'package:flutter_boilerplate/shared/model/user.dart';
import 'package:flutter_boilerplate/shared/provider/token_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

final sendTextProvider = StateProvider<bool>((ref) {
  return false;
});

class ChatDetailView extends ConsumerWidget {
  ChatDetailView({Key? key, required this.orderId}) : super(key: key);
  final _textMessageController = TextEditingController();
  final String orderId;
  String userId = '';
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tokenProvider).when(
        loading: () {},
        hasValue: (token) {
          userId = token.id;
        },
        empty: (error) {});

    return ref.watch(oneOrderProvider).when(loading: _widgetShimmer, orderLoaded: (order) {
      final comments = order.comments;

      return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Bình luận')),
        body:       Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final owner = comments[index].createdBy.id == userId;

                      return comments[index].attachments.isNotEmpty
                          ? Column(children: [
                        Align(
                          alignment: owner
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints:
                            const BoxConstraints(maxWidth: 270),
                            child: Container(
                              margin:
                              const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                color: owner
                                    ? Colors.blueAccent
                                    : Colors.white24,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Text(
                                comments[index].content,
                                overflow: TextOverflow.ellipsis,
                                textAlign: owner
                                    ? TextAlign.right
                                    : TextAlign.left,
                                maxLines: 10,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: owner
                                        ? Colors.white
                                        : Colors.black45,
                                    height: 1.3),
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: comments[index].attachments.length,
                            itemBuilder: (ctx, indexImage) {
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 6),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(50)),
                                  child: Image.network(
                                      comments[index]
                                          .attachments[indexImage]
                                          .url,
                                      fit: BoxFit.fill));
                            })
                      ])
                          : Align(
                          alignment: owner
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 270),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              decoration: BoxDecoration(
                                color: owner
                                    ? Colors.blueAccent
                                    : Colors.black12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16)),
                              ),
                              child: Text(
                                owner
                                    ? comments[index].content
                                    : '${comments[index].createdBy.fullName}: ${comments[index].content}',
                                overflow: TextOverflow.ellipsis,
                                textAlign:
                                (userId == comments[index].createdBy.id)
                                    ? TextAlign.right
                                    : TextAlign.left,
                                maxLines: 10,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                  (userId == comments[index].createdBy.id)
                                      ? Colors.white
                                      : Colors.black45,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
                const Divider(
                  thickness: 1,
                ),
                _buildComposer(context, ref)
              ],
            ))
        ,
      );
    }, error: (error) {
      return _widgetShimmer();
    });
  }

  Widget _widgetShimmer() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildComposer(BuildContext context, WidgetRef ref) {
    final files = ref.read(imageCommentFileListProvider);
    final shouldSend = ref.watch(sendTextProvider);

    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  _onImageButtonPressed(ImageSource.gallery, ref);
                },
                icon: const Icon(Icons.add),
                color: Colors.blue,
              ),
              IconButton(
                onPressed: () {
                  _onImageButtonPressed(ImageSource.camera, ref);
                },
                icon: const Icon(Icons.camera_alt),
                color: Colors.blue,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _textMessageController,
                    onChanged: (text) {
                      ref.read(sendTextProvider.state).state = text.isNotEmpty;
                    },
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 4,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Bình luận...',
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: shouldSend
                    ? () {
                        ref.read(oneOrderProvider.notifier).createComment(
                              orderId: orderId,
                              content: _textMessageController.text,
                              files: files,
                            );
                        _textMessageController.text = '';
                        ref.read(sendTextProvider.state).state = false;
                        _initImageFile(ref);
                      }
                    : null,
                icon: const Icon(Icons.send),
                color: Colors.blue,
              ),
            ],
          ),
          _previewImages(ref)
        ]));
  }

  Future<void> _onImageButtonPressed(ImageSource source, WidgetRef ref) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      _setImageFileListFromFile(pickedFile, ref);
    } catch (e) {}
  }
  void _initImageFile(WidgetRef ref) {
    final _imageFileList = ref.watch(imageCommentFileListProvider);
    ref.read(imageCommentFileListProvider.state).state = null;
  }
  void _setImageFileListFromFile(XFile? value, WidgetRef ref) {
    final _imageFileList = ref.watch(imageCommentFileListProvider);
    ref.read(imageCommentFileListProvider.state).state = value == null
        ? [...?_imageFileList]
        : <XFile>[...?_imageFileList, value];
  }

  Widget _previewImages(WidgetRef ref) {
    final _imageFileList = ref.watch(imageCommentFileListProvider);
    if (_imageFileList != null) {
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
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image.file(
                          File(_imageFileList[index].path),
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
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
}

final imageCommentFileListProvider = StateProvider<List<XFile>?>((ref) {
  return null;
});
