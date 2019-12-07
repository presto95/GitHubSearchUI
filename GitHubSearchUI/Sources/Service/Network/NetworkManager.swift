//
//  NetworkManager.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/04.
//  Copyright © 2019 presto. All rights reserved.
//

import Alamofire

protocol NetworkManagerProtocol {
  func request(_ target: TargetProtocol) -> DataRequest
}

final class NetworkManager: NetworkManagerProtocol {
  func request(_ target: TargetProtocol) -> DataRequest {
    let dataRequest = Alamofire
      .request(target.url,
               method: target.method,
               parameters: target.parameters,
               encoding: URLEncoding.default,
               headers: nil)
    return dataRequest
  }
}

extension DataRequest {
  func response<Decode: Decodable>(to type: Decode.Type, completion: @escaping (DataResponse<Decode>) -> Void) {
    responseData { response in
      let decodedResult = response.result.map { try! JSONDecoder().decode(type, from: $0) }
      completion(DataResponse(request: response.request, response: response.response, data: response.data, result: decodedResult))
    }
  }
}
