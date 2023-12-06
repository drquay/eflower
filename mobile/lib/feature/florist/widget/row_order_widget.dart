import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature/florist/model/order.dart';
import 'package:flutter_boilerplate/feature/order_details/widget/button_processing.dart';
import 'package:flutter_boilerplate/feature/order_details/widget/order_details_page.dart';
import 'package:flutter_boilerplate/shared/constants/enum.dart';
import 'package:flutter_boilerplate/shared/util/image_util.dart';
import 'package:flutter_boilerplate/shared/util/mapping_util.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RowOrderWidget extends StatelessWidget {
  const RowOrderWidget({Key? key, required this.order, required this.index, required this.accountId})
      : super(key: key);

  final Order order;
  final int index;
  final String accountId;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => {
        if (order.status != OrderStatus.NEW.name)
          Get.to(() => OrderDetailsPage(orderId: order.id))
      },
      child: Card(
        key: ValueKey(order.id),
        color: Colors.white,
        elevation: 8,
        margin: EdgeInsets.symmetric(vertical: 2.w),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.w),
          child: ListTile(
            leading: Semantics(
              child:
                  Container(width: 65, height: 65, decoration: _leadingImage()),
            ),
            title: _title(),
            isThreeLine: true,
            subtitle: Column(
              children: [
                SizedBox(height: 2.w),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,color: Colors.red,size: 25),
                          const SizedBox(width: 6),
                          Text(MappingUtil.mappingAddress(order.source)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        children: [
                          const Icon(Icons.phone_enabled,size: 25,color: Colors.red),
                          const SizedBox(width: 6),
                          Text(order.buyer.phoneNumber ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 3.w),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.access_time,color: Colors.red,size: 25),
                          const SizedBox(width: 6),
                          Text(order.deliveryDateTime),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30.w,
                      child: Row(
                        children: [
                          const Icon(Icons.account_circle_outlined,color: Colors.red,size: 25,),
                          const SizedBox(width: 6),
                          Text(order.createdBy ?? ''),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            dense: true,
          ),
        ),
      ),
    );
  }

  BoxDecoration _leadingImage() {
    order.attachments?.sort((a, b) {
      final result = a.createdOn.compareTo(b.createdOn);
      if (result == 0) {
        return a.url.hashCode.compareTo(b.url.hashCode);
      }
      return result;
    });
    if (order.attachments == null || order.attachments!.isEmpty) {
      return BoxDecoration(
        image: DecorationImage(
          image: ImageUtil.defaultImage(),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      );
    }

    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(order.attachments![0].url),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }

  Widget _title() {
    final mappingText = MappingUtil.mappingCurrentStatus(order.status);
    final mappingColor = MappingUtil.mappingColorByStatus(order.status);
    if (order.status == OrderStatus.NEW.name) {
      return Row(children: [
        Expanded(child: Text('KH: ${order.buyer.fullName}')),
        SizedBox(
            width: 30.w,
            child: ButtonProcessing(
              width:30.w,
              currentStatus: order.status,
              orderId: order.id,
              version: order.version,
              assignedId: accountId.isNotEmpty?accountId:null,
              onPressed: () => {Get.to(() => OrderDetailsPage(orderId: order.id))},
            ))
      ]);
    }

    return Row(children: [
      Expanded(child: Text('KH: ${order.buyer.fullName}')),
      Expanded(child: OutlinedButton(onPressed: (){},child: Text(mappingText,style: TextStyle(fontWeight: FontWeight.bold),),style: OutlinedButton.styleFrom(primary: mappingColor,side: BorderSide(color: mappingColor),)))
    ]);
  }
}
