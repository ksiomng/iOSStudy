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
    func resultMessage(height: String, weight: String) -> String {
        do {
            let _ = try checkBMIError(height: height, weight: weight)
            return "\(calculateBMI(height: Int(height)!, weight: Int(weight)!))"
        } catch bmiError.emptyString {
            return "몸무게와 키 모두 입력해주세요"
        } catch bmiError.isNotInt {
            return "숫자가 아닙니다"
        } catch bmiError.overHeightRange {
            return "키 범위를 벗어났습니다"
        } catch bmiError.overWeightRange {
            return "몸무게 범위를 벗어났습니다"
        } catch {
            return "bmi에러 외의 에러가 발생했습니다"
        }
    }
    
    func checkBMIError<T: StringProtocol>(height: T, weight: T) throws -> Bool {
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
    
    func calculateBMI(height: Int, weight: Int) -> Double {
        let heightM = (Double(height) / 100.0)
        return Double(weight) / (heightM * heightM)
    }
}
