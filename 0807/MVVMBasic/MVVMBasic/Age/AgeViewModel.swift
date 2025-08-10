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
    func checkAgeError(text: String) throws -> Bool {
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
    
    func resultMessage(text: String?) -> String {
        guard let text else {
            print("textfield가 nil 입니다")
            return ""
        }
        do {
            let _ = try checkAgeError(text: text)
            return "나이를 잘 입력했습니다"
        } catch ageError.emptyString {
            return "입력된 나이가 없습니다"
        } catch ageError.isNotInt {
            return "숫자가 아닙니다"
        } catch ageError.overRange {
            return "범위를 벗어났습니다"
        } catch {
            return "ageError외 다른 에러가 발생했습니다"
        }
    }
}
