//
//  SelectEmotionView.swift
//  crumpdump
//
//  Created by taenee on 10/14/24.
//

import SwiftUI

struct SelectEmotionView: View {
    
    struct Emotion: Identifiable {
        let id: Int
        let name: String
        var children: [Emotion]?
    }
    
    let emotions: [Emotion] = [
        Emotion(id: 1, name: "분노", children: [
            Emotion(id: 2, name: "끓어오르는"),
            Emotion(id: 3, name: "복수심"),
            Emotion(id: 4, name: "불쾌한"),
            Emotion(id: 5, name: "불만족스러운"),
            Emotion(id: 6, name: "격분한"),
            Emotion(id: 7, name: "화가 난"),
            Emotion(id: 8, name: "폭발 직전인"),
            Emotion(id: 9, name: "속상한"),
            Emotion(id: 10, name: "분함을 느끼는"), // 수정됨
            Emotion(id: 11, name: "억울한"),
            Emotion(id: 12, name: "짜증나는"),
            Emotion(id: 13, name: "흥분한"),
            Emotion(id: 14, name: "비난하고 싶은"),
            Emotion(id: 15, name: "분개한"),
            Emotion(id: 16, name: "괴팍한"),
            Emotion(id: 17, name: "신경질적인")
        ]),
        
        Emotion(id: 18, name: "죄책감과 수치심", children: [
            Emotion(id: 19, name: "죄책감"),
            Emotion(id: 20, name: "수치심"),
            Emotion(id: 21, name: "부끄러움"),
            Emotion(id: 22, name: "후회하는"),
            Emotion(id: 23, name: "자책하는"),
            Emotion(id: 24, name: "책임을 느끼는"),
            Emotion(id: 25, name: "민망한"),
            Emotion(id: 26, name: "창피한"),
            Emotion(id: 27, name: "당혹스러운"),
            Emotion(id: 28, name: "망신스러운"),
            Emotion(id: 29, name: "잘못을 느끼는"),
            Emotion(id: 30, name: "속죄하고 싶은"),
            Emotion(id: 31, name: "감추고 싶은"),
            Emotion(id: 32, name: "내가 부족하다고 느끼는"),
            Emotion(id: 33, name: "자신감 없는")
        ]),
        
        Emotion(id: 34, name: "불안과 걱정", children: [
            Emotion(id: 35, name: "두려운"),
            Emotion(id: 36, name: "겁먹은"),
            Emotion(id: 37, name: "불안한"),
            Emotion(id: 38, name: "긴장된"),
            Emotion(id: 39, name: "초조한"),
            Emotion(id: 40, name: "의심하는"),
            Emotion(id: 41, name: "불확실한"),
            Emotion(id: 42, name: "걱정스러운"),
            Emotion(id: 43, name: "공포스러운"),
            Emotion(id: 44, name: "위협을 느끼는"),
            Emotion(id: 45, name: "심장이 두근거리는"),
            Emotion(id: 46, name: "불안정한"),
            Emotion(id: 47, name: "예측 불가능한"),
            Emotion(id: 48, name: "망설이는"),
            Emotion(id: 49, name: "공포에 질린")
        ]),
        
        Emotion(id: 50, name: "슬픔과 상실감", children: [
            Emotion(id: 51, name: "슬픈"),
            Emotion(id: 52, name: "비탄에 잠긴"),
            Emotion(id: 53, name: "상실감을 느끼는"),
            Emotion(id: 54, name: "눈물이 나는"),
            Emotion(id: 55, name: "쓸쓸한"),
            Emotion(id: 56, name: "고독한"),
            Emotion(id: 57, name: "외로운"),
            Emotion(id: 58, name: "잃어버린 것 같은"),
            Emotion(id: 59, name: "패배감을 느끼는"),
            Emotion(id: 60, name: "실망한"),
            Emotion(id: 61, name: "상심한"),
            Emotion(id: 62, name: "마음이 허전한"),
            Emotion(id: 63, name: "버림받은"),
            Emotion(id: 64, name: "안타까운")
        ]),
        
        Emotion(id: 65, name: "피로와 스트레스", children: [
            Emotion(id: 66, name: "지친"),
            Emotion(id: 67, name: "피로한"),
            Emotion(id: 68, name: "번아웃된"),
            Emotion(id: 69, name: "무기력한"),
            Emotion(id: 70, name: "탈진한"),
            Emotion(id: 71, name: "기진맥진한"),
            Emotion(id: 72, name: "스트레스받는"),
            Emotion(id: 73, name: "압박감을 느끼는"),
            Emotion(id: 74, name: "숨이 막히는"),
            Emotion(id: 75, name: "체력적으로 한계인"),
            Emotion(id: 76, name: "정신적으로 고갈된"),
            Emotion(id: 77, name: "피곤한"),
            Emotion(id: 78, name: "성취감이 없는"),
            Emotion(id: 79, name: "마음이 무거운"),
            Emotion(id: 80, name: "정신이 혼미한")
        ]),
        
        Emotion(id: 81, name: "실망과 후회", children: [
            Emotion(id: 82, name: "실망한"),
            Emotion(id: 83, name: "기대에 미치지 못한"),
            Emotion(id: 84, name: "이룰 수 없는"),
            Emotion(id: 85, name: "허무한"),
            Emotion(id: 86, name: "망연자실한"),
            Emotion(id: 87, name: "아쉬운"),
            Emotion(id: 88, name: "패배감을 느끼는"),
            Emotion(id: 89, name: "바보 같은"),
            Emotion(id: 90, name: "좌절한"),
            Emotion(id: 91, name: "원망하는"),
            Emotion(id: 92, name: "돌이킬 수 없는"),
            Emotion(id: 93, name: "잘못을 저지른 것 같은"),
            Emotion(id: 94, name: "변명하고 싶은")
        ]),
        
        Emotion(id: 95, name: "열등감과 질투", children: [
            Emotion(id: 96, name: "열등감을 느끼는"),
            Emotion(id: 97, name: "질투심이 드는"), // 수정됨
            Emotion(id: 98, name: "시기하는"),
            Emotion(id: 99, name: "남들과 비교하는"),
            Emotion(id: 100, name: "자신이 부족하다고 느끼는"),
            Emotion(id: 101, name: "초라한"),
            Emotion(id: 102, name: "불안한"),
            Emotion(id: 103, name: "마음이 불편한"),
            Emotion(id: 104, name: "부족한"),
            Emotion(id: 105, name: "못나 보이는")
        ])
    ]
    
