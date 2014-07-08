//
//  CTCardCell.swift
//  CardTilt
//
//  Created by ZhouHao on 7/7/14.
//  Copyright (c) 2014 ZhouHao. All rights reserved.
//

import UIKit

class CTCardCell: UITableViewCell {

    @IBOutlet var mainView : UIView
    @IBOutlet var profilePhoto : UIImageView
    @IBOutlet var nameLabel : UILabel
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var locationLabel : UILabel
    @IBOutlet var aboutLabel : UILabel
    @IBOutlet var webLabel : UILabel
    @IBOutlet var webButton : UIButton
    @IBOutlet var twImage : UIImageView
    @IBOutlet var twButton : UIButton
    @IBOutlet var fbImage : UIImageView
    @IBOutlet var fbButton : UIButton
    
    var website : String = ""
    var twitter : String = ""
    var facebook : String = ""
 
    func setupWithDictionary(dictionary : NSDictionary ) {
        
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.masksToBounds = true
        
        self.profilePhoto.image = UIImage(named:dictionary.valueForKey("image") as String)
                
        self.nameLabel.text = dictionary.valueForKey("name") as String
        self.nameLabel.text = dictionary.valueForKey("name") as String
        self.titleLabel.text = dictionary.valueForKey("title") as String
        self.locationLabel.text = dictionary.valueForKey("location") as String
        
        let aboutText : String = dictionary.valueForKey("about") as String
        let newlineString : String = "\n"
        self.aboutLabel.text = aboutText.bridgeToObjectiveC().stringByReplacingOccurrencesOfString("\\n", withString:newlineString)
        
        self.website = dictionary.valueForKey("web") as String
        if self.website.bridgeToObjectiveC().length > 0 {
            self.webLabel.text = dictionary.valueForKey("web") as String
        } else {
            self.webLabel.hidden = true
            self.webButton.hidden = true
        }
        
        self.twitter = dictionary.valueForKey("twitter") as String
        if self.twitter.bridgeToObjectiveC().length == 0 {
            self.twImage.hidden = true
            self.twButton.hidden = true
        } else {
            self.twImage.hidden = false
            self.twButton.hidden = false
        }
        
        self.facebook = dictionary.valueForKey("facebook") as String
        if self.facebook.bridgeToObjectiveC().length == 0 {
            self.fbImage.hidden = true
            self.fbButton.hidden = true
        } else {
            self.fbImage.hidden = false
            self.fbButton.hidden = false
        }
        
    }
}
