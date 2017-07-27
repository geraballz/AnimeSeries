//
//  previewYoutubeViewController.swift
//  AnimeInformationS
//
//  Created by Gerardo Herrera on 7/27/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class previewYoutubeViewController: UIViewController {

    var urlVideo = URL(string: "")
    override func viewDidLoad() {
        super.viewDidLoad()
 webView.loadRequest(URLRequest(url: urlVideo!))
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var exitButton: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
       
    }
    
    @IBAction func dissmissModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
