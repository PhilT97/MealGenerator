//
//  RecipeViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 23.03.24.
//

import UIKit

class RecipeViewController: UIViewController {
    // Text Views
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var ingredientsTextView: UITextView!
    @IBOutlet var instructionsTextView: UITextView!
    
    
    // Text variables
    private var recipeTitle: String?
    private var recipeIngredients: String?
    private var recipeInstructions: String?
    private var finalRecipe: String?
    
    
    // Button Views
    @IBOutlet var editButton: UIButton!
    @IBOutlet var timerbutton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cartButton: UIButton!
    
    
    
    override func viewDidLoad() {
        titleTextView.isEditable = false
        ingredientsTextView.isEditable = false
        instructionsTextView.isEditable = false
        
        super.viewDidLoad()
        
        finalRecipe = mealGenerator.getRecipe()
        
        split_recipe(recipe: finalRecipe!)
        
        titleTextView.text = recipeTitle
        ingredientsTextView.text = recipeIngredients
        instructionsTextView.text = recipeInstructions
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    private func split_recipe(recipe: String){
        // splits the recipe in Title, Ingredients, Instructions for UI use
        if let ingredientsRange = recipe.range(of: "Zutaten"), let instructionsRange = recipe.range(of: "Zubereitung") {
            recipeTitle = String(recipe[..<ingredientsRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
            recipeIngredients = String(recipe[ingredientsRange.lowerBound..<instructionsRange.lowerBound]).trimmingCharacters(in: .whitespacesAndNewlines)
            recipeInstructions = String(recipe[instructionsRange.lowerBound...]).trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
    }
    
    private func edit_recipe() {
        // gets recipe title and additional customization prompts and outputs a new recipe
        
    }
    
    private func start_timer() {
        // starts a timer
    }
    
    private func save_recipe() {
        // saves the current recipe
    }
    
    private func add_to_shoppingCart() {
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
