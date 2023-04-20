import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../../../api/address_api.dart';
import '../../../api/base/base_response_model.dart';
import '../../../global/global_toast_widget.dart';
import '../../../models/address/common_model.dart';
import '../../../models/address/juso_model.dart';

class AddressViewModel extends ChangeNotifier {
  AddressViewModel();

  // Variable ▼ ==========================================
  /// 데이터 로딩 (fasle : 로딩 중 화면을 보여줌)
  bool _isLoading = false;

  /// 데이터 로딩 (fasle : 로딩 중 화면을 보여주지 않음)
  bool _isProcess = false;

  /// 검색어
  String _keyword = '';

  /// 검색된 주소 리스트
  List<JusoModel> jusoList = [];

  /// response 상태
  late CommonModel common;

  ///총 검색 결과 수
  int totalCount = 0;

  ///한번에 가져올 페이지
  int cntPerPage = 10;

  ///현재 페이지
  int currentPage = 1;

  // Getter/Settter ▼ ==========================================
  /// 데이터 로딩
  bool get isLoading => _isLoading;

  void setIsLoading(bool data) {
    _isLoading = data;

    notifyListeners();
  }

  /// 데이터 로딩
  bool get isProcess => _isProcess;

  void setisProcess(bool data) {
    _isProcess = data;

    notifyListeners();
  }

  // Fucntion ▼ ==========================================

  Future<void> fetchAddressData(String keyword) async {
    if (keyword.isEmpty) {
      GlobalToastWidget(message: '검색어를 입력해주세요.');
      return;
    }

    try {
      setIsLoading(true);

      _keyword = keyword;
      currentPage = 1;

      BaseResponseModel? response =
          await AddressApi().fetch(_keyword, currentPage, cntPerPage);

      if (response == null) return;

      if (response.body['results'] != null) {
        Map<String, dynamic> results = response.body['results'];
        common = CommonModel.fromJson(results['common']);

        totalCount = int.parse(common.totalCount);

        if (totalCount > 0) {
          /// same as assignAll
          jusoList.clear();
          jusoList.addAll(List<JusoModel>.from(
              (results['juso'].map((e) => JusoModel.fromJson(e)))));
        } else {
          jusoList.clear();
        }
      }
      currentPage += 1;
    } catch (e) {
      Logger().d(e);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> updateAddressData() async {
    if (_isProcess) return;
    try {
      _isProcess = true; //not update UI

      BaseResponseModel? response =
          await AddressApi().fetch(_keyword, currentPage, cntPerPage);

      if (response == null) return;

      if (response.body['results'] != null) {
        Map<String, dynamic> results = response.body['results'];
        common = CommonModel.fromJson(results['common']);

        totalCount = int.parse(common.totalCount);

        if (totalCount > 0) {
          jusoList.addAll(List<JusoModel>.from(
              (results['juso'].map((e) => JusoModel.fromJson(e)))));
        } else {
          jusoList.clear();
        }
      }
      currentPage += 1;
    } catch (e) {
      Logger().d(e);
    } finally {
      setisProcess(false); //update UI
    }
  }
}
