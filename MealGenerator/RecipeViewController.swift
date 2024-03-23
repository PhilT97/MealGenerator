//
//  RecipeViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 23.03.24.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet var recipeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTextView.text = mealGenerator.generateRecipe()

        // Do any additional setup after loading the view.
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
