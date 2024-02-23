//
//  ServiceHelper.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import Moya

struct ServiceHelper {
    static let errorServiceDomain = "com.vmodev.error.service"
    static let errorMoyaDomain = "Moya.MoyaError"
    static let errorCodeUnauthenticated = 401
    static let errorCodeUnauthorized = 403
    static let errorCodeGatewayTimeOut = 504
}

struct ErrorClient: Error {
    var errorCode: String
    var message: String
    var status: Int
    var listMessage: [MessageError]?
    var expiredWebToken: ExpiredWebToken?
    var errors: JSON?
}

struct ExpiredWebToken {
    var error: [String?]?
    
    init(json: JSON) {
        if let array = json["error"].array {
            error = array.map { $0.string }
        }
    }
}

struct MessageError {
    var property: String?
    var error: String?
    
    init(json: JSON) {
        property = json["property"].string
        error = json["error"].string
    }
}

extension NSError {
    
    var isUnauthenticated: Bool {
        return self.code == ServiceHelper.errorCodeUnauthenticated
    }
    
    var isUnauthorized: Bool {
        return self.code == ServiceHelper.errorCodeUnauthorized
    }
    
    var isGatewayTimeOut: Bool {
        return self.code == ServiceHelper.errorCodeGatewayTimeOut
    }
    
    var isMoyaError: Bool {
        return self.domain == ServiceHelper.errorMoyaDomain
    }
}

extension Moya.Response {
    
    var isSuccess: Bool {
        return statusCode / 100 == 2
    }
    
    var isUnauthenticated: Bool {
        return statusCode == ServiceHelper.errorCodeUnauthenticated
    }
    
    var isUnauthorized: Bool {
        return statusCode == ServiceHelper.errorCodeUnauthorized
    }
    
    var isGatewayTimeOut: Bool {
        return statusCode == ServiceHelper.errorCodeGatewayTimeOut
    }
}
