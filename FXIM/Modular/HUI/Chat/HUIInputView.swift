//
//  HUIInputBar.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/3/29.
//

import SwiftUI

struct HUIInputView: View {
    @Binding
    var text:String
    
    let onSubmit: () -> Void
    var body: some View {
        VStack(spacing: 0){
            Color.bg_info_300
              .frame(height: Constant.topLineHeight)
            HStack(alignment: .center, spacing: Constant.toolBarPadding) {
                Button {
                    
                } label: {
                    Image(systemName: "wave.3.right.circle")
                        .inputToolBarButtonStyle()
                        
                }
                
                TextField("", text: $text)
                .submitLabel(.send)
                .textFieldStyle(.roundedBorder)
                .onSubmit(onSubmit)
           
                Button {
                    
                } label: {
                    Image(systemName: "line.3.horizontal.circle")
                        .inputToolBarButtonStyle()
                        
                }
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .inputToolBarButtonStyle()
                        
                }
            }
            .foregroundColor(.text_primary)
            .padding(Constant.toolBarPadding)
            .background(.bg_info_150)
        }
    }
}
private extension Image {
  func inputToolBarButtonStyle() -> some View {
    typealias Constant = HUIInputView.Constant
    let size = CGSize(
      width: Constant.toolBarButtonWidth,
      height: Constant.toolBarButtonWidth
    )
    let padding = (Constant.toolBarHeight - Constant.toolBarButtonWidth) * 0.5
      return resizable().aspectRatio(contentMode: .fill)
          .foregroundColor(.black)
          .frame(width: size.width, height: size.height)
      .padding(.vertical, padding)
  }
}


// MARK: - Constant
private extension HUIInputView {
  enum Constant {
      static let topLineHeight: CGFloat = 0.8
      static let toolBarHeight:CGFloat = 48
      static let toolBarPadding: CGFloat = 9
      static let toolBarButtonWidth: CGFloat = 30
      static let textEditorInsets: EdgeInsets = .init(top: 8, leading: 5, bottom: 8, trailing: 5)
      static let textFont: UIFont = .systemFont(ofSize: 16)
  }
}
struct HUIInputBar_Previews: PreviewProvider {
    static var previews: some View {
        HUIInputView(text: .constant("12332"),onSubmit: {
            
        })
    }
}
