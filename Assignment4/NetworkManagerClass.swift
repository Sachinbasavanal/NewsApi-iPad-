//
//  NetworkManagerClass.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit
import Alamofire

class AlamofireClass{
    
    enum State{
        case loading
        case success(NewsApiModel)
    }
    
    var state:State = .loading
    var newsApiModel:NewsApiModel?
    var url = ""
    
    init(baseURL:String){
        self.url = baseURL
    }
    
    func fetchData(completion:@escaping (Bool)->Void){
        //Using Alamofire to fetch the data
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            var newState = State.loading
            var success = false
            guard let data = response.data else {return}
            do{
                let decoder = JSONDecoder()
                let result = try decoder.decode(NewsApiModel.self, from: data)
                if result.articles.isEmpty{
                    print("No results")
                }else{
                    self.newsApiModel = result
                    newState = State.success(result)
                    self.state = newState
                    success = true
                    completion(success)
                }
            }
            catch{
                print(error)
            }
        }
    }
}
