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
    
    
    @IBOutlet var transparancyView: UIView!
    @IBOutlet var generateRecipeView: UIView!
    
    
    // Button Bar Button Outlets
    @IBOutlet var mealTypeButton: UIButton!
    @IBOutlet var mealTimeButton: UIButton!
    
    @IBOutlet var generateRecipeButton: UIButton!
    
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
    
    // Activity Indicator
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    
    
    
    @IBOutlet var generateRecipeTextView: UITextView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        generateRecipeView.layer.cornerRadius = 20
        
        buttonBarButtons = [mealTypeButton, mealTimeButton]
        mealTypeButtons = [meatButton, vegetarianButton, veganButton, randomType]
        for button in mealTypeButtons {
            button.backgroundColor = UIColor.clear
        }
        mealTimeButtons = [breakfastButton, lunchButton, dinnerButton, snackButton]
        
        // Initiate first view
        if !check_if_button_is_active() {
            self.mealTypeButton.isSelected = true
        }
        
        // Modify Pop Up Text View to be not interactable
        self.generateRecipeTextView.isEditable = false
        
        
        
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
    
    @IBAction func generateRecipeButtonTapped(_ sender: UIButton) {
        self.generateRecipeTextView.text = "Erstelle ein Rezept für ein \(mealGenerator.getCategory() ?? "zufälliges Gericht") zum/als \(mealGenerator.getMealTime() ?? "zufällige Mahlzeit")?"
        self.generateRecipeView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.generateRecipeView.alpha = 1
        UIView.animate(withDuration: 0.2) {
            self.transparancyView.alpha = 0.7
            self.generateRecipeView.transform = CGAffineTransform.identity
        }
    }
    
    
    
    func unselect_buttonBarButtons(){
        for button in self.buttonBarButtons {
            button.isSelected = false
        }
    }
    
    func check_if_button_is_active() -> Bool{
        var is_active:Bool = false
        for button in self.buttonBarButtons {
            is_active = is_active || button.isSelected
        }
        return is_active
    }
    
}

// MEAL TYPE METHODS
extension MealTypeVC {
    // This extension manages the buttons on the Meal Type Chooser
    @IBAction func meatButtonTapped(_ sender: UIButton) {
        unselect_mealTypeButtons()
        mealGenerator.setCategory(category: "Fleischgericht")
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
        mealGenerator.setCategory(category: "Vegetarisches Gericht")
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
        mealGenerator.setCategory(category: "Veganes Gericht")
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
        mealGenerator.setCategory(category: "Zufälliges Gericht")
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
        mealGenerator.setMealTime(mealTime: "Frühstück")
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
        mealGenerator.setMealTime(mealTime: "Mittagessen")
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
        mealGenerator.setMealTime(mealTime: "Abendessen")
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
        mealGenerator.setMealTime(mealTime: "Snack")
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

// GENERATE RECIPE METHODS
extension MealTypeVC {
    @IBAction func generateRecipeYesTapped (_ sender: UIButton){
        UIView.animate(withDuration: 0.2) {
            self.startActivityIndicator()
            self.tryGpt()
//            self.transparancyView.alpha = 0
//            self.generateRecipeView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
//            self.generateRecipeView.alpha = 0
        }
    }
    
    @IBAction func generateRecipeNoTapped (_ sender: UIButton){
        UIView.animate(withDuration: 0.2) {
            self.transparancyView.alpha = 0
            self.generateRecipeView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.generateRecipeView.alpha = 0
        }
        
        
    }
}

extension MealTypeVC {
    private func tryGpt(){
        let prompt = "erstelle ein Rezept für ein \(mealGenerator.getCategory() ?? "zufälliges Gericht") zum/als \(mealGenerator.getMealTime() ?? "zufällige Mahlzeit"), formattiert als swift string ohne Deklaration, Ausgabe soll nur der String Inhalt sein und so aussehen: Name des Gerichts \n Zutaten \n Zubereitung"
        openAI.sendChatCompletion(newMessage: AIMessage(role: .user, content: prompt ), previousMessages: [], model: .gptV3_5(.gptTurbo), maxTokens: 2048, n: 1, completion: { [weak self] result in
            DispatchQueue.main.async { self?.stopActivityIndicator() }
            
            switch result {
            case .success(let aiResult):
                // Handle result actions
                if let text = aiResult.choices.first?.message?.content {
                    let recipe = "Hier ist ein Rezept für ein \(mealGenerator.getCategory() ?? "zufälliges Gericht") zum/als \(mealGenerator.getMealTime() ?? "zufällige Mahlzeit") \n" + text
                    mealGenerator.setRecipe(finalRecipe: recipe)
                    
                }
            case .failure(let error):
                // Handle error actions
                print(error.localizedDescription)
            }
        })
    }
    
    func startActivityIndicator() {
            // Wenn du einen Aktivitätsindikator hast, stoppe ihn hier
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        activityIndicator.isHidden = false
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.alpha=0
        activityIndicator.isHidden = true
        self.transparancyView.alpha = 0
        self.generateRecipeView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.generateRecipeView.alpha = 0
        performSegue(withIdentifier: "generateRecipeSegueID", sender: nil)
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