    @State private var selectableEmotions : Set<Int> = [ ]
    //    @State private var emotionString = ""
    @State private var emotionList:[String] = []
    @State private var showToast = false
    @State private var ableNext = false
    
    var body: some View {
        NavigationView{
            ZStack {
                VStack {
                    Text("버리고 싶은 감정 찾기")
                        .padding()
                    
                    Text("기억에서 분리하고 싶은 감정을 1개 이상 선택해주세요.")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                    
                    HStack {
                        ForEach(emotionList, id: \.self) { item in
                            Button(action: {
                                emotionList.removeAll { $0 == item }
                                if let emotion = emotions.flatMap({ $0.children ?? [] }).first(where: { $0.name == item }) {
                                    selectableEmotions.remove(emotion.id)
                                }
                                updateSelectedEmotionsText()
                            }) {
                                KeywordCapsule(keyword: item, symbol: "xmark", color: Color.gray)
                            }
                        }
                    }.padding()
                    
                    if !emotionList.isEmpty {
                        Button(action: {
                            emotionList.removeAll()
                            selectableEmotions.removeAll()
                            updateSelectedEmotionsText()
                        }) {
                            Text("전체 삭제")
                                .foregroundColor(Color.red)
                        }
                        .padding(5)
                    }
                    
                    
                    List {
                        OutlineGroup(emotions, children: \.children) {
                            item in HStack {
                                Text(item.name)
                                Spacer()
                                if canSelectEmotion(item), selectableEmotions.contains(item.id) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                } else if canSelectEmotion(item) {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if canSelectEmotion(item) {
                                    toggleSelectableState(for: item)
                                }
                            }
                        }
                    }
                    
                    NavigationLink(destination: CrumpleNewView()) {
                        Text("다음")
                            .padding()
                            .foregroundColor(.white)
                            .background(ableNext ? Color.blue :  Color.gray)
                            .cornerRadius(10)
                    }.disabled(!ableNext)
                }
                
                if showToast {
                    VStack {
                        Spacer()
                        Text("최대 3개의 감정만 선택할 수 있습니다.")
                            .font(.body)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.bottom, 50)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: showToast)
                    }
                }
            }
        }
    }
    
    private func canSelectEmotion(_ emotion: Emotion) -> Bool {
        return emotion.children == nil
    }
    
    private func updateSelectedEmotionsText() {
        let selectedEmotionsList = emotions.compactMap { $0.children }
            .flatMap { $0 }
            .filter { selectableEmotions.contains($0.id) }
            .map { $0.name }
        
        //        emotionString = selectedEmotionsList.isEmpty
        //        ? "": selectedEmotionsList.joined(separator: ", ")
        
        ableNext = selectedEmotionsList.count > 0
        emotionList = selectedEmotionsList
    }
    
    private func toggleSelectableState(for emotion: Emotion) {
        if selectableEmotions.contains(emotion.id) {
            selectableEmotions.remove(emotion.id)
        } else if selectableEmotions.count < 3 {
            selectableEmotions.insert(emotion.id)
        } else {
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showToast = false
                }
            }
            return
        }
        updateSelectedEmotionsText()
    }
}

#Preview {
    SelectEmotionView()
}

