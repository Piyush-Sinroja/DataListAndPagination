//
//  ApiTypeConfiguration+Extension.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import Foundation
import Alamofire

extension ApiTypeConfiguration: APIEndPointType {

    // MARK: - Vars & Lets

    var baseURL: String {
        return Constant.API.baseURL
    }
    
    var apiUrlStr: String {
        return "\(baseURL)\(path)"
    }
    
    var version: String {
        ""
    }
    
    var path: String {
        switch self {
            case .getUserPost:
                return "/posts"
        default:
            return ""
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
            case .getUserPost:
                return .get
            default:
                return .get
        }
    }

    var headers: HTTPHeaders? {
        return [
            "Content-Type": "application/json"
        ]
    }

    var encoding: ParameterEncoding {
        switch self {
            case .getUserPost:
                return URLEncoding.default
            default:
                return JSONEncoding.default
        }
    }
}

