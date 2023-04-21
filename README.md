# weather_today

오늘의 날씨
1. 프로젝트 개요
'https://www.weatherapi.com/' 에서 제공하는 날씨 API를 사용하여 '오늘의 날씨'를 확인하게 도와주는 모바일 서비스 이다.

2. 주요기능
- 사용자는 관심지역을 설정할 수 있다.
- 관심지역의 날씨를 알 수 있다.
- 날씨 정보에는 다음을 포함한다.
  > 기온, 체감온도, 바람, 강수확률, 자외선 지수 
- dark mode, light mode를 설정할 수 있다.
- 사용자는 scale을 지정할 수 있다.(바람 속도 단위, 기온 단위)

3. 앱 구성
- Mutiprovider, goRouter로 route 와 상태관리를 한다.
- dio 로 http 통신을 한다.
