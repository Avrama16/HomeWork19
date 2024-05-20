//
//  ViewController.swift
//  HomeWork19
//
//  Created by A-Avramenko on 24.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getButton(_ sender: Any) {
        
        let urlString = "https://reqres.in/api/unknown"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let responseError = error {
                debugPrint(error?.localizedDescription)
            } else {
                debugPrint("")
                
                guard let responseData = data else { return }
                
                do {
                    let result = try JSONDecoder().decode(ListResource.self, from: responseData)
                    debugPrint(result)
                } catch let (parseError) {
                    debugPrint(parseError.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}

struct ListResource: Decodable {
    let page: Int
    let per_page: Int
    let total: Int
    let total_pages: Int
    let data: [ColorData]
    
    struct ColorData: Decodable {
        let id: Int
        let name: String
        let year: Int
        let color: String
        let pantone_value: String
    }
}

