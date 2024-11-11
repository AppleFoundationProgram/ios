# CrumpDump

CrumpDump는 감정을 기록하고 해소하는 데 도움을 주는 iOS 앱입니다. 사용자는 감정을 선택하고 종이 쪽지에 그 감정을 적은 후, 이를 가상으로 구기고 던지는 행위를 통해 감정을 표현하고 정화할 수 있습니다. 던진 쪽지는 귀여운 개구리 인형이 먹어 치우며 감정을 없애주는 상징적인 역할을 합니다. 이 앱은 심리적 표현을 통해 작은 트라우마와 부정적인 감정을 긍정적인 방식으로 다룰 수 있도록 돕습니다.

CrumpDump is an iOS app designed to help users express and release emotions. Users can select emotions, write them down on a virtual note, crumple it up, and throw it to symbolically process and release their feelings. The thrown note is "eaten" by a cute frog doll, symbolically erasing the emotions. This app helps users deal with small traumas and negative emotions in a positive way through psychological expression.
![Monitor 2](https://github.com/user-attachments/assets/e090b517-a12c-4839-a67a-ba8d166a6bb5)

![crumpdump1](https://github.com/user-attachments/assets/bee86fab-9a92-46da-a8f6-49dc112bf68c)
![crumpdump2](https://github.com/user-attachments/assets/9c309923-8287-4c96-a25d-8e52a6ccb377)
![crumpdump3](https://github.com/user-attachments/assets/81c411dc-bf3a-4964-93c8-d5e3d4d62f36)
![crumpdump4](https://github.com/user-attachments/assets/a0962735-36df-42c9-9eee-f0e6ef929ebc)
![crumpdump5](https://github.com/user-attachments/assets/03d29035-4916-4261-b421-e075713f8f24)


## 주요 기능 | Key Features

### 1. 감정 기록 | Emotion Recording
- 사용자는 현재 느끼고 있는 감정이나 상황을 자유롭게 기록할 수 있습니다. 작성된 감정은 이후 종이에 적혀 구겨지며, 던지기 애니메이션을 통해 감정을 해소할 수 있습니다.
- Users can freely record their current emotions or situations. The recorded emotion is written on a piece of paper, crumpled, and thrown to help release emotions.

### 2. 감정 선택 | Emotion Selection
- 사용자는 버리고 싶은 감정을 선택할 수 있습니다. 여러 감정 카테고리에서 원하는 감정을 최대 3개까지 선택하여 감정의 본질을 구체화할 수 있습니다.
- Users can select emotions they want to discard. Up to three emotions can be chosen from various categories to clarify their essence.

### 3. 종이 구기기 | Crumpling the Note
- 사용자는 화면에서 종이를 길게 눌러 가상으로 종이를 구기면서 진동 및 오디오 효과를 경험할 수 있습니다. 이 행위는 감정을 물리적으로 분리하는 느낌을 제공합니다.
- Users can virtually crumple the note by pressing and holding it on the screen, experiencing vibration and sound effects. This action helps users feel as if they are physically separating from their emotions.

### 4. 던지기 | Throwing the Note
- 사용자는 구긴 종이를 목표물(인형)에 던지는 동작을 통해 감정을 해소할 수 있습니다. 던지기 동작은 CoreMotion을 활용해 사용자의 모션 데이터를 분석하여 정확히 감지합니다.
- 던진 종이는 개구리 인형이 먹으며, 이로써 사용자는 감정이 사라지는 느낌을 받을 수 있습니다. 이 과정은 감정을 물리적 행위로 해소하는 심리적 효과를 제공합니다.
- Users can throw the crumpled note towards a target (the frog doll) as a way to release their emotions. Throwing is accurately detected by analyzing user motion data using CoreMotion.
- The frog doll "eats" the thrown note, symbolizing the erasure of emotions. This provides a psychological effect of releasing emotions through physical action.

### 5. 모션 데이터 수집 | Motion Data Collection
- 모션 데이터를 수집하여 사용자가 던지기 동작을 할 때의 가속도(acceleration)와 회전율(rotation rate)을 기록합니다. 수집된 데이터를 통해 모델을 개발자가 직접 만들었습니다.
- Motion data, including acceleration and rotation rate, is collected when users perform the throwing action. The collected data is used to develop the model by the developers.

## 기술 스택 | Tech Stack
- **SwiftUI**: 사용자의 인터페이스를 직관적이고 심플하게 구성하기 위해 사용하였습니다.
- **CoreMotion**: 사용자의 던지기 동작을 감지하고 모션 데이터를 기록합니다.
- **AVFoundation**: 종이를 구길 때 발생하는 소리와 던지기 시의 사운드 효과를 제공합니다.
- **UIKit Dynamics & CAAnimation**: 종이 던지기의 현실적인 애니메이션 효과를 구현합니다.
- **SwiftUI**: Used to create a simple and intuitive user interface.
- **CoreMotion**: Detects users' throwing actions and records motion data.
- **AVFoundation**: Provides sound effects when crumpling and throwing the note.
- **UIKit Dynamics & CAAnimation**: Implements realistic animations for throwing the note.

## 설치 및 실행 방법 | Installation and Running Instructions
1. 이 저장소를 클론합니다. (Clone this repository)
   ```bash
   git clone https://github.com/applefoundationprogram/ios.git
   ```
2. 프로젝트 폴더로 이동합니다. (Move to the project folder.)
3. Xcode에서 `crumpdump.xcodeproj` 파일을 엽니다. (Open the 'crumpdump.xcodeproj' file in Xcode.)
4. iOS 시뮬레이터 또는 물리적 장치에서 실행합니다. (Run the app on an iOS simulator or physical device.)

## 주의사항 | Cautions
- **안전한 사용**: 앱에서 제공하는 던지기 동작은 가상입니다. 실제로 핸드폰을 던지지 않도록 주의하세요. 모션 인식 기능은 주변에 물건이 없는 넉넉한 공간에서 사용하시기 바랍니다.
- Safe Usage: The throwing action is virtual. Please do not physically throw your phone. Use the motion recognition function in a spacious area without any objects around.

## 프로젝트 배경 | Project Background
- 이 프로젝트는 **Apple Developer Academy @POSTECH**의 **Foundation Program 4기**에서 진행한 결과물입니다.
- This project was developed during the Apple Developer Academy @POSTECH as part of Foundation Program 4th Cohort.

## 앱 스토어 링크 | App Store Link
- CrumpDump는 [앱 스토어](https://apps.apple.com/kr/app/crumpdump/id6737130375)에서 다운로드할 수 있습니다.

## 라이선스 | License
- 이 프로젝트는 MIT 라이선스에 따라 배포됩니다. 자세한 사항은 `LICENSE` 파일을 참조해주세요.
- This project is distributed under the MIT License. See the LICENSE file for more details.

## 문의 | Contact
- 질문이나 제안 사항이 있으시면 andrewkimswe@gmail.com로 연락해주세요.
- For questions or suggestions, please contact andrewkimswe@gmail.com.
