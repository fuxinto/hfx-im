//
//  HUISessionRow.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/28.
//

import SwiftUI

struct HUISessionRow: View {
    let session : HUISession
    var body: some View {
        HStack{
            Image("avatar")
                .resizable().aspectRatio(contentMode: .fill)
                .frame(width: Constant.avatarSize.width, height: Constant.avatarSize.height,alignment: .center)
                .cornerRadius(Constant.avatarCornerRadius)
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                  title
                  Spacer()
                  lastMessageTime
                }
                lastMessageText
            }
        }
        .padding(Constant.contentInset)
    }
    
    
    private var title: some View {
      Text(session.title)
        .font(.system(size: Constant.titleFontSize, weight: .regular))
//        .foregroundColor(.text_primary)
    }
    @ViewBuilder
    private var lastMessageTime: some View {
        Text(session.time)
          .font(.system(size: Constant.lastMessageTimeFontSize))
          .foregroundColor(.text_info_50)
    }

    @ViewBuilder
    private var lastMessageText: some View {
        Text(session.subTitle)
          .lineLimit(1)
          .font(.system(size: Constant.lastMessageTextFontSize))
          .foregroundColor(.text_info_80)
    }
}

// MARK: - Constant
private extension HUISessionRow {
  enum Constant {
    static let contentInset: EdgeInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
    static let avatarSize: CGSize = .init(width: 48, height: 48)
    static let avatarCornerRadius: CGFloat = 8
    static let titleFontSize: CGFloat = 16
    static let lastMessageTimeFontSize: CGFloat = 12
    static let lastMessageTextFontSize: CGFloat = 14
  }
}

struct HUISessionRow_Previews: PreviewProvider {
    static var previews: some View {
        let session = HUISession()

        HUISessionRow(session: session)
    }
}
