class JusoModel {
  JusoModel({
    required this.detBdNmList,
    required this.engAddr,
    required this.rn,
    required this.emdNm,
    required this.zipNo,
    required this.roadAddrPart2,
    required this.emdNo,
    required this.sggNm,
    required this.jibunAddr,
    required this.siNm,
    required this.roadAddrPart1,
    required this.bdNm,
    required this.admCd,
    required this.udrtYn,
    required this.lnbrMnnm,
    required this.roadAddr,
    required this.lnbrSlno,
    required this.buldMnnm,
    required this.bdKdcd,
    required this.liNm,
    required this.rnMgtSn,
    required this.mtYn,
    required this.bdMgtSn,
    required this.buldSlno,
  });

  ///상세건물명
  String detBdNmList;

  ///도로명주소(영문)
  String engAddr;

  ///도로명
  String rn;

  ///읍면동명
  String emdNm;

  ///우편번호
  String zipNo;

  ///도로명주소 참고항목
  String roadAddrPart2;

  ///읍면동일련번호
  String emdNo;

  ///시군구명
  String sggNm;

  ///지번주소
  String jibunAddr;

  ///시도명
  String siNm;

  ///도로명주소(참고항목 제외)
  String roadAddrPart1;

  ///건물명
  String bdNm;

  ///행정구역코드
  String admCd;

  ///지하여부(0 : 지상, 1 : 지하)
  String udrtYn;

  ///지번본번(번지)
  String lnbrMnnm;

  ///전체 도로명주소
  String roadAddr;

  ///지번부번(호)
  String lnbrSlno;

  ///건물본번
  String buldMnnm;

  ///공동주택여부(1 : 공동주택, 0 : 비공동주택)
  String bdKdcd;

  ///법정리명
  String liNm;

  ///도로명코드
  String rnMgtSn;

  ///산여부(0 : 대지, 1 : 산)
  String mtYn;

  ///건물관리번호
  String bdMgtSn;

  ///건물부번
  String buldSlno;

  factory JusoModel.fromJson(Map<String, dynamic> json) => JusoModel(
        detBdNmList: json["detBdNmList"] ?? '',
        engAddr: json["engAddr"] ?? '',
        rn: json["rn"] ?? '',
        emdNm: json["emdNm"] ?? '',
        zipNo: json["zipNo"] ?? '',
        roadAddrPart2: json["roadAddrPart2"] ?? '',
        emdNo: json["emdNo"] ?? '',
        sggNm: json["sggNm"] ?? '',
        jibunAddr: json["jibunAddr"] ?? '',
        siNm: json["siNm"] ?? '',
        roadAddrPart1: json["roadAddrPart1"] ?? '',
        bdNm: json["bdNm"] ?? '',
        admCd: json["admCd"] ?? '',
        udrtYn: json["udrtYn"] ?? '',
        lnbrMnnm: json["lnbrMnnm"] ?? '',
        roadAddr: json["roadAddr"] ?? '',
        lnbrSlno: json["lnbrSlno"] ?? '',
        buldMnnm: json["buldMnnm"] ?? '',
        bdKdcd: json["bdKdcd"] ?? '',
        liNm: json["liNm"] ?? '',
        rnMgtSn: json["rnMgtSn"] ?? '',
        mtYn: json["mtYn"] ?? '',
        bdMgtSn: json["bdMgtSn"] ?? '',
        buldSlno: json["buldSlno"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "detBdNmList": detBdNmList,
        "engAddr": engAddr,
        "rn": rn,
        "emdNm": emdNm,
        "zipNo": zipNo,
        "roadAddrPart2": roadAddrPart2,
        "emdNo": emdNo,
        "sggNm": sggNm,
        "jibunAddr": jibunAddr,
        "siNm": siNm,
        "roadAddrPart1": roadAddrPart1,
        "bdNm": bdNm,
        "admCd": admCd,
        "udrtYn": udrtYn,
        "lnbrMnnm": lnbrMnnm,
        "roadAddr": roadAddr,
        "lnbrSlno": lnbrSlno,
        "buldMnnm": buldMnnm,
        "bdKdcd": bdKdcd,
        "liNm": liNm,
        "rnMgtSn": rnMgtSn,
        "mtYn": mtYn,
        "bdMgtSn": bdMgtSn,
        "buldSlno": buldSlno,
      };
}
