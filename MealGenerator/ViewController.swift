//
//  ViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import Foundation
import OpenAIKit
import UIKit

class ViewController: UIViewController {
    
    var gptInput:String!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        tryGpt()
    }
    
    

}

extension ViewController {
    private func tryGpt(){
        openAI.sendCompletion(prompt: "Hello!", model: .gptV3_5(.gptTurbo), maxTokens: 2048) { [weak self] result in
            switch result {
            case .success(let aiResult):
                DispatchQueue.main.async {
                    if let text = aiResult.choices.first?.text {
                        print("response text: \(text)") //"\n\nHello there, how may I assist you today?"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self?.present(alert, animated: true)
                }
            }
        }
        
    }
    
    func stopLoading() {
            // Wenn du einen Aktivitätsindikator hast, stoppe ihn hier
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.isHidden = false
    }
    
}

