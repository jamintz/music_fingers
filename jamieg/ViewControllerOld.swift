////
////  ViewController.swift
////  jamieg
////
////  Created by Jason Mintz on 10/9/17.
////  Copyright © 2017 Jason Mintz. All rights reserved.
////
//
//import UIKit
//
//class ViewControllerOld: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//
//    @IBOutlet weak var customPicker: UIPickerView!
//    @IBOutlet weak var nLabel: UILabel!
//    @IBOutlet weak var noNote: UILabel!
//    @IBOutlet weak var infoLabel: UILabel!
//
//    @IBOutlet weak var leftCircle: UIImageView!
//    @IBOutlet weak var midCircle: UIImageView!
//    @IBOutlet weak var rightCircle: UIImageView!
//    @IBOutlet weak var staff: UIImageView!
//    @IBOutlet weak var slider: UISlider!
//
//    var pickerData = [String]()
//    var trumpFingers = [Int:[Int]]()
//    var trumpCode = [Int]()
//    var trombPositions = [Int:String]()
//    var allNotes = [String]()
//
//    let imageView = UIImageView(image: UIImage(named:"1.png")!)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        customPicker.delegate=self
//        customPicker.dataSource = self
//        staff.image = UIImage(named:"empty.png")
//
//        infoLabel.isHidden = true
//
//        imageView.frame = CGRect(x: view.frame.maxX/2-150, y: nLabel.frame.maxY, width: 300, height: 100)
//        view.addSubview(imageView)
//        imageView.isHidden = true
//
//        pickerData = ["Instruments","Trumpet","Trombone"]
//
//        allNotes = ["C-6","B-5","A# (Bb)-5","A-5","G# (Ab)-5","G-5","F# (Gb)-5","F-5","E-5","D# (Eb)-5","D-5","C# (Db)-5","C-5","B-4",
//                       "A# (Bb)-4","A-4","G# (Ab)-4","G-4","F# (Gb)-4","F-4","E-4","D# (Eb)-4","D-4","C# (Db)-4","C-4","B-3",
//                       "A# (Bb)-3","A-3","G# (Ab)-3","G-3","F# (Gb)-3","F-3","E-3","D# (Eb)-3","D-3","C# (Db)-3","C-3","B-2","A# (Bb)-2","A-2","G# (Ab)-2","G-2","F# (Gb)-2","F-2","E-2","D# (Eb)-2","D-2","C# (Db)-2","C-2"]
//
//        slider.maximumValue = 0
//        slider.minimumValue = Float(allNotes.count-1) * -1
//        slider.value = 0
//
//        trumpFingers = [0:[0,0,0],1:[0,1,0],2:[1,0,0],3:[1,1,0],4:[0,1,1],5:[0,0,0],6:[0,1,0],7:[1,0,0],8:[0,0,0],9:[0,1,0],10:[1,0,0],11:[1,1,0],12:[0,0,0],13:[0,1,0],14:[1,0,0],15:[1,1,0],16:[0,1,1],17:[0,0,0],18:[0,1,0],19:[1,0,0],20:[1,1,0],21:[0,1,1],22:[1,0,1],23:[1,1,1],24:[0,0,0],25:[0,1,0],26:[1,0,0],27:[1,1,0],28:[0,1,1],29:[1,0,1],30:[1,1,1]
//        ]
//
//        trombPositions = [13:"2",14:"1",15:"2",16:"3",17:"2",18:"3",19:"1",20:"2",21:"3",22:"1",23:"2",24:"3",25:"4",26:"1",27:"2",28:"3",29:"4",30:"5",31:"1",32:"2",33:"3",34:"4",35:"5",36:"6",37:"7",38:"1",39:"2",40:"3",41:"4",42:"5",43:"6",44:"7"]
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row] as String
//    }
//
//    func doTrumpet(ind:Int) {
//        imageView.isHidden = true
//
//        if trumpFingers[ind] == nil{
//            leftCircle.isHidden = true
//            midCircle.isHidden = true
//            rightCircle.isHidden = true
//            noNote.isHidden = false
//            return
//        }
//        leftCircle.isHidden = false
//        midCircle.isHidden = false
//        rightCircle.isHidden = false
//        trumpCode = trumpFingers[ind]!
//
//        for (ind,circ) in [leftCircle,midCircle,rightCircle].enumerated() {
//            circ?.layer.borderWidth = 1
//            circ?.layer.masksToBounds = false
//            circ?.layer.borderColor = UIColor.black.cgColor
//            circ?.layer.backgroundColor = UIColor.white.cgColor
//            circ?.layer.cornerRadius = (circ?.frame.height)!/2
//            circ?.clipsToBounds = true
//
//            if trumpCode[ind] == 1 {
//                circ?.layer.backgroundColor = UIColor.black.cgColor
//            }
//        }
//    }
//
//    func doTrombone(ind:Int) {
//        leftCircle.isHidden = true
//        midCircle.isHidden = true
//        rightCircle.isHidden = true
//
//        if trombPositions[ind] == nil {
//            imageView.isHidden = true
//            noNote.isHidden = false
//            return
//        }
//
//        imageView.isHidden = false
//        let imName = "t"+trombPositions[ind]! + ".png"
//        imageView.image = UIImage(named:imName)
//    }
//
//    @IBAction func moveSlider(_ sender: Any) {
//        let ind = abs(slider.value)
//        moveNote(ind:Int(ind))
//    }
//
//    func moveNote(ind:Int){
//        let instrInd = customPicker.selectedRow(inComponent: 0)
//        let instr = pickerData[instrInd]
//
//        if ind == 0 || instrInd == 0 {
//            staff.image = UIImage(named:"empty.png")
//
//            noNote.isHidden = true
//            leftCircle.isHidden = true
//            midCircle.isHidden = true
//            rightCircle.isHidden = true
//            nLabel.isHidden = false
//            infoLabel.isHidden = true
//
//            if ind != 0 {
//                staff.image = UIImage(named:String(ind-1)+".png")
//            }
//            return
//        }
//
//        noNote.isHidden = true
//        infoLabel.isHidden = false
//        nLabel.isHidden = true
//
//        let note = allNotes[ind]
//        infoLabel.text = instr + ": " + note
//
//
//        staff.image = UIImage(named:String(ind-1)+".png")
//
//        if instr == "Trumpet" {
//            doTrumpet(ind:ind)
//        } else if instr == "Trombone"{
//            doTrombone(ind:ind)
//        }
//
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        moveNote(ind:Int(abs(slider.value)))
//
//    }
//}
//
//
//
