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

  func response(from request: DataRequest, completion: @escaping (Result<Data, Error>, HTTPURLResponse?) -> Void)
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

  func response(from request: DataRequest, completion: @escaping (Result<Data, Error>, HTTPURLResponse?) -> Void) {
    request.responseData { response in
      switch response.result {
      case let .success(success):
        completion(.success(success), response.response)
      case let .failure(error):
        completion(.failure(error), response.response)
      }
    }
  }
}

extension DataRequest {
  func responseDecoded<Decode: Decodable>(to type: Decode.Type, completion: @escaping (DataResponse<Decode>) -> Void) {
    responseData { response in
      let decodedResult = response.result.map { try! JSONDecoder().decode(type, from: $0) }
      completion(DataResponse(request: response.request, response: response.response, data: response.data, result: decodedResult))
    }
  }
}
