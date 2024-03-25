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
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
//        mealGenerator.generateRecipe()
//        
//        recipeTextView.text = mealGenerator.getRecipe()
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
