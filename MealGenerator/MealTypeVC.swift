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
    
    private let lightBlue = UIColor(red: 213.0/255.0, green: 230.0/255.0, blue: 253/255.0, alpha: 1)
    
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
    
    @IBOutlet var mealTypeButtons: [UIButton]!
    
    // Meal Time Button Outlets
    @IBOutlet var breakfastButton: UIButton!
    @IBOutlet var lunchButton: UIButton!
    @IBOutlet var dinnerButton: UIButton!
    @IBOutlet var snackButton: UIButton!
    
    @IBOutlet var mealTimeButtons: [UIButton]!
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        buttonBarButtons = [mealTypeButton, mealTimeButton]
        mealTypeButtons = [meatButton, vegetarianButton, veganButton, randomType]
        for button in mealTypeButtons {
            button.backgroundColor = UIColor.clear
        }
        mealTimeButtons = [breakfastButton, lunchButton, dinnerButton, snackButton]
        
        // Initiate first view
        mealTypeButton.isSelected = true
        
        
    }
    
    override func viewDidLoad() {
        // initialize buttons in array
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    

    
    
}

// BUTTON BAR METHODS
extension MealTypeVC {
    // This extension manages the buttons on the bottom bar of the Recipe generator
    @IBAction func mealTimeButtonTapped(_ sender: UIButton) {
        if self.mealTimeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.mealTypeView.alpha = 0
                self.mealTimeView.alpha = 1
                self.mealTimeButton.isSelected = true
            }
        }
    }
    
    
    @IBAction func mealTypeButtonTapped(_ sender: UIButton) {
        if self.mealTypeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.mealTimeView.alpha = 0
                self.mealTypeView.alpha = 1
                self.mealTypeButton.isSelected = true
            }
        }
    }
    
    func unselect_buttonBarButtons(){
        for button in self.buttonBarButtons {
            button.isSelected = false
        }
    }
    
}

// MEAL TYPE METHODS
extension MealTypeVC {
    // This extension manages the buttons on the Meal Type Chooser
    @IBAction func meatButtonTapped(_ sender: UIButton) {
        unselect_mealTypeButtons()
        if meatButton.isSelected {
            unselect_mealTypeButtons()
            meatButton.isSelected = false
        }
        else {
            meatButton.tintColor = lightBlue
            meatButton.isSelected = true
        }
        
    }
    
    @IBAction func vegetarianButtonTapped(_ sender: UIButton) {
        unselect_mealTypeButtons()
        if vegetarianButton.isSelected {
            unselect_mealTypeButtons()
            vegetarianButton.isSelected = false
        }
        else {
            vegetarianButton.tintColor = lightBlue
            vegetarianButton.isSelected = true
        }
    }
    
    @IBAction func veganButtonTapped(_ sender: UIButton) {
        unselect_mealTypeButtons()
        if veganButton.isSelected {
            unselect_mealTypeButtons()
            veganButton.isSelected = false
        }
        else {
            veganButton.tintColor = lightBlue
            veganButton.isSelected = true
        }
    }
    
    @IBAction func randomTypeButtonTapped(_ sender: UIButton) {
        unselect_mealTypeButtons()
        if randomType.isSelected {
            unselect_mealTypeButtons()
            randomType.isSelected = false
        }
        else {
            randomType.tintColor = lightBlue
            randomType.isSelected = true
        }
        
    }
    
    private func unselect_mealTypeButtons() {
        for button in mealTypeButtons {
            button.tintColor = UIColor.systemBlue
        }
    }
    
    
}

// MEAL TIME METHODS
extension MealTypeVC {
    // This extensions manages the buttons on the Meal Time Chooser
    @IBAction func breakfastButtonTapped(_ sender: UIButton) {
        unselect_mealTimeButtons()
        if breakfastButton.isSelected {
            unselect_mealTimeButtons()
            breakfastButton.isSelected = false
        }
        else {
            breakfastButton.tintColor = lightBlue
            breakfastButton.isSelected = true
        }
    }
    
    @IBAction func lunchButtonTapped(_ sender: UIButton) {
        unselect_mealTimeButtons()
        if lunchButton.isSelected {
            unselect_mealTimeButtons()
            lunchButton.isSelected = false
        }
        else {
            lunchButton.tintColor = lightBlue
            lunchButton.isSelected = true
        }
    }
    
    @IBAction func dinnerButtonTapped(_ sender: UIButton) {
        unselect_mealTimeButtons()
        if dinnerButton.isSelected {
            unselect_mealTimeButtons()
            dinnerButton.isSelected = false
        }
        else {
            dinnerButton.tintColor = lightBlue
            dinnerButton.isSelected = true
        }
    }
    
    @IBAction func snackButtonTapped(_ sender: UIButton) {
        unselect_mealTimeButtons()
        if snackButton.isSelected {
            unselect_mealTimeButtons()
            snackButton.isSelected = false
        }
        else {
            snackButton.tintColor = lightBlue
            snackButton.isSelected = true
        }
    }
    
    private func unselect_mealTimeButtons() {
        for button in mealTimeButtons {
            button.tintColor = UIColor.systemBlue
        }
    }
   
    
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

