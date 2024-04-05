// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public final class RecipePrompt {
    private var mealType:String = "Zufälliges Gericht"
    private var mealTime:String = "Zufällige Mahlzeit"
    private var country:String = ""
    
    private var finalRecipe:String = ""
    
    
    public init(category: String? = "Zufälliges Gericht", mealTime: String? = "Zufällige Mahlzeit",country: String? = "", finalRecipe: String? = "") {
    }
    
    
    
}

extension RecipePrompt {
    public func setCategory(category:String){
        self.mealType = category
    }
    
    public func setDefaultCategory(){
        self.mealType = "Zufälliges Gericht"
    }
    
    public func getCategory() -> String? {
        return self.mealType
    }
    
    public func setMealTime(mealTime:String){
        self.mealTime = mealTime
    }
    
    public func setDefaultMealTime() {
        self.mealTime = "Zufällige Mahlzeit"
    }
    
    public func getMealTime() -> String? {
        return self.mealTime
    }
    
    public func setCountry(country:String){
        self.country = country
    }
    
    public func getCountry() -> String? {
        return self.country
    }
    
    public func setRecipe(finalRecipe: String) {
        self.finalRecipe = finalRecipe
    }
    
    public func getRecipe() -> String?  {
        return self.finalRecipe
    }
    
    public func restore_to_default() {
        self.mealType = "Zufälliges Gericht"
        self.mealTime = "Zufällige Mahlzeit"
        self.country = ""
        
        self.finalRecipe = ""
    }
    
    public func generateRecipe(){
//        guard let finalCategory = self.mealType else {
//            return "No viable Category Selected"
//        }
//        guard let finalMealTime = self.mealTime else {
//            return "No viable Mealtime Selected"
//        }
//        
        var recipe = """
        Test Recipe for Eat
        ------------------

        Zutaten:
        - 4 Äpfel, geschält und gewürfelt
        - 1 Teelöffel Zimt
        - 200 g Mehl
        - 150 g Zucker
        - 125 g Butter, kalt und gewürfelt
        - 1 Ei
        - Prise Salz

        Anweisungen:
        1. Heize deinen Ofen auf 180 °C vor.
        2. Mische die Äpfel mit Zimt und 50 g Zucker und setze sie beiseite.
        3. In einer Schüssel, kombiniere Mehl, die restlichen 100 g Zucker, Salz und Butter zu einer krümeligen Masse.
        4. Füge ein Ei hinzu und knete den Teig, bis er zusammenhält.
        5. Rolle zwei Drittel des Teigs aus und lege ihn in eine gefettete Kuchenform.
        6. Gib die Apfelmischung auf den Teig in der Form.
        7. Rolle den restlichen Teig aus und lege ihn als Deckel auf die Äpfel.
        8. Backe für 45 Minuten, bis der Kuchen goldbraun ist.

        Guten Appetit!
        """
        
        self.setRecipe(finalRecipe: recipe)
        
    }
}
