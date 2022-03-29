//
//  HUIMessageText.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import SwiftUI

struct HUIMessageText: View {
    @Binding
    var message:HUIMessage
    var body: some View {
        HStack(alignment: .top, spacing: -Constant.textBackgroundArrowOverlapWidth) {
            if message.direction == .incoming {
            textBackgroundArrow
          }

            Text(message.textMessage!.content)
            .font(Font(Constant.textFont as CTFont))
            .foregroundColor(textForegroundColor)
            .padding(Constant.textInsets)
            .background(textBackgroundColor)
            .cornerRadius(Constant.textBackgroundCornerRadius)

          if message.direction == .outgoing {
            textBackgroundArrow
          }
        }
    }
}

private extension HUIMessageText {

  var textBackgroundArrow: some View {
    VStack(alignment: .center) {
      Path { path in
        path.addRoundedRect(
          in: .init(
            x: 0,
            y: 0,
            width: Constant.textBackgroundArrowWidth,
            height: Constant.textBackgroundArrowWidth
          ),
          cornerSize: .init(width: 1, height: 1)
        )
      }
      .frame(
        width: Constant.textBackgroundArrowWidth,
        height: Constant.textBackgroundArrowWidth
      )
      .foregroundColor(textBackgroundColor)
      .rotationEffect(.init(degrees: 45))
    }
    .frame(
      width: Constant.textBackgroundArrowContainerWidth,
      height: Constant.textBackgroundArrowContainerHeight
    )
  }

  var textForegroundColor: Color {
      message.direction == .outgoing ? Color.text_chat_outgoing_msg : Color.text_chat_incoming_msg
  }

  var textBackgroundColor: Color {
      message.direction == .outgoing ? Color.bg_chat_outgoing_msg : Color.bg_chat_incoming_msg
  }
}

private extension HUIMessageText {
  enum Constant {
    static let textFont: UIFont = .systemFont(ofSize: 16)
    static let textInsets: EdgeInsets = .init(top: 10, leading: 12, bottom: 10, trailing: 12)
    static let textBackgroundCornerRadius: CGFloat = 4

    static let textBackgroundArrowWidth: CGFloat = 10
    static let textBackgroundArrowOverlapWidth: CGFloat = sqrt((pow(textBackgroundArrowWidth, 2)) * 2) / 2

    static let textBackgroundArrowContainerWidth = textBackgroundArrowOverlapWidth * 2
    static let textBackgroundArrowContainerHeight = textFont.lineHeight + textInsets.top + textInsets.bottom
  }
}
struct HUIMessageText_Previews: PreviewProvider {
    static var previews: some View {

        HUIMessageText(message:.constant(HUIMessage.test()))
        
    }
    
}
