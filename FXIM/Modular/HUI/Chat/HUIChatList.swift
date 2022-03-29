//
//  HUIChatList.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import SwiftUI
class HUIChatViewModel:ObservableObject{
    @Published
    private(set) var messages = [HUIMessage]()
    init(){
        messages = HUIMessage.tests()
    }
}
struct HUIChatList: View {
    @StateObject
    var viewModel = HUIChatViewModel()
    var body: some View {
        List{
            ForEach(viewModel.messages){message in
                HUIChatRow(message: message)
                    .listRowInsets(Constant.listRowInset)
                    .listRowSeparator(.hidden)
            }
                
        }
        .listStyle(.plain)
        .background(.app_bg)

    }
}

private extension HUIChatList {
  enum Constant {
    static let listRowInset: EdgeInsets = .init(top: 8, leading: 12, bottom: 8, trailing: 12)
  }
}

struct HUIChatList_Previews: PreviewProvider {
    static var previews: some View {
        HUIChatList()
    }
}
