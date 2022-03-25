//
//  ServerConfig.swift
//  FXSwift
//
//  Created by 王聪 on 2020/11/18.
//

import Foundation

// MARK: - Moya
// 定义基础域名
var Moya_baseURL :String {
    #if DEBUG
    return baseUrl
    #endif
    return baseUrl
}


let baseUrl = "http://127.0.0.1:8888/api/"


let LSImagePrefix = "http://file.mexico-test.loandm.net"


/// 定义返回的JSON数据字段
let RESULT_CODE = "code"      //状态码

let RESULT_MESSAGE = "message"  //错误消息提示

let RESULT_DATA = "data"  //错误消息提示

let NetworkErrorDefaultMsg = "网络异常或服务器错误，请稍后再试"  //请求失败默认提示

let FXAPPKey = "3.1415926LoanMarketMexico&LoanCloud"
let FXAES_Key = "3.1415926LoanMar"

let FXRSA_Private = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJ1Ir4vND4VvhkOV\n" +
"+UV/a0E79PMuroDAijDmQ5RUMFo37eGJlaZ7Qro45yZofBSfSwhJZc76rZotBqtV\n" +
"cLGK3kEWfK6IjC5KAervutaGsChOMFGqjZnlwxpLSqrrkUQyKlUVCEhzSaGqzfdr\n" +
"81sl1qMTrX413p+AVh6Y1ebMjMSFAgMBAAECgYAQyZhLEKkOcfffsNs5Sr9U6CRd\n" +
"7GadwW8+huVBqLa8emm+f+PkMBXQMJCjbdWIkfP9P3BJZkIvSY0Drovnt02/c99H\n" +
"yZTLJ5ztZtodcTRo3cSCw3nuANR60MecowgZt3yvMZomEX71OGiB6fpUc+WxX05d\n" +
"jAe/1I7FmYIIUXxP4QJBAM7C1k/my/RfSpO677pPpJFABpRisLMb2vpvFCabglY6\n" +
"k6YUPd1qf/pw9tlCk+auxZL3Ub16vkrEClJBWBAiWPkCQQDCvXrwavKM98B2qQt1\n" +
"GOP7sI64KOFpT/mf5JOikWEcOUqzThVbrjYGFbLJEMtpF1mRjlxmCz7Z6IRTxNYL\n" +
"sxbtAkEAh0clL0wDP5UlVzjk5pJ7SumIJIfZsqZUBKyuk4AFq+NRfUUbIQYwS6yj\n" +
"ZYzQ9gp9jGWynnVzkbloQ18rfgrrCQJACKflbARE7bEhc+TFppnJoGlTnqnqgwTU\n" +
"AqBlU4eEun1tbZTd7CpNKm4SeU9uyygHiim6v6pmS8dDAnowTWrTbQJBAJPIKiJP\n" +
"W1oVqPW1bb+ZbegZ8wU5WftLd+O3g6r2ic7aaMFiqmWqHknRKhBAmAo6VRNMi2Hn\n" +
"DAwG9wJO2zMNZgA="
