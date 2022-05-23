//
//  HIMUser.swift
//  FXIM
//
//  Created by 黄福鑫 on 2022/5/17.
//

import Foundation
import WCDBSwift

class HIMUser: TableCodable {
    var userId: String = ""
    var faceUrl: String? = nil
    var nickName: String? = nil
   
    enum CodingKeys: String, CodingTableKey {
        typealias Root = HIMUser
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case userId = "user_id"
        case faceUrl = "face_url"
        case nickName = "nack_name"
    }
    
    static var columnConstraintBindings: [CodingKeys: ColumnConstraintBinding]? {
        return [
            .userId: ColumnConstraintBinding(isPrimary: true)
        ]
    }
}
