//
//  Extensions.swift
//  Rent
//
//  Created by Gerardo Herrera on 7/26/17.
//  Copyright © 2017 Software. All rights reserved.
//

import UIKit

var imageCahe = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImage(urlString : String)
    {
        self.image = nil
        if let imageCached = imageCahe.object(forKey: urlString as AnyObject) as? UIImage
        {
            self.image = imageCached
            return
        }
        
        let url = URL(string: urlString)
        
        
        
        let taskImage = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            
            if(error != nil)
            {
                return
            }
            DispatchQueue.main.async(execute: {
                
                if let imageDowloaded = UIImage(data: data!)
                {
                    print("Image Downloaded")
                    imageCahe.setObject(imageDowloaded, forKey: url as AnyObject)
                    self.image = imageDowloaded
                }
            })
        })
        taskImage.resume()
    }
    
}

