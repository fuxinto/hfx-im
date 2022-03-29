import SwiftUI

enum TabBarItem: Int {
  case session
  case contacts
  case discover
  case me

  var title: String {
    switch self {
    case .session:
        return "聊天"
//      return Strings.tabbar_chats()
    case .contacts:
      return "通讯录"
    case .discover:
      return "发现"
    case .me:
      return "我的"
    }
  }

  var defaultImage: Image {
    let name: String
    switch self {
    case .session:
      name = "icons_outlined_chats"
    case .contacts:
      name = "icons_outlined_contacts"
    case .discover:
      name = "icons_outlined_discover"
    case .me:
      name = "icons_outlined_me"
    }
    return Image(name)
  }

  var selectedImage: Image {
    let name: String
    switch self {
    case .session:
      name = "icons_filled_chats"
    case .contacts:
      name = "icons_filled_contacts"
    case .discover:
      name = "icons_filled_discover"
    case .me:
      name = "icons_filled_me"
    }
    return Image(name)
  }
}
