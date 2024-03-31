//
//  ViewController.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import Foundation
import OpenAIKit
import UIKit
import MapKit

class MealTypeVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {
    
    
    private let lightBlue = UIColor(red: 213.0/255.0, green: 230.0/255.0, blue: 253/255.0, alpha: 1)
    var countryList = [
        "Afghanistan", "Albanien", "Algerien", "Andorra","Angola","Antigua und Barbuda","Argentinien","Armenien","Aserbaidschan","Australien","Bahamas","Bahrain","Bangladesch","Barbados","Belarus","Belgien","Belize","Benin","Bhutan","Bolivien","Bosnien und Herzegowina","Botswana","Brasilien","Brunei","Bulgarien","Burkina Faso","Burundi","Cabo Verde","Chile","China","Cookinseln","Costa Rica","Dänemark","Deutschland","Dominica","Dominikanische Republik","Dschibuti","Ecuador","El Salvador","Elfenbeinküste","Eritrea","Estland","Eswatini","Fidschi","Finnland","Frankreich","Gabun","Gambia","Georgien","Ghana","Grenada","Griechenland","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Indien","Indonesien","Irak","Iran","Irland","Island","Israel","Italien","Jamaika","Japan","Jemen","Jordanien","Kambodscha","Kamerun","Kanada","Kap Verde","Kasachstan","Katar","Kenia","Kirgisistan","Kiribati","Kolumbien","Komoren","Kongo, Demokratische Republik des","Kongo, Republik des","Korea, Nord","Korea, Süd","Kosovo","Kroatien","Kuba","Kuwait","Laos","Lesotho","Lettland","Libanon","Liberia","Libyen","Liechtenstein","Litauen","Luxemburg","Madagaskar","Malawi","Malaysia","Malediven","Mali","Malta","Marokko","Marshallinseln","Mauretanien","Mauritius","Mexiko","Mikronesien","Moldawien","Monaco","Mongolei","Montenegro","Mosambik","Myanmar","Namibia","Nauru","Nepal","Neuseeland","Nicaragua","Niederlande","Niger","Nigeria","Nordmazedonien","Norwegen","Oman","Österreich","Pakistan","Palau","Panama","Papua-Neuguinea","Paraguay","Peru","Philippinen","Polen","Portugal","Ruanda","Rumänien","Russland","Salomonen","Sambia","Samoa","San Marino","São Tomé und Príncipe","Saudi-Arabien","Schweden","Schweiz","Senegal","Serbien","Seychellen","Sierra Leone","Simbabwe","Singapur","Slowakei","Slowenien","Somalia","Spanien","Sri Lanka","St. Kitts und Nevis","St. Lucia","St. Vincent und die Grenadinen","Südafrika","Sudan","Südsudan","Suriname","Syrien","Tadschikistan","Taiwan","Tansania","Thailand","Timor-Leste","Togo","Tonga","Trinidad und Tobago","Tschad","Tschechien","Tunesien","Türkei","Turkmenistan","Tuvalu","Uganda","Ukraine","Ungarn","Uruguay","Usbekistan","Vanuatu","Vatikanstadt","Venezuela","Vereinigte Arabische Emirate","Vereinigtes Königreich","Vereinigte Staaten","Vietnam","Zentralafrikanische Republik","Zypern"
    ]
    
    // First time selection status
    private var firstSelectedButtons = [
        "MealType" : true,
        "MealTime" : true,
        "Country" : false,
        "Custom" : true
    ]
    
    // Automatic Register switch after (first) selection
    private var constantSwitch = true
    
    
    private func resetButtonSelection() {
        for (key, _) in self.firstSelectedButtons where key != "Country"{
            firstSelectedButtons[key] = true
        }
    }
    
    private let switchTime = 0.2
    
    
    
