//
//  MainViewModel.swift
//  Tama
//
//  Created by Song Kim on 8/24/25.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class MainViewModel {
    
    private var level = 1
    let tama: Int
    
    struct Input {
        let riceTap: Observable<String>
        let waterTap: Observable<String>
    }
    
    struct Output {
        let message: BehaviorSubject<String>
        let state: BehaviorSubject<String>
        let tamaImage: BehaviorSubject<UIImage>
    }
    
    private let disposeBag = DisposeBag()
    
    private let messageSubject = BehaviorSubject<String>(value: "")
    private let stateSubject = BehaviorSubject<String>(value: "")
    private lazy var tamaImageSubject = BehaviorSubject<UIImage>(value: UIImage())
    
    init(tama: Int) {
        self.tama = tama
        updateStateLabel()
        tamaImageSubject.onNext(UserDefaultsHelper.shared.getTamaImage(num: tama))
    }
    
    func transform(input: Input) -> Output {
        input.riceTap
            .subscribe(onNext: { [weak self] text in
                self?.handleFeeding(limit: 99, tag: 1, text: text)
            })
            .disposed(by: disposeBag)
        
        input.waterTap
            .subscribe(onNext: { [weak self] text in
                self?.handleFeeding(limit: 49, tag: 2, text: text)
            })
            .disposed(by: disposeBag)
        
        return Output(message: messageSubject, state: stateSubject, tamaImage: tamaImageSubject)
    }
    
    func randomMessage() -> BehaviorSubject<String> {
        let ownerName = UserDefaultsHelper.shared.colonName!
        let initMsgs = [
            "안녕하세요 ~ \(ownerName) 반가워요 !",
            "\(ownerName)님 밥주세요 !",
            "좋은 하루에요 \(ownerName)님!",
            "\(ownerName)님 오늘의 과제는 끝내셨나요?",
            "심심하면 블로그를 써봐요 \(ownerName)님"
        ]
        
        messageSubject.onNext(initMsgs.randomElement()!)
        return messageSubject
    }
    
    private func handleFeeding(limit: Int, tag: Int, text: String) {
        if text.isEmpty {
            applyFeedCount(tag, cnt: 1)
        } else if let cnt = Int(text) {
            if cnt > limit {
                messageSubject.onNext("다 먹으면 배부를꺼같아요 ㅠ")
            } else {
                applyFeedCount(tag, cnt: cnt)
            }
        } else {
            messageSubject.onNext("몇개를 먹어야해요?")
        }
    }
    
    private func applyFeedCount(_ tag: Int, cnt: Int) {
        if tag == 1 {
            UserDefaultsHelper.shared.rice![tama] += cnt
        } else {
            UserDefaultsHelper.shared.water![tama] += cnt
        }
        updateLevelIf()
        updateStateLabel()
    }
    
    private func updateLevelIf() {
        let newLevel = UserDefaultsHelper.shared.checkLevel(num: tama)
        let ownerName = UserDefaultsHelper.shared.colonName!
        
        if newLevel > level {
            level = newLevel
            messageSubject.onNext(
                newLevel == 10
                ? "\(ownerName), 다 자랐어요 !"
                : "\(ownerName), 저 조금 자란거 같아요!"
            )
            tamaImageSubject.onNext(UserDefaultsHelper.shared.getTamaImage(num: tama))
        } else if newLevel == level {
            messageSubject.onNext(["냠", "념", "냠 냠", "념 념"].randomElement()!)
        }
    }
    
    private func updateStateLabel() {
        let level = UserDefaultsHelper.shared.checkLevel(num: tama)
        let data = UserDefaultsHelper.shared.getTamaData(num: tama)
        stateSubject.onNext("LV\(level) * 밥알\(data.rice)개 * 물방울\(data.water)개")
    }
}
