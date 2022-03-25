//
//  FXIMApp.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/2.
//

import SwiftUI

@main
struct FXIMApp: App {
    let persistenceController = PersistenceController.shared
    @ObservedObject var app = FXIMAppManager.share
    var body: some Scene {
        WindowGroup {
            rootView
//                .environment(\.managedObjectContext, persistenceController.privateContext)
        }
    }
    @ViewBuilder
    var rootView: some View {
      if app.isLogin {
          FXTabView()
      } else {
          FXLoginView()
      }
    }
}
