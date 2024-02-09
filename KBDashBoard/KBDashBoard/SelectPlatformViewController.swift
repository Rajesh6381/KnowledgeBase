//
//  ViewController.swift
//  KBDashBoard
//
//  Created by zoho on 09/02/24.
//

import UIKit

class SelectPlatformViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://desk.zoho.com/portal/api/kbRootCategories?hasArticles=true&locale=en&include=articlesCount%2CsectionsCount&portalId="+KBIdentifier.TestIdentifier.rawValue)!
        URLSession.shared.fetchData(at: url){ result in
            print(result)
        }
    }
}


extension URLSession{
    func fetchData(at url: URL, completion: @escaping (Result<KBModal,Error>) -> Void){
        self.dataTask(with: url){data, response, error in
            if data != nil && error == nil{
                do{
                    let fetchinData = try JSONDecoder().decode(KBModal.self, from: data!)
                    completion(.success(fetchinData))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

