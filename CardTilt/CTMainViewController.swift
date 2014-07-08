//
//  CTMainViewController.swift
//  CardTilt
//
//  Created by ZhouHao on 7/7/14.
//  Copyright (c) 2014 ZhouHao. All rights reserved.
//

import UIKit
import QuartzCore

class CTMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var members : NSArray = []
    var initialTransformation : CATransform3D?
    var shownIndexes : NSMutableSet?
    
    @IBOutlet var tableView: UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let data: NSData = NSData.dataWithContentsOfFile(NSBundle.mainBundle().pathForResource("TeamMembers", ofType: "json"), options: nil, error: nil)
        
        // parsing is strict, all the keys must be presented, otherwise will crash
        let json : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(), error: nil) as NSDictionary
        
        self.members = json["team"] as NSArray
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))
        
        let rotationAngleDegrees : CGFloat = -15;
        let rotationAngleRadians : CGFloat = rotationAngleDegrees * CGFloat(M_PI/180)
        let offsetPositioning : CGPoint = CGPointMake(-20, -20)
        
        var transform : CATransform3D = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, rotationAngleRadians, 0.0, 0.0, 1.0);
        transform = CATransform3DTranslate(transform, offsetPositioning.x, offsetPositioning.y, 0.0);
        self.initialTransformation = transform;
        
        self.shownIndexes = NSMutableSet()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView:UITableView!, numberOfRowsInSection section:Int)->Int
    {
//        println(self.members.count)
        return self.members.count
    }
    
    func numberOfSectionsInTableView(tableView:UITableView!)->Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        println(indexPath.row)
        var cell : CTCardCell = tableView.dequeueReusableCellWithIdentifier("Card", forIndexPath: indexPath) as CTCardCell
        if let dic = self.members.objectAtIndex(indexPath.row) as? NSDictionary {
            cell.setupWithDictionary(self.members.objectAtIndex(indexPath.row) as NSDictionary)
        }
        return cell
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        let font : UIFont = UIFont(name: "HelveticaNeue-Light", size: 10)
        let dic = self.members.objectAtIndex(indexPath.row) as NSDictionary
        let aboutText = dic.valueForKey("about") as String
//        let aboutText = self.members[indexPath.row]["about"]
        
        let newlineString : String = "\n"
        let newAboutText : String = aboutText.bridgeToObjectiveC().stringByReplacingOccurrencesOfString("\\n", withString: newlineString)
        
        let aboutSize : CGSize = newAboutText.bridgeToObjectiveC().sizeWithFont(font,
            constrainedToSize: CGSizeMake(268, 4000))
        
//        println(280-15+aboutSize.height)
        
        return (280-15+aboutSize.height)
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!)
    {
        if !self.shownIndexes!.containsObject(indexPath) {
            
            self.shownIndexes!.addObject(indexPath)
            
            let card = (cell as CTCardCell).mainView
            card.layer.transform = self.initialTransformation!
            card.layer.opacity = 0.8
         
            UIView.animateWithDuration(0.4, animations: {

                card.layer.transform = CATransform3DIdentity;
                card.layer.opacity = 1;
                
            })
        }
        
    }
    
}
