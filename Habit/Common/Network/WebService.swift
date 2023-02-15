//
//  WebService.swift
//  Habit
//
//  Created by Jean Ricardo Cesca on 15/02/23.
//

import Foundation

enum WebService {
    
    /*
    {
      "name": "jean30",
      "email": "jean30@gmail.com",
      "document": "12345678910",
      "phone": "11993938998",
      "gender": 0,
      "birthday": "2013-02-14",
      "password": "12345678"
    }
     */
    
    //construir a URL:
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        return URLRequest(url: url)
    }
    
    static func postUser(request: SignUpRequest) {
        
        // 0. Criar um objeto JSON
        //abrir uma requisição e enviar os valores dos par6ametros, e esperar um valor
        guard let jsonData = try? JSONEncoder().encode(request) else { return }
        
        // 1. criar uma URL que irá esperar os valores do JSON
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        //definir as propriedades para a CHAMADA da URL
        //REQUEST
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        // 2. Conectar com o servidor para ter uma resposta de volta (RESPONSE)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            //Decodificar o JSON (que está em Data)
            print(String(data: data, encoding: .utf8))
            print("response\n")
            print(response)
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
        }.resume()
    }
    
    
    
}
