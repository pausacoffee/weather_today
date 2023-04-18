import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/address/juso_model.dart';
import '../../../utils/text.dart';
import '../model/address_view_model.dart';

/// TextEditingController(검색 창) 사용위해 StatefulWidget로 구현
class AddressSearchWidget extends StatefulWidget {
  const AddressSearchWidget({super.key});

  @override
  State<AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<AddressSearchWidget> {
  //주소 검색 textfield
  final TextEditingController _editController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  //주소 결과 ScrollController : pagination
  final ScrollController _scrollController = ScrollController();

  //주소 검색창 팽창 유무 (animation)
  bool _isExpanded = false;

  //키보드 높이 : 키보드 높이에 맞에 검색창 팽창
  bool _isKeyboardVisible = false;

  late AddressViewModel addressViewModel;

  @override
  Widget build(BuildContext context) {
    addressViewModel = Provider.of<AddressViewModel>(context);
    return Stack(
      children: [
        _searchAddress(),
        _favorites(),
      ],
    );
  }

  /// 사용자 지정 관심 지역
  Widget _favorites() {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Divider(
          color: Colors.grey[800],
          thickness: 1.sp,
        ),
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _favoritesTile(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _favoritesTile(int index) {
    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 10.h,
        bottom: 10.h,
      ),
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 5.h,
        bottom: 5.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.grey[900],
      ),
      height: 60.h,
      child: Text(
        '$index',
        style: TextStylePath.base16w400.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }

  /// 데이터 로딩 중 화면
  Widget _loading() {
    return Center(
      child: Text(
        '로딩 중...',
        style: TextStylePath.base16w400.copyWith(color: Colors.white),
      ),
    );
  }

  /// 주소 검색창
  Widget _searchAddress() {
    //380.h + MediaQuery.of(context).viewInsets.bottom
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: _isExpanded ? 350.h : 50.h,
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
        right: 10.w,
        left: 10.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        color: Colors.grey[400],
      ),
      child: Column(
        children: [
          //검색창
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 30.sp,
              ),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: _editController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.w,
                      horizontal: 10.w,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        _editController.clear();

                        setState(() {
                          _isExpanded = false;
                        });
                      },
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
              //indicator and icon button
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: addressViewModel.isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      )
                    : IconButton(
                        onPressed: () async {
                          await addressViewModel
                              .fetchAddressData(_editController.text);

                          setState(() {
                            if (_editController.text.isNotEmpty) {
                              _isExpanded = !_isExpanded;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 30.sp,
                        ),
                      ),
              ),
            ],
          ),

          //검색결과
          _resultAddress(),
        ],
      ),
    );
  }

  /// 주소 검색 결과 List
  Widget _resultAddress() {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        itemCount: addressViewModel.jusoList.length,
        itemBuilder: (context, index) {
          JusoModel item = addressViewModel.jusoList[index];
          return Container(
            padding: EdgeInsets.only(right: 10.w, left: 10.w),
            child: InkWell(
              onTap: () {
                //TODO: 검색된 주소로 current weather 재검색 및 pop
                //location provier를 가지고 있는다? 변화시킨다?
                //
                //context.pop();
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
    _scrollController.addListener(() {
      if (!addressViewModel.isProcess &&
          (addressViewModel.currentPage * addressViewModel.cntPerPage <
              addressViewModel.totalCount) &&
          _scrollController.offset >=
              _scrollController.position.maxScrollExtent - 300) {
        addressViewModel.updateAddressData();
      }
    });

    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
        // if(){

        // }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    _editController.dispose();

    super.dispose();
  }
}
