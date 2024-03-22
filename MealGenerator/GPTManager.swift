//
//  Gpt.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import Foundation


class GPTManager {
    
    static let shared = GPTManager()
    
    private init() {}
    
    func fetchGPTResponse(prompt: String, completion: @escaping (String?) -> Void) {
        let apiKey = "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"
        let url = URL(string: "https://api.openai.com/v1/engines/davinci/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody:[String:Any] = [
            "prompt": prompt,
            "max_tokens": 100
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                let responseString = String(data: data, encoding: .utf8)
                completion(responseString)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}

