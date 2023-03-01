//
//  WebService.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

enum WebService {
    
    //construir a URL:
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case loginUser = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unAuthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private static func completeUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        return URLRequest(url: url)
    }
    
    private static func requestCall(
        path: String,
        method: Method,
        contentType: ContentType,
        data: Data?,
        completion: @escaping (Result) -> Void
    ) {
        // 1. criar uma URL que irá esperar os valores do JSON
        guard var urlRequest = completeUrl(path: path) else { return }
        
        //Adicionar o authorization caso exista
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                //definir as propriedades para a CHAMADA da URL
                //REQUEST
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data //formato FormData: chave=valor&chave=valor
                
                // 2. Conectar com o servidor para ter uma resposta de volta (RESPONSE)
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
        //            print(String(data: data, encoding: .utf8))

                    if let response = response as? HTTPURLResponse {
        //                print(response)
                        switch response.statusCode {
                        case 200:
                            completion(.success(data))
                        case 400:
                            completion(.failure(.badRequest, data))
                        case 401:
                            completion(.failure(.unAuthorized, data))
                        default:
                            break
                        }
                    }
                }.resume()
            }
    }
    
    public static func requestCall_JSON_ReadOwnHabits(
        path: Endpoint,
        method: Method = .get,
        completion: @escaping ((Result) -> Void)
    ) {
        requestCall(
            path: path.rawValue,
            method: method,
            contentType: .json,
            data: nil,
            completion: completion)
    }
    
    public static func requestCall_JSON<T: Encodable>(
        path: String,
        method: Method = .get,
        body: T,
        completion: @escaping ((Result) -> Void)
    ) {
        // 0. Criar um objeto JSON
        //abrir uma requisição e enviar os valores dos par6ametros, e esperar um valor
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        requestCall(
            path: path,
            method: method,
            contentType: .json,
            data: jsonData,
            completion: completion)
    }
    
    public static func requestCall_JSON<T: Encodable>(
        path: Endpoint,
        method: Method = .get,
        body: T,
        completion: @escaping ((Result) -> Void)
    ) {
        // 0. Criar um objeto JSON
        //abrir uma requisição e enviar os valores dos par6ametros, e esperar um valor
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        requestCall(
            path: path.rawValue,
            method: method,
            contentType: .json,
            data: jsonData,
            completion: completion)
    }
    
    public static func requestCall_FormData(
        path: Endpoint,
        method: Method = .post,
        params: [URLQueryItem],
        completion: @escaping ((Result) -> Void)
    ) {
        
        guard let urlRequest = completeUrl(path: path.rawValue) else { return }
        guard let absoluteUrl = urlRequest.url?.absoluteString else { return }
        
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
                
        requestCall(
            path: path.rawValue,
            method: method,
            contentType: .formUrl,
            data: components?.query?.data(using: .utf8),
            completion: completion)
    }
}