    // Selection Switcher
    private func switchToSelection(for key: String!) {
        var functionToCall: (() -> Void)?
        var timeToSwitch = switchTime
        switch key {
        case "MealType":
            functionToCall = self.selectMealTime
        case "MealTime":
            functionToCall = self.selectCountry
        case "Country":
            functionToCall = self.selectCustomPreset
            timeToSwitch = 0.8
        default:
            functionToCall = {print("ERROR")}
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + timeToSwitch) {
            if self.firstSelectedButtons[key]! {
                if !self.constantSwitch {
                    self.firstSelectedButtons[key] = false
                }
                if let function = functionToCall {
                    function()
                }
            }
        }
    }

    
    // Country View and Buttons
    
    @IBOutlet var globusMapView: MKMapView!
    @IBOutlet var countryPickerView: UIPickerView!
    @IBOutlet var countryTrashButton: UIButton!
    @IBOutlet var countryTextField: UITextField!
    
    @IBOutlet var CountryPickerContainerView: UIView!
    private var CountryPickerContainerViewY: CGFloat!
    
    @IBAction func countryTrashButtonTapped (_ sender: UIButton){
        let allAnnotations = self.globusMapView.annotations
        self.globusMapView.removeAnnotations(allAnnotations)
        mealGenerator.setCountry(country: "")
    }
    
    private let initialCameraZoom:Double = 20000000
    
    // Custom Preset View
    var dataEntries: [dataEntry] = []
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var customPresetTextField: UITextField!
    
    @IBOutlet var initialTableCell: UITableViewCell!
    
    
    
    @IBOutlet var customPresetInputView: UIView!
    private var customPresetInputViewY: CGFloat!
    
    
    
    // View-Outlets in Current View Controller
    
    @IBOutlet var mealTypeView: UIView!
    @IBOutlet var mealTimeView: UIView!
    @IBOutlet var customPresetView: UIView!
    @IBOutlet var countryView: UIView!
    
    
    @IBOutlet var transparancyView: UIView!
    @IBOutlet var generateRecipeView: UIView!
    
    @IBOutlet var categoryViews: [UIView]!
    
    
    // Button Bar Button Outlets
    @IBOutlet var mealTypeButton: UIButton!
    @IBOutlet var mealTimeButton: UIButton!
    @IBOutlet var customPresetButton: UIButton!
    @IBOutlet var countryButton: UIButton!
    
    
    
    
    
    @IBOutlet var generateRecipeButton: UIButton!
    
    @IBOutlet var buttonBarButtons: [UIButton]!
    
    
    // Meal Type Button Outlets
    
    @IBOutlet var meatButton: UIButton!
    @IBOutlet var meatButton2: UIButton!
    @IBOutlet var vegetarianButton: UIButton!
    @IBOutlet var veganButton: UIButton!
    @IBOutlet var randomType: UIButton!
    @IBOutlet var randomType2: UIButton!
    
    @IBOutlet var mealTypeButtons: [UIButton]!
    
    // Meal Type Scroll View
    @IBOutlet var mealTypeScrollView: UIScrollView!
    private var startOffset:CGPoint!
    private var endOffset:CGPoint!
    private var firstPage = 1
    private var lastPage = 4
    
    
    
    // Meal Time Button Outlets
    @IBOutlet var breakfastButton: UIButton!
    @IBOutlet var lunchButton: UIButton!
    @IBOutlet var dinnerButton: UIButton!
    @IBOutlet var snackButton: UIButton!
    @IBOutlet var dessertButton: UIButton!
    @IBOutlet var saladButton: UIButton!
    
    
    @IBOutlet var mealTimeButtons: [UIButton]!
    
    // Activity Indicator
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet var customPresetTableView: UITableView!
    
    
    
    @IBOutlet var generateRecipeTextView: UITextView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.customPresetInputViewY = customPresetInputView.frame.origin.y
        self.CountryPickerContainerViewY = CountryPickerContainerView.frame.origin.y
        // reset button selection
        resetButtonSelection()
        
