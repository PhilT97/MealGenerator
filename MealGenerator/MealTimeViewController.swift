//
//  MealTimeViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 23.03.24.
//

import UIKit
import OpenAIKit

class MealTimeViewController: UIViewController {
    
    var category:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func breakfastTapped(_ sender: UIButton) {
        startActivityIndicator()
        tryGpt()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */

    @IBAction func ingredientsButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "ingredientsSegueID", sender: nil)
    }
    
    @IBAction func unwindToMealTimeSegue(_ sender: UIStoryboardSegue) {
        print("Unwound to Meal time")
    }
    
    
}

extension MealTimeViewController {
    private func tryGpt(){
        openAI.sendChatCompletion(newMessage: AIMessage(role: .user, content: "erstelle ein Rezept, formattiert als swift string ohne Deklaration"), previousMessages: [], model: .gptV3_5(.gptTurbo), maxTokens: 2048, n: 1, completion: { [weak self] result in
            DispatchQueue.main.async { self?.stopActivityIndicator() }
            
            switch result {
            case .success(let aiResult):
                // Handle result actions
                if let text = aiResult.choices.first?.message?.content {
                    mealGenerator.setRecipe(finalRecipe: text)
                    print(text)
                    
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
        performSegue(withIdentifier: "RecipeSegueID", sender: nil)
    }
    
    
    
    
}
