//
//  MainView.swift
//  ScratchLottery
//
//  Created by Taiyo Koshiba on 2023/06/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: HappyCountView()) {
                    Text("ハッピーカウント改")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                NavigationLink(destination: CountChallengeView()) {
                    Text("カウントチャレンジ")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
