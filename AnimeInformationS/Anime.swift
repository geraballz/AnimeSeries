//
//  animeObject.swift
//  AnimeInformationS
//
//  Created by Software on 7/26/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class Anime: NSObject {
    var id : Int = 0;
    var title_romaji: String = ""
    var title_english: String = ""
    var title_japanese: String = ""
    var type: String = ""
    var start_date_fuzzy: Int = 0
    var end_date_fuzzy: Int = 0
    var series_type: String = ""

    
    var adult: Bool = false
    var average_score: Int = 0;
    var popularity: Int = 0
    var updated_at: Int = 0
    var image_url_sml: String = ""
    var image_url_med: String = ""
    var image_url_lge: String = ""
    var image_url_banner: String = ""
    var total_episodes: Int = 0;
    var airing_status: String = ""
    var descriptionAnime: String = ""
    var youtube_id : String = ""
    
    init(id : Int, title_romaji : String, title_english : String, title_japanese : String, type : String,start_date_fuzzy : Int, end_date_fuzzy : Int , series_type : String , adult : Bool, average_score : Int, popularity : Int, updated_at : Int, image_url_lge : String, image_url_sml: String , image_url_med : String, image_url_banner : String, total_episodes : Int, airing_status: String) {
        self.id = id
        self.title_romaji = title_romaji
        self.title_japanese = title_japanese
        self.title_english = title_english
        self.type = type
        self.start_date_fuzzy = start_date_fuzzy
        self.end_date_fuzzy = end_date_fuzzy
        self.series_type = series_type
        self.adult = adult
        self.average_score = average_score
        self.popularity = popularity
        self.updated_at = updated_at
        self.image_url_sml = image_url_sml
        self.image_url_med = image_url_med
        self.image_url_lge = image_url_lge
        self.image_url_banner = image_url_banner
        self.total_episodes = total_episodes
        self.airing_status = airing_status
    }
    override init() {
        
    }
}
