//
//  FXTabView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/22.
//

import SwiftUI

struct FXTabView: View {
    @State var selectedTab = 0
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                HUISessionView()
                .tabItem { tabItem(for: .session) }
                .tag(TabBarItem.session.rawValue)
                HUIContactsView()
                .tabItem { tabItem(for: .contacts) }
                .tag(TabBarItem.contacts.rawValue)
    //
    //          DiscoverView()
    //            .tabItem { tabItem(for: .discover) }
    //            .tag(TabBarItem.discover.rawValue)
    //
    //          MeView()
    //            .tabItem { tabItem(for: .me) }
    //            .tag(TabBarItem.me.rawValue)
            }
            .accentColor(.highlighted) // 设置 tab bar 选中颜色
        }
        
    }
    
    private func tabItem(for tab: TabBarItem) -> some View {
      VStack {
          tab.rawValue == $selectedTab.wrappedValue ? tab.selectedImage : tab.defaultImage
        Text(tab.title)
      }
    }
}

struct FXTabView_Previews: PreviewProvider {
    static var previews: some View {
        FXTabView()
    }
}
