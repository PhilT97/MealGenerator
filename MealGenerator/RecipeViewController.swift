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
    
    
    // Button Views
    @IBOutlet var editButton: UIButton!
    @IBOutlet var timerbutton: UIButton!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cartButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
