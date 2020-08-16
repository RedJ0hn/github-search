//
//  Request.swift
//  Github search
//
//  Created by Niec, Mateusz on 15/08/2020.
//  Copyright © 2020 Niec, Mateusz. All rights reserved.
//

import Foundation
import Alamofire

class Request {
    
    private static var alamofireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60
        configuration.timeoutIntervalForRequest = 60
        return Session(configuration: configuration)
    }()
    
    static func perform(_ address: String, method: HTTPMethod, params: Parameters? = nil, successBlock: @escaping (Data?) -> (), failtureBlock: @escaping (Error) -> ()) {
        alamofireManager.request(address, method: method, parameters: params).validate().response { (response) in
            switch response.result {
            case .success(let value):
                successBlock(value)
            case .failure(let error):
                failtureBlock(error)
            }
        }
    }
    
}
