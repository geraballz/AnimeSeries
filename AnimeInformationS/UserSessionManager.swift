//
//  UserSessionManager.swift
//  AnimeInformationS
//
//  Created by Gerardo Herrera on 7/25/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class UserSessionManager: NSObject {
    static var currentSession = UserSessionManager()
   
    
    var token : String? {
        set{
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: "token")
        }
        get{
            let userDefaults = UserDefaults.standard
            if let token : String =  userDefaults.object(forKey: "token") as? String{
                return token
            }
            else{
                print("Impossible to get token in UserDefaults")
                return nil
            }
            
        }
    }
    
    var token_type : String? {
        set{
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: "token_type")
        }
        get{
            let userDefaults = UserDefaults.standard
            if let token_type : String =  userDefaults.object(forKey: "token_type") as? String{
                return token_type
            }
            else{
                print("Impossible to get token_type in UserDefaults")
                return nil
            }
            
        }
    }
}
