//
//  ViewController.swift
//  jamieg
//
//  Created by Jason Mintz on 10/9/17.
//  Copyright © 2017 Jason Mintz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var customPicker: UIPickerView!
    @IBOutlet weak var nLabel: UILabel!
    @IBOutlet weak var fingering: UIImageView!

    @IBOutlet weak var leftCircle: UIImageView!
    @IBOutlet weak var midCircle: UIImageView!
    @IBOutlet weak var rightCircle: UIImageView!
    
    var pickerData: [[String]] = [[String]]()
    var trumpFingers = [[Int]]()
    var trumpCode = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customPicker.delegate=self
        customPicker.dataSource = self
        
        pickerData = [["Trumpet"],
                      ["C","B","A# (Bb)","A","G# (Ab)","G","F# (Gb)","F","E","D# (Eb)","D","C# (Db)","C","B",
                       "A# (Bb)","A","G# (Ab)","G","F# (Gb)","F","E","D# (Eb)","D","C# (Db)","C","B",
                       "A# (Bb)","A","G# (Ab)","G","F# (Gb)"]]
        
        trumpFingers = [[0,0,0],[0,1,0],[1,0,0],[1,1,0],[0,1,1],[0,0,0],[0,1,0],[1,0,0],[0,0,0],[0,1,0],
                        [1,0,0],[1,1,0],[0,0,0],[0,1,0],[1,0,0],[1,1,0],[0,1,1],[0,0,0],[0,1,0],[1,0,0],
                        [1,1,0],[0,1,1],[1,0,1],[1,1,1],[0,0,0],[0,1,0],[1,0,0],[1,1,0],[0,1,1],[1,0,1],[1,1,1]
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row] as String
    }
    
    func trumpet() {
        trumpCode = trumpFingers[customPicker.selectedRow(inComponent: 1)]
        
        for (ind,circ) in [leftCircle,midCircle,rightCircle].enumerated() {
            circ?.layer.borderWidth = 1
            circ?.layer.masksToBounds = false
            circ?.layer.borderColor = UIColor.black.cgColor
            circ?.layer.backgroundColor = UIColor.white.cgColor
            circ?.layer.cornerRadius = (circ?.frame.height)!/2
            circ?.clipsToBounds = true
            
            if trumpCode[ind] == 1 {
                circ?.layer.backgroundColor = UIColor.black.cgColor
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let instr = pickerData[0][customPicker.selectedRow(inComponent: 0)]
        let note = pickerData[1][customPicker.selectedRow(inComponent: 1)]
        nLabel.text = instr + ": " + note
        nLabel.font = nLabel.font.withSize(30)
        
        if instr == "Trumpet" {
            trumpet()
        }
        
    }
}

