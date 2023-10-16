//
//  CountChallengeView.swift
//  ScratchLottery
//
//  Created by Taiyo Koshiba on 2023/07/13.
//

import SwiftUI

struct CountChallengeView: View {
    @State private var result: [Int] = []

    //    func calculateValues() -> [Int] {
    //        let numbers = [180, 200, 220, 250, 280, 300]
    //        let number = numbers.randomElement() ?? 180
    //        var value1 = Int.random(in: 0...number)
    //        var value2 = Int.random(in: 0...(number - value1))
    //        var value3 = number - (value1 + value2)
    //
    //        // 一の位が0になるように調整
    //        value1 = (value1 / 10) * 10
    //        value2 = (value2 / 10) * 10
    //        value3 = (value3 / 10) * 10
    //
    //        return [value1, value2, value3]
    //    }

    //    func calculateValues() -> [Int] {
    //        let numbers = [180, 200, 220, 250, 280, 300]
    //        let number = numbers.randomElement() ?? 180
    //
    //        var value1: Int
    //        var value2: Int
    //        var value3: Int
    //
    //        repeat {
    //            value1 = Int.random(in: 0...number)
    //            value2 = Int.random(in: 0...(number - value1))
    //            value3 = number - (value1 + value2)
    //
    //            // 一の位が0になるように調整
    //            value1 = (value1 / 10) * 10
    //            value2 = (value2 / 10) * 10
    //            value3 = (value3 / 10) * 10
    //        } while !numbers.contains(value1 + value2 + value3)
    //
    //        return [value1, value2, value3]
    //    }

    func calculateValues() -> [Int] {
        let probabilities = [50, 20, 15, 10, 4, 1]

        let numbers = [180, 200, 220, 250, 280, 300]

        var cumulativeProbabilities: [Int] = []
        var sum = 0
        for probability in probabilities {
            sum += probability
            cumulativeProbabilities.append(sum)
        }

        let randomNumber = Int.random(in: 1...100)
        var selectedIndex = 0
        for i in 0..<cumulativeProbabilities.count {
            if randomNumber <= cumulativeProbabilities[i] {
                selectedIndex = i
                break
            }
        }

        let selectedNumber = numbers[selectedIndex]

        var value1: Int
        var value2: Int
        var value3: Int

        repeat {
            value1 = Int.random(in: 0...selectedNumber)
            value2 = Int.random(in: 0...(selectedNumber - value1))
            value3 = selectedNumber - (value1 + value2)

            // 一の位が0になるように調整
            value1 = (value1 / 10) * 10
            value2 = (value2 / 10) * 10
            value3 = (value3 / 10) * 10
        } while !numbers.contains(value1 + value2 + value3)

        return [value1, value2, value3]
    }


    var body: some View {
        VStack {
            if result.count == 3 {
                Text("結果: \(result[0]), \(result[1]), \(result[2])")
                    .font(.title)

                Text("合計 \(result[0] + result[1] + result[2])")
                    .font(.title)
            }

            Button(action: {
                result = calculateValues()
            }) {
                Text("計算")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}



struct CountChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CountChallengeView()
    }
}