        // Globus Zoom
        let camera = MKMapCamera()
        camera.centerCoordinate = CLLocationCoordinate2D(latitude: 50.110924, longitude: 8.682127)
        camera.altitude = self.initialCameraZoom
        globusMapView.setCamera(camera, animated: true)
        
        
        
        // keyboard appear Disapper for Custom Preset Register
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Confirmation Window
        generateRecipeView.layer.cornerRadius = 20
        // Initiate View Array
        categoryViews = [mealTypeView, mealTimeView, customPresetView, countryView]
        // initiate Button Arrays
        buttonBarButtons = [mealTypeButton, mealTimeButton, customPresetButton, countryButton]
        mealTypeButtons = [meatButton, vegetarianButton, veganButton, randomType]
        for button in mealTypeButtons {
            button.backgroundColor = UIColor.clear
        }
        mealTimeButtons = [breakfastButton, lunchButton, dinnerButton, snackButton, dessertButton, saladButton]
        
        // Initiate first view
        if !check_if_button_is_active() {
            self.mealTypeButton.isSelected = true
        }
        
        // Modify Pop Up Text View to be not interactable
        self.generateRecipeTextView.isEditable = false
        
        // initiate View with everything unselected
        let allAnnotations = self.globusMapView.annotations
        self.globusMapView.removeAnnotations(allAnnotations)
        self.selectMealType()
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

        
    }
    
    override func viewDidLoad() {
        // initialize buttons in array
        
        
        
        
        super.viewDidLoad()
        // Initiate scroll view
        mealTypeScrollView.delegate = self
        let width = mealTypeScrollView.frame.size.width
        startOffset = CGPoint(x: width * CGFloat(firstPage), y: 0)
        mealTypeScrollView.contentOffset = startOffset
        
        
        // Do any additional setup after loading the view.
        // country Funcitonality
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        countryTextField.delegate = self
        
        // keyboard functionality
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        view.addGestureRecognizer(tapGesture)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        
        customPresetTextField.delegate = self
        
        // Table functionality
        customPresetTableView.dataSource = self
        customPresetTableView.delegate = self
        
        // country functionality
        globusMapView.mapType = .hybridFlyover
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        globusMapView.addGestureRecognizer(tapRecognizer)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentWidth = scrollView.contentSize.width
        let width = scrollView.bounds.size.width
        startOffset = CGPoint(x: width * CGFloat(firstPage), y: 0)
        endOffset = CGPoint(x: width * CGFloat(lastPage), y: 0)
        let offset = scrollView.contentOffset.x
        
        if offset >= contentWidth - width {
            scrollView.contentOffset = startOffset
        }
        if offset <= 0 {
            scrollView.contentOffset = endOffset
        }
    }
    
    // Country Methods
    @objc func mapTapped(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: globusMapView)
        let locationCoordinate = globusMapView.convert(touchLocation, toCoordinateFrom: globusMapView)
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in guard let strongSelf = self else {return}
            if let error = error {
                print("Reverse geocoding failed: \(error)")
                return
            }
            
            if let placemarks = placemarks, let placemark = placemarks.first, let landName = placemark.country {
                let allAnnotations = strongSelf.globusMapView.annotations
                strongSelf.globusMapView.removeAnnotations(allAnnotations)
                if !strongSelf.countryList.contains(landName) {
                    strongSelf.countryList.append(landName)
                    DispatchQueue.main.async {
                        self?.countryPickerView.reloadAllComponents()
                    }
                }
                if let index = self?.countryList.firstIndex(of: landName) {
                    self?.countryPickerView.selectRow(index, inComponent: 0, animated: true)
                }
                mealGenerator.setCountry(country: landName)
                let annotation = MKPointAnnotation()
                annotation.coordinate = locationCoordinate
                annotation.title = landName
                strongSelf.globusMapView.addAnnotation(annotation)
                // If it is the first time a country is selected jump to next page
                strongSelf.switchToSelection(for: "Country")
            }
            
        }
        
    }
    // Country Picker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mealGenerator.setCountry(country: countryList[row])
        centerOnLand(name: countryList[row])
        // If it is the first time a country is selected jump to next page
