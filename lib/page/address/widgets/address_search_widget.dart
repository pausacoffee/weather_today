import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../models/address/juso_model.dart';
import '../../../utils/text.dart';
import '../model/address_view_model.dart';

/// 검색 창, TextEditingController 사용위해 StatefulWidget로 구현
class AddressSearchWidget extends StatefulWidget {
  const AddressSearchWidget({super.key});

  @override
  State<AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<AddressSearchWidget> {
  TextEditingController editController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late AddressViewModel addressViewModel;

  @override
  Widget build(BuildContext context) {
    addressViewModel = Provider.of<AddressViewModel>(context);

    return Column(
      children: [
        _searchAddress(),
        Divider(
          color: Colors.grey[800],
          thickness: 1.sp,
        ),
        addressViewModel.isLoading ? _loading() : _resultAddress(),
      ],
    );
  }

  Widget _loading() {
    return Center(
      child: Text(
        '로딩 중...',
        style: TextStylePath.base16w400.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _searchAddress() {
    // return SliverToBoxAdapter(
    //   child:
    return Container(
      height: 45.h,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        right: 20.w,
        left: 20.w,
      ),
      padding: EdgeInsets.only(
        top: 5.h,
        bottom: 5.h,
        right: 20.w,
        left: 20.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.grey[400],
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 30.sp,
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '검색어를 입력해주세요.';
                }
              },
              controller: editController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10.w,
                  horizontal: 14.w,
                ),
                suffixIcon: IconButton(
                  onPressed: () => editController.clear(),
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                ),
                hintText: '지역 검색',
                hintStyle: TextStylePath.small14w400.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await addressViewModel.fetchAddressData(editController.text);
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30.sp,
            ),
          )
        ],
      ),
    );
    //);
  }

  Widget _resultAddress() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        itemCount: addressViewModel.jusoList.length,
        itemBuilder: (context, index) {
          JusoModel item = addressViewModel.jusoList[index];
          return Container(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: InkWell(
              onTap: () {
                //TODO: 검색된 주소로 current weather 재검색 및 pop
              },
              child: ListTile(
                title: Text(
                  item.roadAddrPart1,
                  style: TextStylePath.title18w400.copyWith(
                    color: Colors.grey[50],
                  ),
                ),
                subtitle: Text(
                  item.jibunAddr,
                  style: TextStylePath.small12w400.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Override ▼ ========================================
  @override
  void initState() {
    //
    scrollController.addListener(() {
      if (!addressViewModel.isProcess &&
          (addressViewModel.currentPage * addressViewModel.cntPerPage <
              addressViewModel.totalCount) &&
          scrollController.offset >=
              scrollController.position.maxScrollExtent - 300) {
        addressViewModel.updateAddressData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    editController.dispose();

    super.dispose();
  }
}
