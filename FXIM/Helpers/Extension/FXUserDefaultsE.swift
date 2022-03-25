//
//  File.swift
//  医药项目
//
//  Created by fuxinto on 2019/12/18.
//  Copyright © 2019 fuxinto. All rights reserved.
//

import Foundation





extension FXNamespaceWrapper where Base : UserDefaults{
    static func clearAll(){
       let userDefaults = UserDefaults.standard
       let dics = userDefaults.dictionaryRepresentation()
       for key in dics {
           userDefaults.removeObject(forKey: key.key)
       }
       userDefaults.synchronize()
    }
}