//        switchToSelection(for: "Country")
        
        
    }
    
    // Country Text Field Functionality
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countryTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text,
               let row = countryList.firstIndex(of: text) {
                countryPickerView.selectRow(row, inComponent: 0, animated: true)
            }
        }
    
    func centerOnLand(name: String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { [weak self] (placemarks, error) in
            guard let strongSelf = self, let placemark = placemarks?.first, let location = placemark.location else {return}
            
            let allAnnotations = strongSelf.globusMapView.annotations
            strongSelf.globusMapView.removeAnnotations(allAnnotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = name
            strongSelf.globusMapView.addAnnotation(annotation)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 6000000, longitudinalMeters: 6000000)
            let animationDuration = 1.0
            strongSelf.globusMapView.setRegion(region, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                strongSelf.switchToSelection(for: "Country")
            }
            
            
        }
    }
    
    // Keyboard Methods
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
        let newViewPosition = keyboardSize.height
        
        UIView.animate(withDuration: 0.3){
            self.customPresetInputView.frame.origin.y = newViewPosition - self.customPresetInputView.frame.height
            print("TEST")
            self.CountryPickerContainerView.frame.origin.y = newViewPosition + 25 - self.CountryPickerContainerView.frame.height
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.customPresetInputView.frame.origin.y = self.customPresetInputViewY
            self.CountryPickerContainerView.frame.origin.y = self.CountryPickerContainerViewY
            self.view.layoutIfNeeded()
            
        }
    }
    
    

    
    
}
// Scroll view methods
extension MealTypeVC {
    
}


// Table Methods
extension MealTypeVC {
    
    @IBAction func cellPlusButtonTapped(){
        guard let text = customPresetTextField.text, !text.isEmpty else {return}
        dataEntries.append(dataEntry(text: text, sign: "+"))
        customPresetTableView.reloadData()
        customPresetTextField.text = ""
       
    }
    
    @IBAction func cellMinusButtonTapped(){
        guard let text = customPresetTextField.text, !text.isEmpty else {return}
        dataEntries.append(dataEntry(text: text, sign: "-"))
        customPresetTableView.reloadData()
        customPresetTextField.text = ""
    }
    
    
    // Data source Methods
    // Row Count in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataEntries.count
    }
    
    // Cell configuration
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = customPresetTableView.dequeueReusableCell(withIdentifier: "customIngredientCellID", for: indexPath)
        let entry = dataEntries[indexPath.row]
        cell.textLabel?.text = "\(entry.sign) \(entry.text)"
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataEntries.remove(at: indexPath.row)
            customPresetTableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// BUTTON BAR METHODS
extension MealTypeVC {
    // This extension manages the buttons on the bottom bar of the Recipe generator
    @IBAction func mealTimeButtonTapped(_ sender: UIButton) {
        selectMealTime()
    }
    
