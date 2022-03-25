//
//  ContentView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/2.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView{
            NavigationView{
                FXLoginView()
                    .navigationTitle("会话").navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
