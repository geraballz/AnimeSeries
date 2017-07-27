//
//  WebConstans.swift
//  AnimeInformationS
//
//  Created by Gerardo Herrera on 7/25/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class WebConstans: NSObject {

    private static var client_secret = "teWsIIOxdEcFnnUdWU1GzUBMV"
    private static var client_id = "geraballz-4jj1u"
    private static var grant_type = "client_credentials"
    static var baseURL = "https://anilist.co/api/"
    static var getToken = baseURL + "auth/access_token?grant_type=" + grant_type + "&client_id=" + client_id + "&client_secret=" + client_secret
    static var animeList = baseURL + "user/geraballz/animelist"
    static var animeDetail = baseURL + "anime/"
}