    private func selectMealTime() {
        if self.mealTimeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.hide_views()
                self.mealTimeView.alpha = 1
                self.mealTimeView.isHidden = false
                self.mealTimeButton.isSelected = true
            }
        }
    }
    
    
    @IBAction func mealTypeButtonTapped(_ sender: UIButton) {
        selectMealType()
    }
    
    private func selectMealType() {
        if self.mealTypeView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.hide_views()
                self.mealTypeView.alpha = 1
                self.mealTypeView.isHidden = false
                self.mealTypeButton.isSelected = true
            }
        }
    }
    
    @IBAction func customPresetButtonTapped(_ sender: UIButton){
        selectCustomPreset()
    }
    
    private func selectCustomPreset() {
        if self.customPresetView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.hide_views()
                self.customPresetView.alpha = 1
                self.customPresetView.isHidden = false
                self.customPresetButton.isSelected = true
            }
        }
    }
    
    @IBAction func countryButtonTapped(_ sender: UIButton) {
        selectCountry()
    }
    
    private func selectCountry(){
        if self.countryView.alpha != 1 {
            UIView.animate(withDuration: 0.5) {
                self.unselect_buttonBarButtons()
                self.hide_views()
                self.countryView.alpha = 1
                self.countryView.isHidden = false
                self.countryButton.isSelected = true
            }
        }
    }
    
    @IBAction func generateRecipeButtonTapped(_ sender: UIButton) {
        generateRecipe()
    }
    
    private func generateRecipe() {
        var countryText = ""
        if mealGenerator.getCountry() != "" {
            countryText = " aus " + (mealGenerator.getCountry() ?? "")
        }
        var article = "als"
        if ["Frühstück", "Mittagessen", "Abendessen"].contains(mealGenerator.getMealTime()) {
            article = "zum"
        }
        
        let showGenerationText = "Erstelle ein Rezept" + countryText + " für ein \(mealGenerator.getCategory() ?? "zufälliges Gericht") " + article + " \(mealGenerator.getMealTime() ?? "zufällige Mahlzeit")? \n"
        var additionalIngredients = ""
        var withoutIngredients = ""
        for entry in self.dataEntries {
            if entry.sign == "+" {
                if additionalIngredients == "" {
                    additionalIngredients += "Mit: \n"
                }
                additionalIngredients += ("  " + entry.text + "\n")
            }
            else {
                if withoutIngredients == "" {
                    withoutIngredients += "Ohne: \n"
                }
                withoutIngredients += ("  " + entry.text + "\n")
            }
        }
        
        self.generateRecipeTextView.text = showGenerationText + additionalIngredients + withoutIngredients
    
        
        self.generateRecipeView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        self.generateRecipeView.alpha = 1
        UIView.animate(withDuration: 0.2) {
            self.transparancyView.alpha = 0.7
            self.generateRecipeView.transform = CGAffineTransform.identity
        }
    }
    
    
    // Button helpers
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
    
    // View Helper
    func hide_views() {
        for v in self.categoryViews {
            v.alpha = 0
            v.isHidden = true
        }
    }
    
    
    
}

// MEAL TYPE METHODS
extension MealTypeVC {
    
    // This extension manages the buttons on the Meal Type Chooser
    @IBAction func meatButtonTapped(_ sender: UIButton) {
        if meatButton.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            meatButton.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Fleischgericht")
            meatButton.tintColor = lightBlue
            meatButton.isSelected = true
            switchToSelection(for: "MealType")
        }
        
    }
    
    @IBAction func meatButton2Tapped(_ sender: UIButton) {
        if meatButton2.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            meatButton2.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Fleischgericht")
            meatButton2.tintColor = lightBlue
            meatButton2.isSelected = true
            switchToSelection(for: "MealType")
        }
        
    }
    
    @IBAction func vegetarianButtonTapped(_ sender: UIButton) {
        if vegetarianButton.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            vegetarianButton.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Vegetarisches Gericht")
            vegetarianButton.tintColor = lightBlue
            vegetarianButton.isSelected = true
            switchToSelection(for: "MealType")
        }
    }
    
    @IBAction func veganButtonTapped(_ sender: UIButton) {
        if veganButton.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            veganButton.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Veganes Gericht")
            veganButton.tintColor = lightBlue
            veganButton.isSelected = true
            switchToSelection(for: "MealType")
        }
    }
    
    @IBAction func randomTypeButtonTapped(_ sender: UIButton) {
        if randomType.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            randomType.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Zufälliges Gericht")
            randomType.tintColor = lightBlue
            randomType.isSelected = true
            switchToSelection(for: "MealType")
        }
        
    }
    
    @IBAction func randomType2ButtonTapped(_ sender: UIButton) {
        if randomType2.isSelected {
            mealGenerator.setDefaultCategory()
            unselect_mealTypeButtons()
            randomType2.isSelected = false
        }
        else {
            unselect_mealTypeButtons()
            mealGenerator.setCategory(category: "Zufälliges Gericht")
            randomType2.tintColor = lightBlue
            randomType2.isSelected = true
            switchToSelection(for: "MealType")
        }
        
    }
    
    
    private func unselect_mealTypeButtons() {
        for button in mealTypeButtons where button.isSelected {
            button.isSelected = false
            button.tintColor = UIColor.systemBlue
        }
    }
    
    
}

