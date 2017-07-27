//
//  ViewController.swift
//  AnimeInformationS
//
//  Created by Gerardo Herrera on 7/25/17.
//  Copyright © 2017 Gerardo Herrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var colectionViewAnime: UICollectionView!
     var arrayAnimes = [Anime]()
    override func viewDidLoad() {
        super.viewDidLoad()
       initzializeData()
        configureCollectionView()
        //Do any additional setup after loading the view, typically from a nib.
    }
    //MARK:-  Configure colectionViewAnime
    func configureCollectionView()
    {
        colectionViewAnime.delegate = self
        colectionViewAnime.dataSource = self
    }
    
    // MARK:- This Method can initzializeData (call methods API)
    
    func initzializeData()
    {
    WebServiceAPI.getToken(completionHandler: { (band, message) in
    print(message)
    if band == true
    {
    WebServiceAPI.getListAnime(completionHandler: { (band, arrayAnime) in
    print(band)
        if ( band == true)
        {
            self.arrayAnimes = arrayAnime
            DispatchQueue.main.async {
                self.colectionViewAnime.reloadData()
            }
        }
    })
    }
    })
    }

    func configurePopUp(sender: UITapGestureRecognizer)
    {
        var indexbyTag = 0
        let storyBoard = UIStoryboard(name: "PreviewImage", bundle: nil)
        let viewcontroller = storyBoard.instantiateViewController(withIdentifier: "preview") as! PreviewImageViewController
        viewcontroller.image = (sender.view as! UIImageView).image!
        indexbyTag = (sender.view?.tag)!
        viewcontroller.tittleJapanese = self.arrayAnimes[indexbyTag].title_japanese
        viewcontroller.tittleEnglish = self.arrayAnimes[indexbyTag].title_english
        viewcontroller.type = self.arrayAnimes[indexbyTag].type
        viewcontroller.popularity = "\(self.arrayAnimes[indexbyTag].popularity)"
        viewcontroller.totalEpisodies = "\(self.arrayAnimes[indexbyTag].total_episodes)"
        viewcontroller.score = "\(self.arrayAnimes[indexbyTag].average_score)"
        viewcontroller.id = self.arrayAnimes[indexbyTag].id
        viewcontroller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(viewcontroller, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayAnimes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : ItemAnimeCollectionViewCell = colectionViewAnime.dequeueReusableCell(withReuseIdentifier: "cellAnime", for: indexPath) as! ItemAnimeCollectionViewCell
        cell.tittleLable.text = self.arrayAnimes[indexPath.row].title_english
        cell.imageAnimeUIImage.loadImage(urlString: self.arrayAnimes[indexPath.row].image_url_lge)
        cell.imageAnimeUIImage.isUserInteractionEnabled = true
        cell.imageAnimeUIImage.tag = indexPath.row
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.configurePopUp(sender:)))
        cell.imageAnimeUIImage.addGestureRecognizer(tapGesture)
        
        return cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
    }
}
