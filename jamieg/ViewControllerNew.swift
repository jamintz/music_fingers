//
//  ViewControllerNew.swift
//  Jamie's Magic Fingers
//
//  Created by Jason Mintz on 11/19/17.
//  Copyright © 2017 Jason Mintz. All rights reserved.
//

import UIKit

class ViewControllerNew: UIView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderChanged(_ sender: Any) {
        label.text = String(slider.value)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
