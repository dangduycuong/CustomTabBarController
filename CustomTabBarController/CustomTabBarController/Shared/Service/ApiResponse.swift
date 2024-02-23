//
//  ApiResponse.swift
//  CustomTabBarController
//
//  Created by cuongdd on 22/02/2024.
//  Copyright © 2024 Ngô Bảo Châu. All rights reserved.
//

import Foundation
import Network
import Moya

public class ApiResponse {
    let message: String?
    let error: ErrorClient?
    let data: JSON?
    init(response: Response) {
        if response.isUnauthenticated {
            let json = JSON(response.data)
            self.message = json["message"].string
            self.error = ErrorClient(
                errorCode: json["errorCode"].stringValue,
                message: json["message"].string ?? "",
                status: ServiceHelper.errorCodeUnauthenticated,
                listMessage: json["messages"].arrayValue.map({ MessageError(json: $0) }),
                expiredWebToken: ExpiredWebToken(json: json["messages"])
            )
            self.data = nil
        } else if response.isUnauthorized {
            let json = JSON(response.data)
            self.message = json["message"].string
            self.error = ErrorClient(
                errorCode: json["errorCode"].stringValue,
                message: json["message"].string ?? "",
                status: ServiceHelper.errorCodeUnauthorized,
                listMessage: json["messages"].arrayValue.map({ MessageError(json: $0) }),
                expiredWebToken: ExpiredWebToken(json: json["messages"])
            )
            self.data = nil
        } else if response.isGatewayTimeOut {
            self.message = nil
            self.error = ErrorClient(
                errorCode: "error",
                message: "network.error.request.timed.out",
                status: ServiceHelper.errorCodeGatewayTimeOut)
            self.data = nil
        } else if response.isSuccess {
            let json = JSON(response.data)
            self.message = json["message"].string
//            if (json["success"].exists() &&  json["success"].bool == true) {
//                self.error = nil
//            } else {
//                self.error = ErrorClient(
//                    errorCode: json["errorCode"].stringValue,
//                    message: json["message"].string ?? "Something went wrong!",
//                    status: response.statusCode,
//                    listMessage: json["messages"].arrayValue.map({ MessageError(json: $0) }),
//                    expiredWebToken: ExpiredWebToken(json: json["messages"])
//                )
//            }
            //comment vào vì nó k phải format như những project khác
            self.error = nil
            self.data = json
            self.parsingData(json: json)
        } else {
            let json = JSON(response.data)
            self.message = json["message"].string
            self.error = ErrorClient(
                errorCode: json["errorCode"].stringValue,
                message: json["message"].string ?? "Something went wrong!",
                status: response.statusCode,
                listMessage: json["messages"].arrayValue.map({ MessageError(json: $0) }),
                expiredWebToken: ExpiredWebToken(json: json["messages"]),
                errors: json["errors"]
            )
            self.data = nil
        }
    }
    
    init(error: Error) {
        self.message = nil
        let nsError = error as NSError
        self.error = ErrorClient(
            errorCode: nsError.domain,
            message: nsError.localizedDescription,
            status: nsError.code)
        self.data = nil
    }
    
    // Override to parsing data
    func parsingData(json: JSON) {
        
    }
}

