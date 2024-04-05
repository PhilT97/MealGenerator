//
//  AppDelegate.swift
//  MealGenerator
//
//  Created by Philipp Tschan on 22.03.24.
//

import MealGeneratorKit
import OpenAIKit
import UIKit

let keyName = "key"

private func parse_key(fileName: String!) -> String! {
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") else {
        print("\(fileName ?? "") not Found.")
        return nil
    }
        do {
            let key = try String(contentsOfFile: filePath, encoding: .utf8)
            return key
        } catch {
            print("Error reading file")
            return nil
        }
}

var apiToken = parse_key(fileName: keyName)
public let openAI = OpenAIKit(apiToken: apiToken!)
public let mealGenerator = RecipePrompt()


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}

