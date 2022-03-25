//
//  FXRouter.swift
//  FXRecipes
//
//  Created by hfx on 2021/4/21.
//  Copyright © 2021 黄福鑫. All rights reserved.
//

import Foundation
protocol FXRouterProtocol {
    static func targetWith(pa: [String: Any]) -> FXRouterProtocol?
    func needLogin() -> Bool
}


extension FXRouterProtocol {
    func needLogin() -> Bool {
        return false
    }
}
