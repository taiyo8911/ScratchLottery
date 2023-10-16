//
//  HappyCountView.swift
//  ScratchLottery
//
//  Created by Taiyo Koshiba on 2023/07/08.
//

import SwiftUI


// ハッピーカウントを抽選する関数
func lottery() -> Int {
    // くじの当選結果と確率とハッピーカウントのデータ
    let prizes: [(prize: String, probability: Double, happyCount: Int)] = [
        (prize: "1等", probability: 0.000067, happyCount: 9),
        (prize: "2等", probability: 0.004667, happyCount: 8),
        (prize: "3等", probability: 0.040000, happyCount: 7),
        (prize: "4等", probability: 0.333333, happyCount: 6),
        (prize: "5等", probability: 10.000000, happyCount: 5),
        (prize: "ハズレ", probability: 89.62, happyCount: 4)
    ]

    // 重み付きくじを作成
    let weightedPrizes = prizes.flatMap { prize in
        Array(repeating: prize.prize, count: Int(prize.probability * 1000))
    }

    // 重み付きくじからランダムに選択
    let randomIndex = Int.random(in: 0..<weightedPrizes.count)
    let selectedPrize = weightedPrizes[randomIndex]

    // 選択された賞のハッピーカウントを取得
    let happyCount = prizes.first(where: { $0.prize == selectedPrize })?.happyCount ?? 0

    return happyCount
}


struct HappyView: View {
    // 画像タッチフラグ
    @State private var isTouched = false

    // 表示する画像
    let image = "fish.fill"

    var body: some View {
        ZStack {
            Image(systemName: "rectangle.fill")
                .font(.system(size: 80))
                .frame(width: 100, height: 100)
                .opacity(isTouched ? 0 : 1)

            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        }
        .onTapGesture {
            withAnimation {
                isTouched = true
            }
        }
        .border(Color.red, width: 3)
    }
}

struct UnHappyView: View {
    // 画像タッチフラグ
    @State private var isTouched = false

    var body: some View {
        Image(systemName: "rectangle.fill")
            .font(.system(size: 80))
            .frame(width: 100, height: 100)
            .opacity(isTouched ? 0 : 1)
            .border(Color.red, width: 3)
            .onTapGesture {
                withAnimation {
                    isTouched = true
                }
            }
    }
}


struct HappyCountView: View {
    var body: some View {
        // ハッピーカウントを抽選
        let happyCount = lottery()

        // ハッピービューとアンハッピービューを作成・結合・シャッフル
        let combinedViews: [AnyView] = {
            let totalViews = 9
            let happyViews = Array(repeating: HappyView(), count: happyCount)
            let unHappyViews = Array(repeating: UnHappyView(), count: totalViews - happyCount)
            var views: [AnyView] = happyViews.map { AnyView($0) }
            views.append(contentsOf: unHappyViews.map { AnyView($0) })
            views.shuffle()
            return views
        }()

        // ビューを3✕3で表示
        return VStack {
            Text("ハッピーカウント")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            Text("\(happyCount)")

            ForEach(0..<3) { row in
                HStack {
                    ForEach(0..<3) { column in
                        let index = row * 3 + column
                        combinedViews[index]
                    }
                }
            }

            Text("赤枠の中をすべてタップして下さい。魚のマークが5個以上出ればあたりで、出た数によって賞が決まります。")
                .padding()
                .multilineTextAlignment(.center)

            VStack {
                Text("魚が9個 1等")
                Text("魚が8個 2等")
                Text("魚が7個 3等")
                Text("魚が6個 4等")
                Text("魚が5個 5等")
            }
            .padding()
        }
    }
}


struct HappyCountView_Previews: PreviewProvider {
    static var previews: some View {
        HappyCountView()
    }
}
