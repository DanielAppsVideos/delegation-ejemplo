//
//  DataService.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 11/08/21.
//

import Foundation

class DataService {
    static let instance: DataService = DataService()

    
    func getQuestions(numberOfLevels: Int, onCompletion: @escaping CallBackBlock<Questions>, onError: ErrorBlock?){
        
        let urlString = "https://opentdb.com/api.php?amount=\(numberOfLevels)&category=18&difficulty=easy&type=multiple"
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, error == nil {
                do{
                    let decodeData: Questions = try JSONDecoder().decode(Questions.self, from: data)
                    DispatchQueue.main.async {
                        onCompletion(decodeData)
                        
                    }
                    
                    
                }catch{
                    onError?(error)
                }
            }else{
                onError?(error!)
            }
        }
        task.resume()
    }
}
