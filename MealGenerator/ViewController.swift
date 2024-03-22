//
//  ViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import UIKit

class ViewController: UIViewController {
    
    var gptInput:String!
    
    @IBOutlet var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        gptInput = testButton.currentTitle
        GPTManager.shared.fetchGPTResponse(prompt: gptInput) { response in
                    DispatchQueue.main.async {
                        // Stelle sicher, dass du UI-Updates auf dem Hauptthread durchführst
                        if let response = response {
                            print("GPT-Antwort: \(response)")
                            // Verarbeite die Antwort oder aktualisiere deine UI entsprechend
                        } else {
                            print("Es gab ein Problem bei der Anfrage.")
                        }
                    }
                }
    }
    
    
    

}

