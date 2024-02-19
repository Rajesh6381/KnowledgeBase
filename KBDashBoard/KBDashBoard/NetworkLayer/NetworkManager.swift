//
//  DataManager.swift
//  KBDashBoard
//
//  Created by Rajesh R on 12/02/24.
//

protocol NetworkDataManager{
    func request<T: Codable>(endPoint: EndPoint,modalType: T.Type,presenter:@escaping (T?) -> Void )
}

import Foundation

class NetworkManager: NetworkDataManager{
   
    
    // Instance of the dataManager
    static let shared =  NetworkManager()
    
    // To fetch data
    func request<T: Codable>(endPoint: EndPoint ,modalType: T.Type,presenter: @escaping (T?)->Void){
        
        guard let url =  endPoint.makeUrl() else{
            print(NetworkError.UnableGenerateURL)
            return
        }
        
        let res = URLSession.shared.fetchData(at: url,modalType: modalType){ result -> T? in
            var data: T?
                switch result{
                case .success(let modal):
                    data = modal
                    presenter(data)
                    print(Response.Success.rawValue)
                    
                case .failure(let error):
                    print(error)
                    print(Response.Failure.rawValue)
                    
                }
                return data
            }
    }
}


extension URLSession{
    
    func fetchData<T: Codable>(at url: URL,modalType: T.Type ,completion: @escaping (Result<T,Error>) -> T?) -> T?{
        print(url)
        var result: T?
             self.dataTask(with: url){ data, response, error in
                
                if data != nil && error == nil{
                    do{
                        let fetchinData = try  JSONDecoder().decode(modalType, from: data!)
                        DispatchQueue.main.async{
                          result = completion(.success(fetchinData))
                        }
                    }catch{
                       completion(.failure(error))
                    }
                }
            }.resume()
    
        return result
    }
}
