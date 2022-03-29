//
//  HUIConversationView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/23.
//

import SwiftUI


class HUISessionListViewModel:ObservableObject{
    @Published
    var sessions = [HUISession(),HUISession()]
}
struct HUISessionView: View {
    @StateObject
    var sessionListViewModel = HUISessionListViewModel()
    var body: some View {
        List {
            ForEach(sessionListViewModel.sessions) { session in
                
                NavigationRow(destination: HUIChatView.init(session: session)) {
                    HUISessionRow.init(session: session)
                }
                .listRowSeparator(.hidden)
            }
            .listRowInsets(.zero)
        }
        .listStyle(.plain)
    }
}

struct HUIConversationView_Previews: PreviewProvider {
    static var previews: some View {
        
        HUISessionView()
    }
}