// MEAL TIME METHODS
extension MealTypeVC {
    // This extensions manages the buttons on the Meal Time Chooser
    @IBAction func breakfastButtonTapped(_ sender: UIButton) {
        if breakfastButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            breakfastButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Frühstück")
            breakfastButton.tintColor = lightBlue
            breakfastButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    @IBAction func lunchButtonTapped(_ sender: UIButton) {
        if lunchButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            lunchButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Mittagessen")
            lunchButton.tintColor = lightBlue
            lunchButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    @IBAction func dinnerButtonTapped(_ sender: UIButton) {
        if dinnerButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            dinnerButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Abendessen")
            dinnerButton.tintColor = lightBlue
            dinnerButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    @IBAction func snackButtonTapped(_ sender: UIButton) {
        if snackButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            snackButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Snack")
            snackButton.tintColor = lightBlue
            snackButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    @IBAction func dessertButtonTapped(_ sender: UIButton) {
        if dessertButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            dessertButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Dessert")
            dessertButton.tintColor = lightBlue
            dessertButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    @IBAction func saladButtonTapped(_ sender: UIButton) {
        if saladButton.isSelected {
            mealGenerator.setDefaultMealTime()
            unselect_mealTimeButtons()
            saladButton.isSelected = false
        }
        else {
            unselect_mealTimeButtons()
            mealGenerator.setMealTime(mealTime: "Salat")
            saladButton.tintColor = lightBlue
            saladButton.isSelected = true
            switchToSelection(for: "MealTime")
        }
    }
    
    
    private func unselect_mealTimeButtons() {
        for button in mealTimeButtons where button.isSelected {
            button.isSelected = false
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
        var prompt = "erstelle ein Rezept für ein \(mealGenerator.getCategory() ?? "zufälliges Gericht") zum/als \(mealGenerator.getMealTime() ?? "zufällige Mahlzeit"), formattiert als swift string ohne Deklaration,"
        let instruction = "Ausgabe soll nur der String Inhalt sein und so aussehen: Name des Gerichts \n Zutaten \n Zubereitung"
        var additions = ""
        var without = ""
        var country = ""
        if mealGenerator.getCountry() != "" {
            country = "das Rezept kommt aus dem Land:" + (mealGenerator.getCountry() ?? "") + ", "
        }
        if !self.dataEntries.isEmpty {
            for entry in self.dataEntries {
                if entry.sign == "+" {
                    if additions == ""{
                        additions += "Rezept soll enthalten: "
                    }
                    additions += (entry.text + ", ")
                }
                else {
                    if without == "" {
                        without += "Rezept soll nicht enthalten: "
                    }
                    without += (entry.text + ", ")
                    
                }
            }
        }
        
        prompt += prompt + country + additions + without + instruction
        
        openAI.sendChatCompletion(newMessage: AIMessage(role: .user, content: prompt ), previousMessages: [], model: .gptV3_5(.gptTurbo), maxTokens: 2048, n: 1, completion: { [weak self] result in
            DispatchQueue.main.async { self?.stopActivityIndicator() }
            
            switch result {
            case .success(let aiResult):
                // Handle result actions
                if let text = aiResult.choices.first?.message?.content {
                    let recipe = text
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
        self.dataEntries.removeAll()
        self.customPresetTableView.reloadData()
        self.unselect_mealTimeButtons()
        self.unselect_mealTypeButtons()
        performSegue(withIdentifier: "generateRecipeSegueID", sender: nil)
    }
    
    
    
    
}

// TABLE DATA MODEL

struct dataEntry {
    var text: String
    var sign: String
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

