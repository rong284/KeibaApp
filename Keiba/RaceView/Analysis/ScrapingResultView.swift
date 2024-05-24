//
//  ScrapingResultView.swift
//
//  Created by rong on 2024/05/24.
//

import SwiftUI

struct ScrapingResultView: View {
    let data: [String]
    
    var body: some View {
        VStack {
            Text("Scraping Results")
                .font(.largeTitle)
                .padding()
            
            List(data, id: \.self) { row in
                Text(row)
            }
        }
    }
}

//#Preview {
//    ScrapingResultView()
//}
