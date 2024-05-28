//
//  APIEndPointType.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import Foundation
import Alamofire

protocol APIEndPointType {
    
    // MARK: - Variables

    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var apiUrlStr: String { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}

enum ApiTypeConfiguration {
    case getUserPost
    case other
}
