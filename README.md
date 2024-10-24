# CrumpDump

CrumpDump는 감정을 기록하고 해소하는 데 도움을 주는 iOS 앱입니다. 사용자는 감정을 선택하고 종이 쪽지에 그 감정을 적은 후, 이를 가상으로 구기고 던지는 행위를 통해 감정을 표현하고 정화할 수 있습니다. 던진 쪽지는 귀여운 개구리 인형이 먹어 치우며 감정을 없애주는 상징적인 역할을 합니다. 이 앱은 심리적 표현을 통해 작은 트라우마와 부정적인 감정을 긍정적인 방식으로 다룰 수 있도록 돕습니다.

![Monitor 2](https://github.com/user-attachments/assets/1cf2e8f8-72b0-4443-8d0f-6d805e0227e1)
<img src="https://github.com/user-attachments/assets/8c3f3f8c-58d7-4d0b-99d3-5e36d4e34d5a" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/615f9747-1199-41b0-ba0b-105c1f87ecfe" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/bca1ec21-8970-4795-b4e4-59efa35e4459" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/632aa9ba-cdf7-4dce-9809-bd8143b5f097" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/47647f2b-7c48-4923-9ba8-c983634687b2" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/c389e896-4c4d-4573-a8ef-f1e32da1a7f1" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/ff2bd8d4-7985-4a66-9a14-da8215075a05" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/1fff4e7f-d5f7-4997-8baa-83cf71d46e6c" width="150" style="display:inline-block;">
<img src="https://github.com/user-attachments/assets/875f4495-e17f-4c22-8d6a-b0654a5ef1b6" width="150" style="display:inline-block;">

## 주요 기능

### 1. 감정 기록
- 사용자는 현재 느끼고 있는 감정이나 상황을 자유롭게 기록할 수 있습니다. 작성된 감정은 이후 종이에 적혀 구겨지며, 던지기 애니메이션을 통해 감정을 해소할 수 있습니다.

### 2. 감정 선택
- 사용자는 버리고 싶은 감정을 선택할 수 있습니다. 여러 감정 카테고리에서 원하는 감정을 최대 3개까지 선택하여 감정의 본질을 구체화할 수 있습니다.

### 3. 종이 구기기
- 사용자는 화면에서 종이를 길게 눌러 가상으로 종이를 구기면서 진동 및 오디오 효과를 경험할 수 있습니다. 이 행위는 감정을 물리적으로 분리하는 느낌을 제공합니다.

### 4. 던지기
- 사용자는 구긴 종이를 목표물(인형)에 던지는 동작을 통해 감정을 해소할 수 있습니다. 던지기 동작은 CoreMotion을 활용해 사용자의 모션 데이터를 분석하여 정확히 감지합니다.
- 던진 종이는 개구리 인형이 먹으며, 이로써 사용자는 감정이 사라지는 느낌을 받을 수 있습니다. 이 과정은 감정을 물리적 행위로 해소하는 심리적 효과를 제공합니다.

### 5. 모션 데이터 수집
- 모션 데이터를 수집하여 사용자가 던지기 동작을 할 때의 가속도(acceleration)와 회전율(rotation rate)을 기록합니다. 수집된 데이터를 통해 모델을 개발자가 직접 만들었습니다.

## 기술 스택
- **SwiftUI**: 사용자의 인터페이스를 직관적이고 심플하게 구성하기 위해 사용하였습니다.
- **CoreMotion**: 사용자의 던지기 동작을 감지하고 모션 데이터를 기록합니다.
- **AVFoundation**: 종이를 구길 때 발생하는 소리와 던지기 시의 사운드 효과를 제공합니다.
- **UIKit Dynamics & CAAnimation**: 종이 던지기의 현실적인 애니메이션 효과를 구현합니다.

## 설치 및 실행 방법
1. 이 저장소를 클론합니다.
   ```bash
   git clone https://github.com/applefoundationprogram/ios.git
   ```
2. 프로젝트 폴더로 이동합니다.
3. Xcode에서 `crumpdump.xcodeproj` 파일을 엽니다.
4. iOS 시뮬레이터 또는 물리적 장치에서 실행합니다.

## 주의사항
- **안전한 사용**: 앱에서 제공하는 던지기 동작은 가상입니다. 실제로 핸드폰을 던지지 않도록 주의하세요. 모션 인식 기능은 주변에 물건이 없는 넉넉한 공간에서 사용하시기 바랍니다.

## 프로젝트 배경
- 이 프로젝트는 **Apple Developer Academy @POSTECH**의 **Foundation Program 4기**에서 진행한 결과물입니다.

## 앱 스토어 링크
- CrumpDump는 [앱 스토어](https://testflight.apple.com/join/mh7q81Vs)에서 다운로드할 수 있습니다.(현재는 TestFlight)

## 라이선스
- 이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 사항은 `LICENSE` 파일을 참조해주세요.

## 문의
- 질문이나 제안 사항이 있으시면 andrewkimswe@gmail.com로 연락해주세요.
