//
//  LanguageManager.swift
//  FXRecipes
//
//  Created by 湘 zhou on 2021/3/19.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation
enum Language: String {
    /// 请注意, 这个命名不是随意的, 是根据你本地的语言包,可以show in finder 看到. en.lproj / zh-Hans.lproj
    case Chinese = "zh-Hans"
    case English = "en"
}


class FXLanguageManager {
    
    private static let userDefaultsKey = "current_language"
    /// 判断手机语言是不是中文
    static func localeIsChinese() -> Bool {
        if let lang = Locale.preferredLanguages.first {
            return lang.hasPrefix("zh") ? true : false ;
        } else {
            return false
        }
    }
    
    /// 可用的语言
    public static var availableLanguages: [String] {
        Bundle.main.localizations.sorted()
    }
    var language: Language
    private init() {
        // 第一次初始语言, 看手机是什么语言
        language = FXLanguageManager.localeIsChinese() ? .Chinese : .English
    }
}
