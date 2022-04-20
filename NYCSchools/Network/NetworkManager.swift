//
//  NetworkManager.swift
//  NYCSchools
//

import Foundation

struct NetworkManager {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> ()) {
        
        print("URL = \(url.absoluteURL)")
        
        let urlRequest = URLRequest(url: url)
            
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                print("Error = \(String(describing: error))")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error in Response")
                completion(nil)
                return
            }
            
            print("Response Status Code = \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("Error in data")
                completion(nil)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(json)
            } catch(let error) {
                print("Error = \(error)")
            }
        }
        
        task.resume()
    }
}
