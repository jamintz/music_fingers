//
//  TopViewController.swift
//  Jamie's Magic Fingers
//
//  Created by Jason Mintz on 12/11/17.
//  Copyright © 2017 Jason Mintz. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    @IBOutlet weak var hTopInstrument: UIImageView!
    @IBOutlet weak var vTopInstrument: UIImageView!
    @IBOutlet weak var hTopShadow: UIView!
    @IBOutlet weak var vTopShadow: UIView!
    @IBOutlet weak var pageAnchor: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for lay in [hTopShadow, vTopShadow]{
            lay?.layer.shadowColor = UIColor.black.cgColor
            lay?.layer.shadowOpacity = 1
            lay?.layer.shadowRadius = 10
            lay?.clipsToBounds = false
        }
        
        for item in [hTopInstrument,vTopInstrument] {
            item?.layer.masksToBounds = true
            item?.layer.cornerRadius = 20
        }

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
