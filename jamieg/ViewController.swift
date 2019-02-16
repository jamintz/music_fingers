//
//  ViewController.swift
//  Jamie"s Magic Fingers
//
//  Created by Jason Mintz on 11/26/17.
//  Copyright © 2017 Jason Mintz. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var vStaffShadow: UIView!
    @IBOutlet weak var hStaffShadow: UIView!
    @IBOutlet weak var chooseInstrument: UILabel!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var vInstrumentShadow: UIView!
    @IBOutlet weak var hInstrumentShadow: UIView!
    
    @IBOutlet weak var topAd: GADBannerView!
    @IBOutlet weak var adView: GADBannerView!
    @IBOutlet weak var buttonBackground: UIImageView!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var pickerBackground: UIView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var vInstrument: UIImageView!
    @IBOutlet weak var vStaff: UIImageView!
    @IBOutlet weak var hInstrument: UIImageView!
    @IBOutlet weak var hStaff: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var pageChooser: UIPageControl!
    
    @IBOutlet weak var flatButton: UIButton!
    @IBOutlet weak var naturalButton: UIButton!
    @IBOutlet weak var sharpButton: UIButton!
    
    var instruments = [String]()
    var hInstruments = [String]()
    var vInstruments = [String]()
    
    var ind = Int()
    
    var pos = [String:[String:[String]]]()
    
    let customBlue = UIColor(red:38/255.0,green:208/255.0,blue:206/255.0,alpha:1)
    
    let customLightBlue = UIColor.clear
    
    var minMax = [String:[String:Int]]()
    var vList = [[String:String]]()

    var trebInstruments = [String]()
    var bassInstruments = [String]()

    func getStatus() -> [String] {
        let instr = instruments[picker.selectedRow(inComponent: 0)]
        let sliderVal = round(slider.value)
        var note = ""
        var key = ""
        
        if trebInstruments.contains(instr){
            note = tNotes[Int(sliderVal)]
        } else {
            note = bNotes[Int(sliderVal)]
        }
        
        if flatButton.isSelected{
            key = "b"
        } else if sharpButton.isSelected{
            key = "#"
        } else {
            key = ""
        }
        
        var imgList = [String]()
        var noteDict = pos[note+key]
        if noteDict![instr] != nil {
            imgList = noteDict![instr]!
        }
        return imgList
    }
    
    var bNotes = [String]()
    var tNotes = [String]()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return instruments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return instruments[row] as String
    }
    
    override func viewDidLayoutSubviews() {
        let startColor = UIColor(red:26/255.0,green:41/255.0,blue:128/255.0,alpha:1)
        let endColor = UIColor(red:38/255.0,green:208/255.0,blue:206/255.0,alpha:1)
        let gradient = CAGradientLayer()
        gradient.frame = backgroundTop.bounds
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        backgroundTop.layer.insertSublayer(gradient, at: 0)
        
        let pEndColor = UIColor(red:255/255.0,green:255/255.0,blue:255/255.0,alpha:1)
        let pStartColor = UIColor(red:38/255.0,green:208/255.0,blue:206/255.0,alpha:1)
        let pGradient = CAGradientLayer()
        pGradient.frame = backgroundTop.bounds
        pGradient.colors = [pStartColor.cgColor, pEndColor.cgColor]
        pickerBackground.layer.insertSublayer(pGradient, at: 0)
        
        buttonBackground.layer.borderColor = UIColor.black.cgColor
        buttonBackground.layer.borderWidth = 0.5
        buttonBackground.backgroundColor = UIColor.clear
        
        slider.backgroundColor = UIColor.clear
        slider.isContinuous = false

        sharpButton.layer.borderWidth = 0
        flatButton.layer.borderWidth = 0
        naturalButton.layer.borderWidth = 0
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let instr = defaults.integer(forKey: "Instrument")

        if(instr != 0){
            picker.selectRow(instr, inComponent: 0, animated: true)
            picker.delegate?.pickerView?(picker, didSelectRow: instr, inComponent: 0)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adView.rootViewController = self
        adView.adUnitID = "ca-app-pub-6748094605248065/1511591757"
        adView.load(GADRequest())
                
        picker.delegate = self
        picker.dataSource = self
        
        flatButton.backgroundColor = customLightBlue
        sharpButton.backgroundColor = customLightBlue
        naturalButton.backgroundColor = customBlue
        flatButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        sharpButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        naturalButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        flatButton.layer.borderWidth = 1
        flatButton.layer.borderColor = UIColor.black.cgColor
        naturalButton.layer.borderWidth = 1
        naturalButton.layer.borderColor = UIColor.black.cgColor
        sharpButton.layer.borderWidth = 1
        sharpButton.layer.borderColor = UIColor.black.cgColor
        flatButton.isSelected = false
        naturalButton.isSelected = true
        sharpButton.isSelected = false
        
        for lay in [hStaffShadow, vStaffShadow, hInstrumentShadow, vInstrumentShadow]{
            lay?.layer.shadowColor = UIColor.black.cgColor
            lay?.layer.shadowOpacity = 1
            lay?.layer.shadowRadius = 10
            lay?.clipsToBounds = false
        }
        
        chooseInstrument.isHidden = false
        
        for item in [hStaff,vStaff,hInstrument,vInstrument] {
            item?.layer.masksToBounds = true
            item?.layer.cornerRadius = 20
        }
        
        slider.layer.masksToBounds = true
        slider.layer.cornerRadius = 15
        
        ind = 0
    
        vInstrument.isHidden = true
        vStaffShadow.isHidden = true
        hInstrument.isHidden = true
        hStaffShadow.isHidden = true
        vInstrumentShadow.isHidden = true
        hInstrumentShadow.isHidden = true
        vStaff.isHidden = true
        hStaff.isHidden = true
        
        minMax = ["Tenor Recorder (C)":["Minimum":21,"Maximum":39],"Bass Recorder (F)":["Minimum":10,"Maximum":26],"Alto Recorder (F)":["Minimum":24,"Maximum":39],"Great Bass Recorder (C)":["Minimum":7,"Maximum":22],"Alto Sax":["Minimum":20,"Maximum":42],"Baritone Sax":["Minimum":19,"Maximum":42],"Clarinet":["Minimum":16,"Maximum":38],"Euphonium":["Minimum":7,"Maximum":27],"Flute":["Minimum":20,"Maximum":42],"French Horn":["Minimum":14,"Maximum":35],"Tenor Sax":["Minimum":20,"Maximum":42],"Trombone":["Minimum":9,"Maximum":27],"Trumpet":["Minimum":18,"Maximum":35],"Soprano Recorder (C)":["Minimum":21,"Maximum":35],"Bassoon":["Minimum":5,"Maximum":29],"Tuba":["Minimum":1,"Maximum":27],"Oboe":["Minimum":19,"Maximum":38]]
        
        instruments = ["Instruments","Alto Sax","Baritone Sax","Bassoon","Clarinet","Euphonium","Flute","French Horn","Oboe","Tenor Sax","Trombone","Trumpet","Tuba","Alto Recorder (F)","Bass Recorder (F)","Great Bass Recorder (C)","Tenor Recorder (C)","Soprano Recorder (C)"]
        hInstruments = ["Trombone","Flute","Trumpet","Euphonium","French Horn","Tuba"]
        vInstruments = ["Clarinet","Alto Sax","Tenor Sax","Baritone Sax","Soprano Recorder (C)","Bassoon","Oboe","Great Bass Recorder (C)","Alto Recorder (F)","Tenor Recorder (C)","Bass Recorder (F)"]
        
        trebInstruments = ["Trumpet","Flute","Clarinet","Alto Sax","Tenor Sax","Baritone Sax","French Horn","Soprano Recorder (C)","Oboe","Alto Recorder (F)","Tenor Recorder (C)"]
        bassInstruments = ["Trombone","Euphonium","Bassoon","Tuba","Great Bass Recorder (C)","Bass Recorder (F)"]
        

        pos = [
            "C1":[:],
            "D1":["Tuba":["15","9"]],
            "E1":["Tuba":["13","20"]],
            "F1":["Tuba":["11","18"]],
            "G1":["Tuba":["17","10"]],
            "A1":["Tuba":["15"]],
            "B1":["Bassoon":["1"],"Tuba":["13","20"]],
            "C2":["Great Bass Recorder (C)":["1"],"Euphonium":["23"],"Bassoon":["2"],"Tuba":["11","18"]],
            "D2":["Great Bass Recorder (C)":["3"],"Euphonium":["15"],"Bassoon":["4"],"Tuba":["17","10"]],
            "E2":["Great Bass Recorder (C)":["5"],"Trombone":["7"],"Euphonium":["13","20"],"Bassoon":["6"],"Tuba":["9"]],
            "F2":["Bass Recorder (F)":["1"],"Great Bass Recorder (C)":["6"],"Trombone":["6"],"Euphonium":["11","18"],"Bassoon":["7"],"Tuba":["8","18"]],
            "G2":["Bass Recorder (F)":["3"],"Great Bass Recorder (C)":["8"],"Trombone":["4"],"Euphonium":["17","10"],"Bassoon":["9"],"Tuba":["17","10"]],
            "A2":["Bass Recorder (F)":["5"],"Great Bass Recorder (C)":["10"],"Trombone":["2"],"Euphonium":["9"],"Bassoon":["11"],"Tuba":["9"]],
            "B2":["Bass Recorder (F)":["7"],"Great Bass Recorder (C)":["12"],"Trombone":["7"],"Euphonium":["20","13"],"Bassoon":["13"],"Tuba":["17","10"]],
            "C3":["Bass Recorder (F)":["8"],"Great Bass Recorder (C)":["13"],"Trombone":["6"],"Euphonium":["11","18"],"French Horn":["0"],"Bassoon":["14"],"Tuba":["16","18"]],
            "D3":["Bass Recorder (F)":["10"],"Great Bass Recorder (C)":["14"],"Trombone":["4"],"Euphonium":["17","10"],"French Horn":["2"],"Bassoon":["16"],"Tuba":["8","17"]],
            "E3":["Bass Recorder (F)":["12"],"Great Bass Recorder (C)":["17"],"Trombone":["2","7"],"Euphonium":["9"],"French Horn":["4"],"Clarinet":["1","2","3"],"Bassoon":["18"],"Tuba":["9","12"]],
            "F3":["Bass Recorder (F)":["13"],"Great Bass Recorder (C)":["18"],"Trombone":["1","6"],"Euphonium":["8"],"French Horn":["5"],"Clarinet":["4","5"],"Bassoon":["19"],"Tuba":["8","17"]],
            "G3":["Bass Recorder (F)":["17"],"Great Bass Recorder (C)":["20"],"Trombone":["4"],"Trumpet":["5"],"Euphonium":["18","10"],"French Horn":["7"],"Clarinet":["7"],"Bassoon":["21"],"Tuba":["17","10"]],
            "A3":["Bass Recorder (F)":["19"],"Great Bass Recorder (C)":["22"],"Trombone":["2","6"],"Trumpet":["4"],"Euphonium":["9"],"Baritone Sax":["0"],"French Horn":["39"],"Clarinet":["11"],"Bassoon":["23"],"Tuba":["9","17","18"]],
            "B3":["Bass Recorder (F)":["21"],"Great Bass Recorder (C)":["24","25"],"Flute":["37"],"Trombone":["4","7"],"Trumpet":["2"],"Euphonium":["17"],"Tenor Sax":["2"],"Alto Sax":["2"],"Baritone Sax":["2"],"French Horn":["11"],"Clarinet":["13","14"],"Bassoon":["25"],"Tuba":["17","10","13"],"Oboe":["3"]],
            "C4":["Tenor Recorder (C)":["1"],"Bass Recorder (F)":["22"],"Great Bass Recorder (C)":["26"],"Soprano Recorder (C)":["1"],"Trombone":["3","6"],"Trumpet":["0"],"Euphonium":["16","18"],"Flute":["0"],"Tenor Sax":["3"],"Alto Sax":["3"],"Baritone Sax":["3"],"French Horn":["12"],"Clarinet":["15"],"Bassoon":["26"],"Tuba":["16","8","18"],"Oboe":["4","5"]],
            "D4":["Tenor Recorder (C)":["3"],"Bass Recorder (F)":["25"],"Great Bass Recorder (C)":["28"],"Soprano Recorder (C)":["3"],"Trombone":["1","4","7"],"Trumpet":["5"],"Euphonium":["8","17"],"Flute":["2"],"Tenor Sax":["5"],"Alto Sax":["5"],"Baritone Sax":["5"],"French Horn":["14"],"Clarinet":["17"],"Bassoon":["28"],"Tuba":["8","17","20"],"Oboe":["7"]],
            "E4":["Tenor Recorder (C)":["5"],"Bass Recorder (F)":["28"],"Soprano Recorder (C)":["5"],"Trombone":["2","5","7"],"Trumpet":["4"],"Euphonium":["9"],"Flute":["4"],"Tenor Sax":["7"],"Alto Sax":["7"],"Baritone Sax":["7"],"French Horn":["16"],"Clarinet":["21"],"Bassoon":["30"],"Tuba":["9","12"],"Oboe":["10"]],
            "F4":["Tenor Recorder (C)":["6"],"Alto Recorder (F)":["2"],"Bass Recorder (F)":["29"],"Soprano Recorder (C)":["6"],"Trombone":["1","4","6"],"Trumpet":["1"],"Euphonium":["8"],"Flute":["5"],"Tenor Sax":["8"],"Alto Sax":["8"],"Baritone Sax":["8"],"French Horn":["17"],"Clarinet":["22"],"Bassoon":["31"],"Tuba":["8","17"],"Oboe":["11","12","13"]],
            "G4":["Tenor Recorder (C)":["8"],"Alto Recorder (F)":["3"],"Bass Recorder (F)":["31"],"Soprano Recorder (C)":["8"],"Trombone":["2","4","6"],"Trumpet":["0"],"Euphonium":["17","10"],"Flute":["7"],"Tenor Sax":["10"],"Alto Sax":["10"],"Baritone Sax":["10"],"French Horn":["19"],"Clarinet":["25"],"Bassoon":["33"],"Tuba":["17","9"],"Oboe":["15"]],
            "A4":["Tenor Recorder (C)":["10"],"Alto Recorder (F)":["5"],"Bass Recorder (F)":["33"],"Soprano Recorder (C)":["10"],"Trombone":["2","4","6"],"Trumpet":["4"],"Euphonium":["9"],"Flute":["9"],"Tenor Sax":["12"],"Alto Sax":["12"],"Baritone Sax":["12"],"French Horn":["21"],"Clarinet":["27","28","29"],"Bassoon":["35"],"Tuba":["9"],"Oboe":["18"]],
            "B4":["Tenor Recorder (C)":["13","14"],"Alto Recorder (F)":["7"],"Soprano Recorder (C)":["12"],"Trombone":["2","4","6"],"Trumpet":["2"],"Euphonium":["9","17"],"Flute":["11"],"Tenor Sax":["14"],"Alto Sax":["14"],"Baritone Sax":["14"],"French Horn":["23"],"Clarinet":["33","34","35"],"Bassoon":["37"],"Oboe":["20"]],
            "C5":["Tenor Recorder (C)":["15"],"Alto Recorder (F)":["8"],"Soprano Recorder (C)":["13"],"Trumpet":["0"],"Flute":["12"],"Tenor Sax":["15"],"Alto Sax":["15"],"Baritone Sax":["15"],"French Horn":["24"],"Clarinet":["36","37"],"Bassoon":["38"],"Oboe":["21"]],
            "D5":["Tenor Recorder (C)":["19"],"Alto Recorder (F)":["10"],"Soprano Recorder (C)":["15"],"Trumpet":["1"],"Flute":["14"],"Tenor Sax":["17"],"Alto Sax":["17"],"Baritone Sax":["17"],"French Horn":["26"],"Clarinet":["41"],"Bassoon":["40"],"Oboe":["23"]],
            "E5":["Tenor Recorder (C)":["21"],"Alto Recorder (F)":["11","12"],"Soprano Recorder (C)":["17"],"Trumpet":["0"],"Flute":["16"],"Tenor Sax":["19"],"Alto Sax":["19"],"Baritone Sax":["19"],"French Horn":["28"],"Clarinet":["43"],"Oboe":["26"]],
            "F5":["Tenor Recorder (C)":["22"],"Alto Recorder (F)":["14"],"Soprano Recorder (C)":["8"],"Trumpet":["1"],"Flute":["17"],"Tenor Sax":["20"],"Alto Sax":["20"],"Baritone Sax":["20"],"French Horn":["29"],"Clarinet":["44"],"Oboe":["27","28","29"]],
            "G5":["Tenor Recorder (C)":["24"],"Alto Recorder (F)":["17"],"Soprano Recorder (C)":["20"],"Trumpet":["0"],"Flute":["19"],"Tenor Sax":["22"],"Alto Sax":["22"],"Baritone Sax":["22"],"French Horn":["31"],"Clarinet":["47"],"Oboe":["31"]],
            "A5":["Tenor Recorder (C)":["26"],"Alto Recorder (F)":["19"],"Soprano Recorder (C)":["22"],"Trumpet":["4"],"Flute":["21"],"Tenor Sax":["24"],"Alto Sax":["24"],"Baritone Sax":["24"],"French Horn":["33"],"Clarinet":["49"],"Oboe":["34","35"]],
            "B5":["Tenor Recorder (C)":["28"],"Alto Recorder (F)":["21"],"Soprano Recorder (C)":["24","25"],"Trumpet":["2"],"Flute":["23"],"Tenor Sax":["26"],"Alto Sax":["26"],"Baritone Sax":["26"],"French Horn":["35"],"Clarinet":["53"],"Oboe":["37"]],
            "C6":["Tenor Recorder (C)":["29"],"Alto Recorder (F)":["22"],"Soprano Recorder (C)":["26"],"Trumpet":["0"],"Flute":["24"],"Tenor Sax":["27"],"Alto Sax":["27"],"Baritone Sax":["27"],"French Horn":["36"],"Clarinet":["54"],"Oboe":["38"]],
            "D6":["Tenor Recorder (C)":["31"],"Alto Recorder (F)":["24"],"Soprano Recorder (C)":["28"],"Flute":["26"],"Tenor Sax":["29"],"Alto Sax":["29"],"Baritone Sax":["29"],"Clarinet":["58"],"Oboe":["41","42"]],
            "E6":["Tenor Recorder (C)":["33","34"],"Alto Recorder (F)":["26","27"],"Flute":["28"],"Tenor Sax":["31"],"Alto Sax":["31"],"Baritone Sax":["31"],"Clarinet":["59"],"Oboe":["44","45"]],
            "F6":["Tenor Recorder (C)":["35"],"Alto Recorder (F)":["28"],"Flute":["29"],"Tenor Sax":["32"],"Alto Sax":["32"],"Baritone Sax":["32"],"Clarinet":["60","61"],"Oboe":["46","47"]],
            "G6":["Tenor Recorder (C)":["37"],"Alto Recorder (F)":["30"],"Flute":["31"],"Tenor Sax":["34"],"Alto Sax":["34"],"Baritone Sax":["34"]],
            "A6":["Flute":["33"],"Tenor Sax":["36"],"Alto Sax":["36"],"Baritone Sax":["36"]],
            "B6":["Flute":["35"],"Tenor Sax":["38"],"Alto Sax":["38"],"Baritone Sax":["38"]],
            "C7":["Flute":["36"],"Tenor Sax":["39"],"Alto Sax":["39"],"Baritone Sax":["39"]],
            "C1#":[:],
            "D1#":["Tuba":["21","8"]],
            "E1#":["Tuba":["11","18"]],
            "F1#":["Tuba":["12"]],
            "G1#":["Tuba":["16"]],
            "A1#":["Bassoon":["0"],"Tuba":["8"]],
            "B1#":["Great Bass Recorder (C)":["1"],"Euphonium":["23"],"Bassoon":["2"],"Tuba":["11","18"]],
            "C2#":["Great Bass Recorder (C)":["2"],"Euphonium":["21"],"Bassoon":["3"],"Tuba":["12"]],
            "D2#":["Great Bass Recorder (C)":["4"],"Euphonium":["21"],"Bassoon":["5"],"Tuba":["16"]],
            "E2#":["Bass Recorder (F)":["1"],"Great Bass Recorder (C)":["6"],"Trombone":["6"],"Euphonium":["11","18"],"Bassoon":["7"],"Tuba":["8","18"]],
            "F2#":["Bass Recorder (F)":["2"],"Great Bass Recorder (C)":["7"],"Trombone":["5"],"Euphonium":["12"],"Bassoon":["8"],"Tuba":["12"]],
            "G2#":["Bass Recorder (F)":["4"],"Great Bass Recorder (C)":["9"],"Trombone":["3"],"Euphonium":["16"],"Bassoon":["10"],"Tuba":["16"]],
            "A2#":["Bass Recorder (F)":["6"],"Great Bass Recorder (C)":["11"],"Trombone":["1"],"Euphonium":["8"],"Bassoon":["12"],"Tuba":["8"]],
            "B2#":["Bass Recorder (F)":["8"],"Great Bass Recorder (C)":["13"],"Trombone":["6"],"Euphonium":["11","18"],"French Horn":["0"],"Bassoon":["14"],"Tuba":["16","18"]],
            "C3#":["Bass Recorder (F)":["9"],"Great Bass Recorder (C)":["15"],"Trombone":["5"],"Euphonium":["12"],"French Horn":["1"],"Bassoon":["15"],"Tuba":["9","12"]],
            "D3#":["Bass Recorder (F)":["11"],"Great Bass Recorder (C)":["16"],"Trombone":["3"],"Euphonium":["16"],"French Horn":["3"],"Bassoon":["17"],"Tuba":["16","18"]],
            "E3#":["Bass Recorder (F)":["13"],"Great Bass Recorder (C)":["18"],"Trombone":["1","6"],"Euphonium":["8"],"French Horn":["5"],"Clarinet":["4","5"],"Bassoon":["19"],"Tuba":["8","17"]],
            "F3#":["Bass Recorder (F)":["14","15","16"],"Great Bass Recorder (C)":["19"],"Trombone":["5"],"Trumpet":["7"],"Euphonium":["12"],"French Horn":["6"],"Clarinet":["6","7","8"],"Bassoon":["20"],"Tuba":["12","16"]],
            "G3#":["Bass Recorder (F)":["18"],"Great Bass Recorder (C)":["21"],"Trombone":["3","7"],"Trumpet":["6"],"Euphonium":["16"],"French Horn":["8"],"Clarinet":["10"],"Bassoon":["22"],"Tuba":["16","8"]],
            "A3#":["Bass Recorder (F)":["20"],"Great Bass Recorder (C)":["23"],"Trombone":["1","5"],"Trumpet":["1"],"Euphonium":["8"],"Tenor Sax":["1"],"Alto Sax":["1"],"Baritone Sax":["1"],"French Horn":["10"],"Clarinet":["12"],"Bassoon":["24"],"Tuba":["8","12","16"],"Oboe":["2"]],
            "B3#":["Tenor Recorder (C)":["1"],"Bass Recorder (F)":["22"],"Great Bass Recorder (C)":["26"],"Soprano Recorder (C)":["1"],"Trombone":["3","6"],"Trumpet":["0"],"Euphonium":["16","18"],"Flute":["0"],"Tenor Sax":["3"],"Alto Sax":["3"],"Baritone Sax":["3"],"French Horn":["12"],"Clarinet":["15"],"Bassoon":["26"],"Tuba":["16","8","18"],"Oboe":["4","5"]],
            "C4#":["Tenor Recorder (C)":["2"],"Bass Recorder (F)":["23","24"],"Great Bass Recorder (C)":["27"],"Soprano Recorder (C)":["2"],"Trombone":["2","5"],"Trumpet":["7"],"Euphonium":["9","12"],"Flute":["1"],"Tenor Sax":["4"],"Alto Sax":["4"],"Baritone Sax":["4"],"French Horn":["13"],"Clarinet":["16"],"Bassoon":["27"],"Tuba":["9","12"],"Oboe":["6"]],
            "D4#":["Tenor Recorder (C)":["4"],"Bass Recorder (F)":["26","27"],"Soprano Recorder (C)":["4"],"Trombone":["3","6"],"Trumpet":["6"],"Euphonium":["16"],"Flute":["6"],"Tenor Sax":["1"],"Alto Sax":["6"],"Baritone Sax":["6"],"French Horn":["15"],"Clarinet":["18","19","20"],"Bassoon":["29"],"Tuba":["16","18"],"Oboe":["8","9"]],
            "E4#":["Tenor Recorder (C)":["6"],"Alto Recorder (F)":["2"],"Bass Recorder (F)":["29"],"Soprano Recorder (C)":["6"],"Trombone":["1","4","6"],"Trumpet":["1"],"Euphonium":["8"],"Flute":["5"],"Tenor Sax":["8"],"Alto Sax":["8"],"Baritone Sax":["8"],"French Horn":["17"],"Clarinet":["22"],"Bassoon":["31"],"Tuba":["8","17"],"Oboe":["11","12","13"]],
            "F4#":["Tenor Recorder (C)":["7"],"Alto Recorder (F)":["1"],"Bass Recorder (F)":["30"],"Soprano Recorder (C)":["7"],"Trombone":["3","5","7"],"Trumpet":["2"],"Euphonium":["12"],"Flute":["3"],"Tenor Sax":["9"],"Alto Sax":["9"],"Baritone Sax":["9"],"French Horn":["18"],"Clarinet":["23","24"],"Bassoon":["32"],"Tuba":["12","16"],"Oboe":["14"]],
            "G4#":["Tenor Recorder (C)":["9"],"Alto Recorder (F)":["4"],"Bass Recorder (F)":["32"],"Soprano Recorder (C)":["9"],"Trombone":["3","5","7"],"Trumpet":["6"],"Euphonium":["16"],"Flute":["8"],"Tenor Sax":["11"],"Alto Sax":["11"],"Baritone Sax":["11"],"French Horn":["20"],"Clarinet":["26"],"Bassoon":["34"],"Tuba":["16","8","12"],"Oboe":["16","17"]],
            "A4#":["Tenor Recorder (C)":["11","12"],"Alto Recorder (F)":["6"],"Soprano Recorder (C)":["11"],"Trombone":["1","3","5"],"Trumpet":["1"],"Euphonium":["8"],"Flute":["10"],"Tenor Sax":["13"],"Alto Sax":["13"],"Baritone Sax":["13"],"French Horn":["22"],"Clarinet":["30","31","32"],"Bassoon":["36"],"Tuba":["8"],"Oboe":["19"]],
            "B4#":["Tenor Recorder (C)":["15"],"Alto Recorder (F)":["8"],"Soprano Recorder (C)":["13"],"Trumpet":["0"],"Flute":["12"],"Tenor Sax":["15"],"Alto Sax":["15"],"Baritone Sax":["15"],"French Horn":["24"],"Clarinet":["36","37"],"Bassoon":["38"],"Oboe":["21"]],
            "C5#":["Tenor Recorder (C)":["16","17","18"],"Alto Recorder (F)":["9"],"Soprano Recorder (C)":["14"],"Trumpet":["4"],"Flute":["13"],"Tenor Sax":["16"],"Alto Sax":["16"],"Baritone Sax":["16"],"French Horn":["25"],"Clarinet":["38","39","40"],"Bassoon":["39"],"Oboe":["22"]],
            "D5#":["Tenor Recorder (C)":["20"],"Alto Recorder (F)":["13"],"Soprano Recorder (C)":["16"],"Trumpet":["2"],"Flute":["15"],"Tenor Sax":["18"],"Alto Sax":["18"],"Baritone Sax":["18"],"French Horn":["27"],"Clarinet":["42"],"Oboe":["24","25"]],
            "E5#":["Tenor Recorder (C)":["22"],"Alto Recorder (F)":["14"],"Soprano Recorder (C)":["8"],"Trumpet":["1"],"Flute":["17"],"Tenor Sax":["20"],"Alto Sax":["20"],"Baritone Sax":["20"],"French Horn":["29"],"Clarinet":["44"],"Oboe":["27","28","29"]],
            "F5#":["Tenor Recorder (C)":["23"],"Alto Recorder (F)":["15","16"],"Soprano Recorder (C)":["19"],"Trumpet":["2"],"Flute":["18"],"Tenor Sax":["21"],"Alto Sax":["21"],"Baritone Sax":["21"],"French Horn":["30"],"Clarinet":["45","46"],"Oboe":["30"]],
            "G5#":["Tenor Recorder (C)":["25"],"Alto Recorder (F)":["18"],"Soprano Recorder (C)":["21"],"Trumpet":["6"],"Flute":["20"],"Tenor Sax":["23"],"Alto Sax":["23"],"Baritone Sax":["23"],"French Horn":["32"],"Clarinet":["48"],"Oboe":["32","33"]],
            "A5#":["Tenor Recorder (C)":["27"],"Alto Recorder (F)":["20"],"Soprano Recorder (C)":["23"],"Trumpet":["1"],"Flute":["22"],"Tenor Sax":["25"],"Alto Sax":["25"],"Baritone Sax":["25"],"French Horn":["34"],"Clarinet":["50","51","52"],"Oboe":["36"]],
            "B5#":["Tenor Recorder (C)":["29"],"Alto Recorder (F)":["22"],"Soprano Recorder (C)":["26"],"Trumpet":["0"],"Flute":["24"],"Tenor Sax":["27"],"Alto Sax":["27"],"Baritone Sax":["27"],"French Horn":["36"],"Clarinet":["54"],"Oboe":["38"]],
            "C6#":["Tenor Recorder (C)":["30"],"Alto Recorder (F)":["23"],"Soprano Recorder (C)":["27"],"Flute":["25"],"Tenor Sax":["28"],"Alto Sax":["28"],"Baritone Sax":["28"],"Clarinet":["55"],"Oboe":["39","40"]],
            "D6#":["Tenor Recorder (C)":["32"],"Alto Recorder (F)":["25"],"Flute":["27"],"Tenor Sax":["30"],"Alto Sax":["30"],"Baritone Sax":["30"],"Clarinet":["57","58"],"Oboe":["43"]],
            "E6#":["Tenor Recorder (C)":["35"],"Alto Recorder (F)":["28"],"Flute":["29"],"Tenor Sax":["32"],"Alto Sax":["32"],"Baritone Sax":["32"],"Clarinet":["60","61"],"Oboe":["46","47"]],
            "F6#":["Tenor Recorder (C)":["36"],"Alto Recorder (F)":["29"],"Flute":["30"],"Tenor Sax":["33"],"Alto Sax":["33"],"Baritone Sax":["33"]],
            "G6#":["Flute":["32"],"Tenor Sax":["35"],"Alto Sax":["35"],"Baritone Sax":["35"]],
            "A6#":["Flute":["34"],"Tenor Sax":["37"],"Alto Sax":["37"],"Baritone Sax":["37"]],
            "B6#":["Flute":["36"],"Tenor Sax":["39"],"Alto Sax":["39"],"Baritone Sax":["39"]],
            "C7#":[:],
            "C1b":[:],
            "D1b":[:],
            "E1b":["Tuba":["21","8"]],
            "F1b":["Tuba":["13","20"]],
            "G1b":["Tuba":["12"]],
            "A1b":["Tuba":["16"]],
            "B1b":["Bassoon":["0"],"Tuba":["8"]],
            "C2b":["Bassoon":["1"],"Tuba":["13","20"]],
            "D2b":["Great Bass Recorder (C)":["2"],"Euphonium":["21"],"Bassoon":["3"],"Tuba":["12"]],
            "E2b":["Great Bass Recorder (C)":["4"],"Euphonium":["21"],"Bassoon":["5"],"Tuba":["16"]],
            "F2b":["Great Bass Recorder (C)":["5"],"Trombone":["7"],"Euphonium":["13","20"],"Bassoon":["6"],"Tuba":["9"]],
            "G2b":["Bass Recorder (F)":["2"],"Great Bass Recorder (C)":["7"],"Trombone":["5"],"Euphonium":["12"],"Bassoon":["8"],"Tuba":["12"]],
            "A2b":["Bass Recorder (F)":["4"],"Great Bass Recorder (C)":["9"],"Trombone":["3"],"Euphonium":["16"],"Bassoon":["10"],"Tuba":["16"]],
            "B2b":["Bass Recorder (F)":["6"],"Great Bass Recorder (C)":["11"],"Trombone":["1"],"Euphonium":["8"],"Bassoon":["12"],"Tuba":["8"]],
            "C3b":["Bass Recorder (F)":["7"],"Great Bass Recorder (C)":["12"],"Trombone":["7"],"Euphonium":["20","13"],"Bassoon":["13"],"Tuba":["17","10"]],
            "D3b":["Bass Recorder (F)":["9"],"Great Bass Recorder (C)":["15"],"Trombone":["5"],"Euphonium":["12"],"French Horn":["1"],"Bassoon":["15"],"Tuba":["9","12"]],
            "E3b":["Bass Recorder (F)":["11"],"Great Bass Recorder (C)":["16"],"Trombone":["3"],"Euphonium":["16"],"French Horn":["3"],"Bassoon":["17"],"Tuba":["16","18"]],
            "F3b":["Bass Recorder (F)":["12"],"Great Bass Recorder (C)":["17"],"Trombone":["2","7"],"Euphonium":["9"],"French Horn":["4"],"Clarinet":["1","2","3"],"Bassoon":["18"],"Tuba":["9","12"]],
            "G3b":["Bass Recorder (F)":["14","15","16"],"Great Bass Recorder (C)":["19"],"Trombone":["5"],"Trumpet":["7"],"Euphonium":["12"],"French Horn":["6"],"Clarinet":["6","7","8"],"Bassoon":["20"],"Tuba":["12","16"]],
            "A3b":["Bass Recorder (F)":["18"],"Great Bass Recorder (C)":["21"],"Trombone":["3","7"],"Trumpet":["6"],"Euphonium":["16"],"French Horn":["8"],"Clarinet":["10"],"Bassoon":["22"],"Tuba":["16","8"]],
            "B3b":["Bass Recorder (F)":["20"],"Great Bass Recorder (C)":["23"],"Trombone":["1","5"],"Trumpet":["1"],"Euphonium":["8"],"Tenor Sax":["1"],"Alto Sax":["1"],"Baritone Sax":["1"],"French Horn":["10"],"Clarinet":["12"],"Bassoon":["24"],"Tuba":["8","12","16"],"Oboe":["2"]],
            "C4b":["Bass Recorder (F)":["21"],"Great Bass Recorder (C)":["24","25"],"Flute":["37"],"Trombone":["4","7"],"Trumpet":["2"],"Euphonium":["17"],"Tenor Sax":["2"],"Alto Sax":["2"],"Baritone Sax":["2"],"French Horn":["11"],"Clarinet":["13","14"],"Bassoon":["25"],"Tuba":["17","10","13"],"Oboe":["3"]],
            "D4b":["Tenor Recorder (C)":["2"],"Bass Recorder (F)":["23","24"],"Great Bass Recorder (C)":["27"],"Soprano Recorder (C)":["2"],"Trombone":["2","5"],"Trumpet":["7"],"Euphonium":["9","12"],"Flute":["1"],"Tenor Sax":["4"],"Alto Sax":["4"],"Baritone Sax":["4"],"French Horn":["13"],"Clarinet":["16"],"Bassoon":["27"],"Tuba":["9","12"],"Oboe":["6"]],
            "E4b":["Tenor Recorder (C)":["4"],"Bass Recorder (F)":["26","27"],"Soprano Recorder (C)":["4"],"Trombone":["3","6"],"Trumpet":["6"],"Euphonium":["16"],"Flute":["3"],"Tenor Sax":["6"],"Alto Sax":["6"],"Baritone Sax":["6"],"French Horn":["15"],"Clarinet":["18","19","20"],"Bassoon":["29"],"Tuba":["16","18"],"Oboe":["9","8"]],
            "F4b":["Tenor Recorder (C)":["5"],"Bass Recorder (F)":["28"],"Soprano Recorder (C)":["5"],"Trombone":["2","5","7"],"Trumpet":["4"],"Euphonium":["9"],"Flute":["4"],"Tenor Sax":["7"],"Alto Sax":["7"],"Baritone Sax":["7"],"French Horn":["16"],"Clarinet":["21"],"Bassoon":["30"],"Tuba":["9","12"],"Oboe":["10"]],
            "G4b":["Tenor Recorder (C)":["7"],"Alto Recorder (F)":["1"],"Bass Recorder (F)":["30"],"Soprano Recorder (C)":["7"],"Trombone":["3","5","7"],"Trumpet":["2"],"Euphonium":["12"],"Flute":["6"],"Tenor Sax":["9"],"Alto Sax":["9"],"Baritone Sax":["9"],"French Horn":["18"],"Clarinet":["23","24"],"Bassoon":["32"],"Tuba":["12","16"],"Oboe":["14"]],
            "A4b":["Tenor Recorder (C)":["9"],"Alto Recorder (F)":["4"],"Bass Recorder (F)":["32"],"Soprano Recorder (C)":["9"],"Trombone":["3","5","7"],"Trumpet":["6"],"Euphonium":["16"],"Flute":["8"],"Tenor Sax":["11"],"Alto Sax":["11"],"Baritone Sax":["11"],"French Horn":["20"],"Clarinet":["26"],"Bassoon":["34"],"Tuba":["16","8","12"],"Oboe":["16","17"]],
            "B4b":["Tenor Recorder (C)":["11","12"],"Alto Recorder (F)":["6"],"Soprano Recorder (C)":["11"],"Trombone":["1","3","5"],"Trumpet":["1"],"Euphonium":["8"],"Flute":["10"],"Tenor Sax":["13"],"Alto Sax":["13"],"Baritone Sax":["13"],"French Horn":["22"],"Clarinet":["30","31","32"],"Bassoon":["36"],"Tuba":["8"],"Oboe":["19"]],
            "C5b":["Tenor Recorder (C)":["13","14"],"Alto Recorder (F)":["7"],"Soprano Recorder (C)":["12"],"Trombone":["2","4","6"],"Trumpet":["2"],"Euphonium":["9","17"],"Flute":["11"],"Tenor Sax":["14"],"Alto Sax":["14"],"Baritone Sax":["14"],"French Horn":["23"],"Clarinet":["33","34","35"],"Bassoon":["37"],"Oboe":["20"]],
            "D5b":["Tenor Recorder (C)":["16","17","18"],"Alto Recorder (F)":["9"],"Soprano Recorder (C)":["14"],"Trumpet":["4"],"Flute":["13"],"Tenor Sax":["16"],"Alto Sax":["16"],"Baritone Sax":["16"],"French Horn":["25"],"Clarinet":["38","39","40"],"Bassoon":["39"],"Oboe":["22"]],
            "E5b":["Tenor Recorder (C)":["20"],"Alto Recorder (F)":["13"],"Soprano Recorder (C)":["16"],"Trumpet":["2"],"Flute":["15"],"Tenor Sax":["18"],"Alto Sax":["18"],"Baritone Sax":["18"],"French Horn":["27"],"Clarinet":["42"],"Oboe":["24","25"]],
            "F5b":["Tenor Recorder (C)":["21"],"Alto Recorder (F)":["11","12"],"Soprano Recorder (C)":["17"],"Trumpet":["0"],"Flute":["16"],"Tenor Sax":["19"],"Alto Sax":["19"],"Baritone Sax":["19"],"French Horn":["28"],"Clarinet":["43"],"Oboe":["26"]],
            "G5b":["Tenor Recorder (C)":["23"],"Alto Recorder (F)":["15","16"],"Soprano Recorder (C)":["19"],"Trumpet":["2"],"Flute":["18"],"Tenor Sax":["21"],"Alto Sax":["21"],"Baritone Sax":["21"],"French Horn":["30"],"Clarinet":["45","46"],"Oboe":["30"]],
            "A5b":["Tenor Recorder (C)":["25"],"Alto Recorder (F)":["18"],"Soprano Recorder (C)":["21"],"Trumpet":["6"],"Flute":["20"],"Tenor Sax":["23"],"Alto Sax":["23"],"Baritone Sax":["23"],"French Horn":["32"],"Clarinet":["48"],"Oboe":["32","33"]],
            "B5b":["Tenor Recorder (C)":["27"],"Alto Recorder (F)":["20"],"Soprano Recorder (C)":["23"],"Trumpet":["1"],"Flute":["22"],"Tenor Sax":["25"],"Alto Sax":["25"],"Baritone Sax":["25"],"French Horn":["34"],"Clarinet":["50","51","52"],"Oboe":["3^"]],
            "C6b":["Tenor Recorder (C)":["28"],"Alto Recorder (F)":["21"],"Soprano Recorder (C)":["24","25"],"Trumpet":["2"],"Flute":["23"],"Tenor Sax":["26"],"Alto Sax":["26"],"Baritone Sax":["26"],"French Horn":["35"],"Clarinet":["53"],"Oboe":["37"]],
            "D6b":["Tenor Recorder (C)":["30"],"Alto Recorder (F)":["23"],"Soprano Recorder (C)":["27"],"Flute":["25"],"Tenor Sax":["28"],"Alto Sax":["28"],"Baritone Sax":["28"],"Clarinet":["55"],"Oboe":["39","30"]],
            "E6b":["Tenor Recorder (C)":["32"],"Alto Recorder (F)":["25"],"Flute":["27"],"Tenor Sax":["30"],"Alto Sax":["30"],"Baritone Sax":["30"],"Clarinet":["57","58"],"Oboe":["43"]],
            "F6b":["Tenor Recorder (C)":["33","34"],"Alto Recorder (F)":["26","27"],"Flute":["28"],"Tenor Sax":["31"],"Alto Sax":["31"],"Baritone Sax":["31"],"Clarinet":["59"],"Oboe":["44","45"]],
            "G6b":["Tenor Recorder (C)":["36"],"Alto Recorder (F)":["29"],"Flute":["30"],"Tenor Sax":["33"],"Alto Sax":["33"],"Baritone Sax":["33"]],
            "A6b":["Flute":["32"],"Tenor Sax":["35"],"Alto Sax":["35"],"Baritone Sax":["35"]],
            "B6b":["Flute":["34"],"Tenor Sax":["37"],"Alto Sax":["37"],"Baritone Sax":["37"]],
            "C7b":["Flute":["35"],"Tenor Sax":["38"],"Alto Sax":["38"],"Baritone Sax":["38"]]
        ]
        
        tNotes = ["A2","B2","C3","D3","E3","F3","G3","A3","B3","C4","D4","E4","F4","G4","A4","B4","C5","D5","E5","F5","G5","A5","B5","C6","D6","E6","F6","G6","A6","B6","C7"]
        
        bNotes = ["C1","D1","E1","F1","G1","A1","B1","C2","D2","E2","F2","G2","A2","B2","C3","D3","E3","F3","G3","A3","B3","C4","D4","E4","F4","G4","A4","B4","C5","D5","E5"]
        
        
        slider.minimumValue = 0
        slider.maximumValue = Float(tNotes.count)-1
        slider.value = 15

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderMoved(_ sender: Any) {
        moveNote(i:0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "Instrument")
        
        let instr = instruments[picker.selectedRow(inComponent: 0)]
        if instr == "Instruments" {
            moveNote(i:0)
            return
        }

        var min = Float(minMax[instr]!["Minimum"]!)
        var max = Float(minMax[instr]!["Maximum"]!)
        
        if trebInstruments.contains(instr) {
            min = min - 12.0
            max = max - 12.0
        }
        
        if slider.value < min {
            slider.value = min
        } else if slider.value > max {
            slider.value = max
        }
        
        slider.minimumValue = min
        slider.maximumValue = max
        
        moveNote(i:0)
        }

    
    @IBAction func flatButtonPressed(_ sender: Any) {
        flatButton.backgroundColor = customBlue
        sharpButton.backgroundColor = customLightBlue
        naturalButton.backgroundColor = customLightBlue
        flatButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        sharpButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        naturalButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        flatButton.isSelected = true
        naturalButton.isSelected = false
        sharpButton.isSelected = false
        moveNote(i:0)
    }
    @IBAction func naturalButtonPressed(_ sender: Any) {
        flatButton.backgroundColor = customLightBlue
        sharpButton.backgroundColor = customLightBlue
        naturalButton.backgroundColor = customBlue
        flatButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        sharpButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        naturalButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        flatButton.isSelected = false
        naturalButton.isSelected = true
        sharpButton.isSelected = false
        moveNote(i:0)
    }
    @IBAction func sharpButtonPressed(_ sender: Any) {
        flatButton.backgroundColor = customLightBlue
        sharpButton.backgroundColor = customBlue
        naturalButton.backgroundColor = customLightBlue
        flatButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        sharpButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        naturalButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        flatButton.isSelected = false
        naturalButton.isSelected = false
        sharpButton.isSelected = true
        moveNote(i:0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var NPVController = NewPageViewController()
    let segue = "pvc"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pvc"{
            NPVController = (segue.destination as? NewPageViewController)!
        }
    }
    
    
    @IBAction func mvSl(_ sender: Any) {
        NPVController.doHide()

        vInstrument.isHidden = true
        hInstrument.isHidden = true
        vInstrumentShadow.isHidden = true
        hInstrumentShadow.isHidden = true
        
        let instr = instruments[picker.selectedRow(inComponent: 0)]
        var noteList = [String]()
        
        if !vInstruments.contains(instr) && !hInstruments.contains(instr){
            vStaffShadow.isHidden = true
            chooseInstrument.isHidden = false
            vStaff.isHidden = true
            hStaff.isHidden = true
            hStaffShadow.isHidden = true
            heading.text = "NoteChart"
            return
        }
        chooseInstrument.isHidden = true
        
        let sliderVal = round(slider.value)
        var staff = ""
        var note = ""
        var key = ""
        var keyLabel = ""
        
        if trebInstruments.contains(instr){
            staff = "t_"
            note = tNotes[Int(sliderVal)]
        } else {
            staff = "b_"
            note = bNotes[Int(sliderVal)]
        }
        
        if flatButton.isSelected{
            key = "b"
            keyLabel = "♭"
        } else if sharpButton.isSelected{
            key = "#"
            keyLabel = "♯"
        } else {
            key = ""
        }
        
        var imgRef = String()
        var noteDict = pos[note+key]
        if noteDict![instr] != nil {
            noteList = noteDict![instr]!
            imgRef = noteList[ind]
        }
        
        if hInstruments.contains(instr){
            hInstrument.isHidden = false
            hInstrumentShadow.isHidden = false
            vStaffShadow.isHidden = true
            vStaff.isHidden = true
            hStaff.isHidden = false
            hStaffShadow.isHidden = false
            hStaff.image = UIImage(named:staff+note+key)


            if imgRef == "" {
                hInstrument.image = UIImage(named:"hNoPosition")
            } else if instr == "Euphonium" || instr == "Tuba" {
                hInstrument.image = UIImage(named:noteList[0])
            } else {
                hInstrument.image = UIImage(named:instr+noteList[0])
            }
        } else {
            vStaffShadow.isHidden = false
            vStaff.isHidden = false
            hStaff.isHidden = true
            hStaffShadow.isHidden = true
            vStaff.image = UIImage(named:staff+note+key)
            vInstrument.isHidden = false
            vInstrumentShadow.isHidden = false

            if imgRef == "" {
                vInstrument.image = UIImage(named:"vNoPosition")
            } else if instr == "Euphonium" || instr == "Tuba" {
                vInstrument.image = UIImage(named:noteList[0])
            } else {
                vInstrument.image = UIImage(named:instr+noteList[0])
            }
        }
        
        heading.text = instr+": "+note+keyLabel
    }
    
    func moveNote(i:Int){
        NPVController.doHide()
        vInstrument.isHidden = true
        hInstrument.isHidden = true
        vInstrumentShadow.isHidden = true
        hInstrumentShadow.isHidden = true
        
        ind = i
        let instr = instruments[picker.selectedRow(inComponent: 0)]
        NPVController.allViews = []
        var noteList = [String]()

        if !vInstruments.contains(instr) && !hInstruments.contains(instr){
            vStaffShadow.isHidden = true
            chooseInstrument.isHidden = false
            vStaff.isHidden = true
            hStaff.isHidden = true
            hStaffShadow.isHidden = true
            heading.text = "NoteChart"
            return
        }
        chooseInstrument.isHidden = true

        let sliderVal = round(slider.value)
        var staff = ""
        var note = ""
        var key = ""
        var keyLabel = ""
        
        if trebInstruments.contains(instr){
            staff = "t_"
            note = tNotes[Int(sliderVal)]
        } else {
            staff = "b_"
            note = bNotes[Int(sliderVal)]
        }

        if flatButton.isSelected{
            key = "b"
            keyLabel = "♭"
        } else if sharpButton.isSelected{
            key = "#"
            keyLabel = "♯"
        } else {
            key = ""
        }
        
        var imgRef = String()
        var noteDict = pos[note+key]
        if noteDict![instr] != nil {
            noteList = noteDict![instr]!
            imgRef = noteList[ind]
        }
        
        if hInstruments.contains(instr){
            vStaffShadow.isHidden = true
            vStaff.isHidden = true
            hStaff.isHidden = false
            hStaffShadow.isHidden = false
            hStaff.image = UIImage(named:staff+note+key)
            if imgRef == "" {
                vList = [["instrument":"hNoPosition","direction":"horizontal"]]
            } else if instr == "Euphonium" || instr == "Tuba" {
                vList = [[String:String]]()
                for index in 0...noteList.count-1 {
                    vList.append(["instrument":noteList[index],"direction":"horizontal"])
                }
            } else {
                vList = [[String:String]]()
                for index in 0...noteList.count-1 {
                    vList.append(["instrument":instr+noteList[index],"direction":"horizontal"])
                }
            }
        } else {
            vStaffShadow.isHidden = false
            vStaff.isHidden = false
            hStaff.isHidden = true
            hStaffShadow.isHidden = true
            vStaff.image = UIImage(named:staff+note+key)
            if imgRef == "" {
                vList = [["instrument":"vNoPosition","direction":"vertical"]]
            } else if instr == "Euphonium" || instr == "Tuba" {
                vList = [[String:String]]()
                for index in 0...noteList.count-1 {
                    vList.append(["instrument":noteList[index],"direction":"vertical"])
                }
            } else {
                vList = [[String:String]]()
                for index in 0...noteList.count-1 {
                    vList.append(["instrument":instr+noteList[index],"direction":"vertical"])
                }
            }
        }
        
        NPVController.views = vList
        [NPVController .viewDidLoad()]
        
        heading.text = instr+": "+note.prefix(1)+keyLabel+note.suffix(1)
    }
    


}
