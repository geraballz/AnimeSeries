//
//  WebServiceAPI.swift
//  AnimeInformationS
//
//  Created by Gerardo Herrera on 7/25/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class WebServiceAPI: NSObject {

    //MARK: - getToken
    class func getToken (completionHandler : @escaping(_ succes: Bool , _ message: String) ->())
    {
        let userConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: userConfiguration)
        
        if let url = URL(string : WebConstans.getToken)
        {
            print(url)
            
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.timeoutInterval = 90
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error.debugDescription)
                }
                else
                {
                    if let httpResponse = response as? HTTPURLResponse
                    {
                        var statusCode : Int = 0
                        
                        statusCode = httpResponse.statusCode
                        do{
                            
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                            
                            if let parseJSON = json {
                                
                                let dicResult = json as? [String:AnyObject]
                                
                                
                                switch(statusCode)
                                {
                                case 200:
                                    UserSessionManager.currentSession.token = dicResult?["access_token"] as! String
                                    UserSessionManager.currentSession.token_type = dicResult?["token_type"] as! String
                                     completionHandler(true,"Get Token Successfully")
                                    break;
                              
                                default:
                                    completionHandler(false,"")
                                    break;
                                }
                            }
                            
                            
                            print(data.debugDescription)
                            print(response.debugDescription)
                            
                        }catch{
                            print("Error Serializacion de JSON")
                            if statusCode == 201
                            {
                                completionHandler(true,"Registro Exitoso")
                            }
                        }
                    }
                }
            })
            task.resume()
        }
        else
        {
            print("URL Malformed")
        }
    }
    //MARK: - getListAnime
    class func getListAnime (completionHandler : @escaping(_ succes: Bool , _ message: [Anime]) ->())
    {
        let userConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: userConfiguration)
        
        let token : String = UserSessionManager.currentSession.token!
        if let url = URL(string : WebConstans.animeList + "?access_token=" + token)
        {
            
             print(url)
            
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            request.timeoutInterval = 90
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error.debugDescription)
                }
                else
                {
                    if let httpResponse = response as? HTTPURLResponse
                    {
                        var statusCode : Int = 0
                        
                        statusCode = httpResponse.statusCode
                        do{
                            
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                            
                            if let parseJSON = json {
                                
                                let dicResult = json as? [String:AnyObject]
                                var arrayAnime : [Anime] = [Anime]()
                                
                                switch(statusCode)
                                {
                                case 200:
                                 let list = dicResult?["lists"] as! [String:AnyObject]
                                 let listWatching = list["watching"] as! [[String: AnyObject]]
                                 
                                 for item in listWatching
                                 {
                                    let animeRaw = item["anime"]
                                    
                                    var anime : Anime = Anime()
                                    
                                    anime.id = (animeRaw?["id"] as? Int) ?? 0
                                    anime.title_english = (animeRaw?["title_english"] as? String) ?? ""
                                    anime.title_romaji = (animeRaw?["title_romaji"] as? String) ?? ""
                                    anime.title_japanese = (animeRaw?["title_japanese"] as? String) ?? ""
                                    anime.type = (animeRaw?["type"] as? String ) ?? ""
                                    anime.start_date_fuzzy = (animeRaw?["start_date_fuzzy"] as? Int) ?? 0
                                    anime.end_date_fuzzy = (animeRaw?["end_date_fuzzy"] as? Int) ?? 0
                                    anime.series_type = (animeRaw?["series_type"] as? String) ?? ""
                                    anime.adult = (animeRaw?["adult"] as? Bool) ?? false
                                    anime.average_score = (animeRaw?["average_score"] as? Int) ?? 0
                                    anime.popularity = (animeRaw?["popularity"] as? Int) ?? 0
                                    anime.updated_at = (animeRaw?["updated_at"] as? Int) ?? 0
                                    anime.image_url_lge = (animeRaw?["image_url_lge"] as? String) ?? ""
                                    anime.image_url_sml = (animeRaw?["image_url_sml"] as? String) ?? ""
                                    anime.image_url_med = (animeRaw?["image_url_med"] as? String) ?? ""
                                    anime.image_url_banner = (animeRaw?["image_url_banner"] as? String ) ?? ""
                                    anime.total_episodes = (animeRaw?["total_episodes"] as? Int) ?? 0
                                    anime.airing_status = (animeRaw?["airing_status"] as? String) ?? ""
                                    arrayAnime.append(anime)
                                    
                                 }
                                 completionHandler(true,arrayAnime)
                                    break;
                                    
                                default:
                                    completionHandler(false,arrayAnime)
                                    break;
                                }
                            }
                            
                            
                            print(data.debugDescription)
                            print(response.debugDescription)
                            
                        }catch{
                            print("Error Serializacion de JSON")
                            
                        }
                    }
                }
            })
            task.resume()
        }
        else
        {
            print("URL Malformed")
        }
    }

    // MARK: - animeDetail
    class func animeDetail (idAnime :Int, completionHandler : @escaping(_ succes: Bool , _ message: Anime) ->())
    {
        let userConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: userConfiguration)
        
        let token : String = UserSessionManager.currentSession.token!
        if let url = URL(string : WebConstans.animeDetail + "\(idAnime)" + "?access_token=" + token)
        {
            
            print(url)
            
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "GET"
            request.timeoutInterval = 90
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil{
                    print(error.debugDescription)
                }
                else
                {
                    if let httpResponse = response as? HTTPURLResponse
                    {
                        var statusCode : Int = 0
                        
                        statusCode = httpResponse.statusCode
                        do{
                            
                            
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? AnyObject
                            
                            if let parseJSON = json {
                                
                                let animeRaw = json as? [String:AnyObject]
                                
                                switch(statusCode)
                                {
                                case 200:
                                    
                                    
                                    
                                        
                                        var anime : Anime = Anime()
                                        
                                        anime.id = (animeRaw?["id"] as? Int) ?? 0
                                        anime.title_english = (animeRaw?["title_english"] as? String) ?? ""
                                        anime.title_romaji = (animeRaw?["title_romaji"] as? String) ?? ""
                                        anime.title_japanese = (animeRaw?["title_japanese"] as? String) ?? ""
                                        anime.type = (animeRaw?["type"] as? String ) ?? ""
                                        anime.start_date_fuzzy = (animeRaw?["start_date_fuzzy"] as? Int) ?? 0
                                        anime.end_date_fuzzy = (animeRaw?["end_date_fuzzy"] as? Int) ?? 0
                                        anime.series_type = (animeRaw?["series_type"] as? String) ?? ""
                                        anime.adult = (animeRaw?["adult"] as? Bool) ?? false
                                        anime.average_score = (animeRaw?["average_score"] as? Int) ?? 0
                                        anime.popularity = (animeRaw?["popularity"] as? Int) ?? 0
                                        anime.updated_at = (animeRaw?["updated_at"] as? Int) ?? 0
                                        anime.image_url_lge = (animeRaw?["image_url_lge"] as? String) ?? ""
                                        anime.image_url_sml = (animeRaw?["image_url_sml"] as? String) ?? ""
                                        anime.image_url_med = (animeRaw?["image_url_med"] as? String) ?? ""
                                        anime.image_url_banner = (animeRaw?["image_url_banner"] as? String ) ?? ""
                                        anime.total_episodes = (animeRaw?["total_episodes"] as? Int) ?? 0
                                        anime.airing_status = (animeRaw?["airing_status"] as? String) ?? ""
                                        
                                        //we can add more items :/
                                        anime.descriptionAnime = (animeRaw?["description"] as? String) ?? ""
                                        anime.youtube_id = (animeRaw?["youtube_id"] as? String) ?? ""
                                        
                                    completionHandler(true,anime)
                                    break;
                                    
                                default:
                                    completionHandler(false,Anime())
                                    break;
                                }
                            }
                            
                            
                            print(data.debugDescription)
                            print(response.debugDescription)
                            
                        }catch{
                            print("Error Serializacion de JSON")
                            
                        }
                    }
                }
            })
            task.resume()
        }
        else
        {
            print("URL Malformed")
        }
    }
    
}
