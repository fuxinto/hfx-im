//
//  HUIChatRow.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import SwiftUI

struct HUIChatRow: View {
    @State
    var message:HUIMessage
    var body: some View {
        HStack(spacing: 8) {
            outgoingSendingIndicator
            HStack(alignment: .top, spacing: 8) {
                incomingAvatar
                messageContent
                outgoingAvatar
            }
        }
        .listRowBackground(Color.app_bg)
        .transition(.move(edge: .bottom))
    }
}
private extension HUIChatRow {
    @ViewBuilder
    var outgoingSendingIndicator: some View {
        if message.direction == .outgoing {
            Spacer(minLength: Constant.spacingOfContentMaxWidthToEdge)
            sendingIndicator
        }
    }
    var sendingIndicator: some View {
        Group {
            if message.direction == .outgoing && message.elemType == .text {
                ActivityIndicator()
            } else {
                Color.clear
            }
        }
        // 让 ActivityIndicator 消失后仍然占据位置，防止 text 的大小发生改变
        .frame(width: Constant.sendingIndicatorWidth)
    }
    
    
    @ViewBuilder
    var outgoingAvatar: some View {
        if message.direction == .outgoing {
          Image("avatar")
              .resizable().aspectRatio(contentMode: .fill)
              .frame(width: Constant.avatarSize.width, height: Constant.avatarSize.height,alignment: .center)
              .cornerRadius(Constant.avatarCornerRadius)
      } else {
        Spacer(minLength: Constant.spacingOfContentMaxWidthToEdge)
      }
    }
    
    @ViewBuilder
    var incomingAvatar: some View {
        if message.direction == .incoming {
            Image("avatar")
                .resizable().aspectRatio(contentMode: .fill)
                .frame(width: Constant.avatarSize.width, height: Constant.avatarSize.height,alignment: .center)
                .cornerRadius(Constant.avatarCornerRadius)
        }
    }
    
    @ViewBuilder
    var messageContent: some View {
        switch message.elemType{
        case .text:
            HUIMessageText(message: $message)
        default:
            HUIMessageText(message: $message)
        }
    }
}

private extension HUIChatRow {
    enum Constant {
        static let spacingOfContentMaxWidthToEdge: CGFloat = 30
        static let sendingIndicatorWidth: CGFloat = 20
        
        static let avatarSize: CGSize = .init(width: 40, height: 40)
        static let avatarCornerRadius: CGFloat = 4
    }
}

struct HUIChatRow_Previews: PreviewProvider {
    static var previews: some View {
        
        HUIChatRow(message: HUIMessage.test())
    }
}
