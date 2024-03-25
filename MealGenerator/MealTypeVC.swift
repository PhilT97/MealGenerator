//
//  ViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import Foundation
import OpenAIKit
import UIKit

class MealTypeVC: UIViewController {
    
    // View-Outlets in Current View Controller
    
    @IBOutlet var mealTypeView: UIView!
    @IBOutlet var mealTimeView: UIView!
    
    // Button Bar Button Outlets
    @IBOutlet var mealTypeButton: UIButton!
    @IBOutlet var mealTimeButton: UIButton!
    
    @IBOutlet var buttonBarButtons: [UIButton]!
    
    
    // Meal Type Button Outlets
    
    @IBOutlet var meatButton: UIButton!
    @IBOutlet var vegetarianButton: UIButton!
    @IBOutlet var veganButton: UIButton!
    @IBOutlet var randomType: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        buttonBarButtons = [mealTypeButton, mealTimeButton]
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.mealTypeButton.isSelected = true
        
        
    }
    

    
    
}

// BUTTON BAR METHODS
extension MealTypeVC {
    @IBAction func mealTimeButtonTapped(_ sender: UIButton) {
        if self.mealTimeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttons()
                self.mealTypeView.alpha = 0
                self.mealTimeView.alpha = 1
                self.mealTimeButton.isSelected = true
            }
        }
    }
    
    
    @IBAction func mealTypeButtonTapped(_ sender: UIButton) {
        if self.mealTypeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttons()
                self.mealTimeView.alpha = 0
                self.mealTypeView.alpha = 1
                self.mealTypeButton.isSelected = true
            }
        }
    }
    
    func unselect_buttons(){
        for button in self.buttonBarButtons {
            button.isSelected = false
        }
    }
    
}

// MEAL TYPE METHODS
extension MealTypeVC {
    
    @IBAction func meatButtonTapped(_ sender: UIButton) {
        print("YOU CHOSE MEAT")
    }
    
    @IBAction func vegetarianButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func veganButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func randomTypeButtonTapped(_ sender: UIButton) {
        
    }
    
    
}

// MEAL TIME METHODS
extension MealTypeVC {
    
}

//
//extension MealTypeViewController {
//    private func tryGpt(){
//        openAI.sendCompletion(prompt: "Hello!", model: .gptV3_5(.gptTurbo), maxTokens: 2048) { [weak self] result in
//            switch result {
//            case .success(let aiResult):
//                DispatchQueue.main.async {
//                    if let text = aiResult.choices.first?.text {
//                        print("response text: \(text)") //"\n\nHello there, how may I assist you today?"
//                    }
//                }
//            case .failure(let error):
//                DispatchQueue.main.async { [weak self] in
//                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self?.present(alert, animated: true)
//                }
//            }
//        }
//        
//    }
    
//    func startLoading() {
//            // Wenn du einen Aktivitätsindikator hast, stoppe ihn hier
//        activityIndicator.startAnimating()
//        activityIndicator.alpha = 1
//        activityIndicator.isHidden = false
//    }
    
//    private func dummyGenerator() {
//        
//    }
    
//}

