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
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        return URLRequest(url: url)
    }
    
    private static func requestCall(
        path: Endpoint,
        contentType: ContentType,
        data: Data?,
        completion: @escaping (Result) -> Void
    ) {
        // 1. criar uma URL que irá esperar os valores do JSON
        guard var urlRequest = completeUrl(path: path) else { return }
        //definir as propriedades para a CHAMADA da URL
        //REQUEST
        urlRequest.httpMethod = "POST"
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
    
    public static func requestCall_JSON<T: Encodable>(
        path: Endpoint,
        body: T,
        completion: @escaping ((Result) -> Void)
    ) {
        // 0. Criar um objeto JSON
        //abrir uma requisição e enviar os valores dos par6ametros, e esperar um valor
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        requestCall(
            path: path,
            contentType: .json,
            data: jsonData,
            completion: completion)
    }
    
    public static func requestCall_FormatData(
        path: Endpoint,
        params: [URLQueryItem],
        completion: @escaping ((Result) -> Void)
    ) {
        
        guard let urlRequest = completeUrl(path: path) else { return }
        guard let absoluteUrl = urlRequest.url?.absoluteString else { return }
        
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
                
        requestCall(
            path: path,
            contentType: .formUrl,
            data: components?.query?.data(using: .utf8),
            completion: completion)
    }
    
    static func registerUser(request: SignUpRequest, completion: @escaping (Bool?, ErrorResponse?) -> Void) {
        requestCall_JSON(path: .postUser, body: request) { result in
            //Result é o resultado da Data (JSON) ou do Erro do servidor, que preciso Decodar
            switch result {
            case .success(let data):
//                print(String(data: data, encoding: .utf8))
                completion(true, nil)
            case .failure(_, let data):
                if let data = data {
//                    print(String(data: data, encoding: .utf8))
                    let response = try? JSONDecoder().decode(ErrorResponse.self, from: data)
                    //delegar essa response para a ViewModel
                    completion(nil, response)
                }
            }
        }
        
    }
    
    static func loginUser(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
                

    }
}
