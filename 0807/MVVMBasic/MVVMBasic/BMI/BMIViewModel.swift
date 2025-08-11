//
//  BMIViewModel.swift
//  MVVMBasic
//
//  Created by Song Kim on 8/11/25.
//

import Foundation

enum bmiError: Error {
    case emptyString
    case isNotInt
    case overHeightRange // 10 - 300
    case overWeightRange // 1 - 600
}

class BMIViewModel {
    
    var inputHeight = Field("")
    var inputWeight = Field("")
    
    var outputBMI = Field("")
    var successBMI = Field(false)
    
    init() {
        inputHeight.playAction { _ in
            self.resultMessage()
        }
        inputWeight.playAction { _ in
            self.resultMessage()
        }
    }
    
    private func resultMessage() {
        do {
            let _ = try checkBMIError(height: inputHeight.value, weight: inputWeight.value)
            outputBMI.value = "\(calculateBMI(height: Int(inputHeight.value)!, weight: Int(inputWeight.value)!))"
            successBMI.value = true
        } catch bmiError.emptyString {
            outputBMI.value = "몸무게와 키 모두 입력해주세요"
            successBMI.value = false
        } catch bmiError.isNotInt {
            outputBMI.value = "숫자가 아닙니다"
            successBMI.value = false
        } catch bmiError.overHeightRange {
            outputBMI.value = "키 범위를 벗어났습니다"
            successBMI.value = false
        } catch bmiError.overWeightRange {
            outputBMI.value = "몸무게 범위를 벗어났습니다"
            successBMI.value = false
        } catch {
            outputBMI.value = "bmi에러 외의 에러가 발생했습니다"
            successBMI.value = false
        }
    }
    
    private func checkBMIError<T: StringProtocol>(height: T, weight: T) throws -> Bool {
        guard !(height.isEmpty) && !(weight.isEmpty) else {
            throw bmiError.emptyString
        }
        guard Int(height) != nil && Int(weight) != nil else {
            throw bmiError.isNotInt
        }
        guard 10 < Int(height)! && Int(height)! < 300 else {
            throw bmiError.overHeightRange
        }
        guard 1 < Int(weight)! && Int(weight)! < 600 else {
            throw bmiError.overWeightRange
        }
        return true
    }
    
    private func calculateBMI(height: Int, weight: Int) -> Double {
        let heightM = (Double(height) / 100.0)
        return Double(weight) / (heightM * heightM)
    }
}
