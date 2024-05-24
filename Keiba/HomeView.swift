//
// 起動時のメイン画面
// レース情報(netkeiba.com)と収支計算への移動が可能
// Created by rong on 2024/05/24.
//

import SwiftUI

// TODO: レイアウトと収支計算へ移行するボタンを配置予定
struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen")
                    .font(.largeTitle)
                    .padding()
                
                NavigationLink(destination: RaceInfoView()) {
                    Text("Go to netkeiba.com")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Home")
        }
    }
}



#Preview {
    HomeView()
}
