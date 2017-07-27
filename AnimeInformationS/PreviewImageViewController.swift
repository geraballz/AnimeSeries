//
//  PreviewImageViewController.swift
//  openImagepopUp
//
//  Created by Gerardo Herrera on 7/18/17.
//  Copyright © 2017 Software. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PreviewImageViewController: UIViewController {
    
    @IBOutlet weak var showButtonYouTubeButton: UIButton!
   
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleEnglishLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePreview: UIImageView!
    
    @IBOutlet weak var TittleJapaneseLabel: UILabel!
    
    @IBOutlet weak var totalEpisodiesLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var image : UIImage = UIImage()
    var tittleJapanese = ""
    var tittleEnglish = ""
    var totalEpisodies = ""
    var popularity = ""
    var type = ""
    var score = ""
    var id : Int = 0
    var youTubeID: String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEfffectView = UIVisualEffectView(effect: blurEffect)
        blurEfffectView.frame = self.view.bounds
        
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        blurEfffectView.addSubview(vibrancyEffectView)
        imagePreview.image = image
        TittleJapaneseLabel.text = "" + tittleJapanese
        totalEpisodiesLabel.text =  "Episodios: " + totalEpisodies
        popularityLabel.text = "Popularidad: " + popularity
        typeLabel.text = "Emision: " + type
        scoreLabel.text = "Score: " + score
        titleEnglishLabel.text = tittleEnglish
        self.view.subviews[0].insertSubview(blurEfffectView,at:0)
        
      
        WebServiceAPI.animeDetail(idAnime: id) { (band, animeObj) in
            if band == true
            {
                DispatchQueue.main.async {
                    
                    self.descriptionTextView.text = animeObj.descriptionAnime
                    if (animeObj.youtube_id != "")
                    {
                        self.showButtonYouTubeButton.alpha = 1
                        self.youTubeID = animeObj.youtube_id
                        self.showButtonYouTubeButton.isEnabled = true
                        
                    }
                }
            }
        }
    }
    
    @IBAction func showButtonYoutubeButtonAction(_ sender: Any) {
        let videoURL = URL(string: "https://www.youtube.com/embed/\(self.youTubeID)")
        
      //  UIApplication.shared.openURL(videoURL!)
        
        let storyBoard = UIStoryboard(name: "PreviewYoutube", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "youview") as! previewYoutubeViewController
        viewcontroller.urlVideo = videoURL
        
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(viewcontroller, animated: true, completion: nil)
        
    }
    func clicOutSide(sender : UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dissmissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


