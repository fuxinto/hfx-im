//
//  HUIChatView.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import SwiftUI

struct HUIChatView: View {
    @State
    var session:HUISession

    @State
    var text = ""
    var body: some View {
        ScrollViewReader { scrollView in
          VStack(spacing: 0) {
              HUIChatList()
              HUIInputView(text: $text, onSubmit: {
                  self.text = ""
              })
          }
          .listRowInsets(.zero)
          .onTapGesture {
              UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
          }
        }
    }
}


struct HUIChatView_Previews: PreviewProvider {
    static var previews: some View {
        HUIChatView(session: HUISession())
    }
}
