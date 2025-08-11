//
//  AgeViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/10/25.
//

import Foundation

enum ageError: Error {
    case emptyString
    case isNotInt
    case overRange
}

class AgeViewModel {
    
    var inputAge = Field("")
    var outputAge = Field("")
    
    init() {
        inputAge.playAction { _ in
            self.resultMessage()
        }
    }
    
    private func resultMessage() {
        do {
            let _ = try checkAgeError(text: inputAge.value)
            outputAge.value = "나이를 잘 입력했습니다"
        } catch ageError.emptyString {
            outputAge.value = "입력된 나이가 없습니다"
        } catch ageError.isNotInt {
            outputAge.value = "숫자가 아닙니다"
        } catch ageError.overRange {
            outputAge.value = "범위를 벗어났습니다"
        } catch {
            outputAge.value = "ageError외 다른 에러가 발생했습니다"
        }
    }
    
    private func checkAgeError(text: String) throws -> Bool {
        guard !(text.isEmpty) else {
            throw ageError.emptyString
        }
        guard Int(text) != nil else {
            throw ageError.isNotInt
        }
        guard 0 < Int(text)! && Int(text)! < 101 else {
            throw ageError.overRange
        }
        return true
    }
}
