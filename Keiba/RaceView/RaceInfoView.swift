//
// netkeiba.comのサイト表示をする
// 表示されているURLをクリックするとスクレイピング
// Created by rong on 2024/05/24.
//

import SwiftUI
import WebKit
import SwiftSoup

// TODO: スクレイピング機構の調整
struct RaceInfoView: View {
    @StateObject private var webViewModel = WebViewModel()
    @State private var isScrapingActive = false
    @State private var scrapedData: [String] = []
    
    var body: some View {
        VStack {
            WebView(viewModel: webViewModel)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    webViewModel.load(url: URL(string: "https://www.netkeiba.com")!)
                }
        }
        .navigationBarTitle("Race Info", displayMode: .inline)
        .navigationBarItems(leading: backButton, trailing: urlText)
        .sheet(isPresented: $isScrapingActive) {
            ScrapingResultView(data: scrapedData)
        }
    }
    
    private var backButton: some View {
        Button(action: {
            webViewModel.goBack()
        }) {
            Text("Back")
                .foregroundColor(webViewModel.canGoBack ? .blue : .gray)
        }
        .disabled(!webViewModel.canGoBack)
    }
    
    private var urlText: some View {
        Group {
            if let currentURL = webViewModel.currentURL {
                Text(currentURL.absoluteString)
                    .lineLimit(1)
                    .truncationMode(.middle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        scrapeURL(currentURL)
                    }
            } else {
                Text("Loading...")
                    .foregroundColor(.gray)
            }
        }
    }
    
    private func scrapeURL(_ url: URL) {
        guard let html = try? String(contentsOf: url) else { return }
        do {
            let document = try SwiftSoup.parse(html)
            let tables = try document.select("table")
            var tableData: [String] = []
            
            for table in tables {
                let rows = try table.select("tr")
                for row in rows {
                    let columns = try row.select("td").map { try $0.text() }
                    tableData.append(columns.joined(separator: ", "))
                }
            }
            scrapedData = tableData
            isScrapingActive = true
        } catch {
            print("Error during scraping: \(error)")
        }
    }
}

#Preview {
    RaceInfoView()
}
