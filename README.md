
<img src="https://github.com/Han-hih/Coin/assets/109748526/805fcc86-4896-4f1c-99b2-a5dc6e1ba7b4" width="75" height="75">

# BitPulse

> 관심있는 가상화폐를 검색하고 좋아요 목록 만드는 앱

<img width="1074" alt="image" src="https://github.com/Han-hih/Coin/assets/109748526/c5a73dc3-64b0-4501-be25-ac9b9911d8da">

## 작업환경
- 개발 기간: 24.04.07 ~ 24.04.15(8일, 진행중)
- 인원: 1인
- 최소 버전: iOS 17.0

## 주요기능
- 가상화폐 실시간 검색
- 실시간 등락률 및 현재가 제공
- 현재가와 거래량에 관한 정보 제공
- 좋아요 목록 생성 / 제거

## 기술 스택
- SwiftUI
- MVVM(Action - State)
- Combine, Charts
- URLSession, Async/Await, WebSocket
- Realm

## 주요 기능
- SwiftUI + MVVM기반 Action-State패턴 적용
- **Combine** 기반 데이터 바인딩 및 비동기 통신로직 처리
- URLSession과 Router Pattern을 활용
- URLSession기반 **WebSocket**사용으로 실시간 가격 및 등락률 조회
- **Async/Await**을 적용한 비동기 네트워크 처리
- SwiftUI의 **Charts**프레임워크를 이용한 고가, 저가, 시가, 종가, 거래량을 포함한 차트 생성
- **Realm DB**를 활용한 마켓 코드를 Primary키로 설정, 이를 기반으로 좋아요 목록에 추가/제거
- 한글명, 마켓 코드를 활용한 **실시간 검색** 지원
