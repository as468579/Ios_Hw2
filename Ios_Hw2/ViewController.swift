//
//  ViewController.swift
//  Ios_Hw2
//
//  Created by User02 on 2019/5/19.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    
    let low = ["肌肉量太少！","要多吃與多動","不要再待在電腦前啦"]
    let average = ["正常的數值","繼續努力增加肌肉量！","你還可以更好！"]
    let highaverage = ["不錯喔！看得出來有練","比一般人有毅力，繼續保持！","平常有不錯的運動習慣～"]
    let high = ["練很久了喔～～","去健身房，你就是每個人的焦點！","可以教我怎麼練的嗎QuQ"]
    let veryhigh = ["是不是有偷用仙丹！？","隨時都處於完美狀態！","壞人看到都會嚇跑"]
    @IBOutlet var background: UIView!
    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    @IBOutlet var bgmswitch: UISwitch!
    @IBOutlet var gender: UISegmentedControl!
    @IBOutlet var bodyfat: UISlider!
    @IBOutlet var birthday: UIDatePicker!
    @IBOutlet var bodyfatpercent: UILabel!
    
    @IBOutlet var out: UILabel!
    @IBOutlet var assess: UILabel!

    @IBOutlet var assess2: UILabel!
    var maleOrFemale:String = "male"
    
    var looper: AVPlayerLooper?
    let player = AVQueuePlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://67.159.62.2/ost/ragnarok-online-original-soundtrack/fygltzmy/108%20theme%20of%20prontera.mp3") {
            let item = AVPlayerItem(url: url)
            looper = AVPlayerLooper(player: player, templateItem: item)
            player.play()
        }
        
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        bodyfatpercent.text = String(format:"%.1f",bodyfat.value)
    }
    
    @IBAction func genderChanged(_ sender: UISegmentedControl) {
        
        if(sender.selectedSegmentIndex==0)
        {
            maleOrFemale = "male"
        }
        else if((sender.selectedSegmentIndex==1))
        {
            maleOrFemale = "female"
        }
        
    }
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        var  birthday = formatter.string(from: sender.date)
        
        //生日
        var birthstart = birthday.index(birthday.startIndex, offsetBy: 0)
        var birthend = birthday.index(birthday.startIndex, offsetBy: 4)
        var birthrange = birthstart..<birthend
        var birthYear = Int(birthday.substring(with: birthrange))!
        
        //現在時間
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let nowString = dformatter.string(from: now)
        
        var start = nowString.index(nowString.startIndex, offsetBy: 0)
        var end = nowString.index(nowString.startIndex, offsetBy: 4)
        var range = start..<end
        var nowYear = Int(nowString.substring(with: range))!
        
        var age = nowYear-birthYear
        
        if(age<0)
        {
            out.text = "你是未來人？"
        }
        else
        {
            out.text = "您的虛歲:"+String(age)+"歲"
        }
        
    }
    @IBAction func calculateFFMI(_ sender: UIButton) {
        
         var hei:Double = 0.0
         var wei:Double = 0.0
        var doublebodyfat:Double = 0.0
        
        hei = Double(height.text!)!/100
        wei = Double(weight.text!)!
        doublebodyfat = Double(bodyfat.value)
        
        // FFMI＝〔體重（Kg）×（100％－體脂率）〕÷ 身高2（m）
        
        var ffmi = (wei*((100-doublebodyfat)/100))/(hei*hei)
        
        // 身高超過 180 公分的 FFMI＝原始 FFMI＋｛6.0 ×〔身高（m）－1.8〕｝
        if(hei>1.8)
        {
            ffmi = ffmi+(6*hei-1.8)
        }
        changeLabelAndImage(ffmi: ffmi, genderr: maleOrFemale)
        
    }
    var  index = 0
    func changeLabelAndImage(ffmi:Double,genderr:String)
    {
        index = Int.random(in: 0...2)
        if(genderr=="male"&&ffmi>=16&&ffmi<18)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = low[index]
        }
        else if(genderr=="male"&&ffmi>=18&&ffmi<20)
        {
           changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = average[index]
        }
        else if(genderr=="male"&&ffmi>=20&&ffmi<22)
        {
           changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = highaverage[index]
        }
        else if(genderr=="male"&&ffmi>=22&&ffmi<23)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = high[index]
        }
        else if(genderr=="male"&&ffmi>=23)
        {
           assess2.text = veryhigh[index]
        }
        if(genderr=="female"&&ffmi>=13&&ffmi<15)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = low[index]
        }
        else if(genderr=="female"&&ffmi>=15&&ffmi<17)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = average[index]
        }
        else if(genderr=="female"&&ffmi>=17&&ffmi<19)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = highaverage[index]
        }
        else if(genderr=="female"&&ffmi>=19&&ffmi<22)
        {
            changeAssess(ffmi: ffmi, genderr:maleOrFemale)
            assess2.text = high[index]
        }
        else if(genderr=="female"&&ffmi>=23)
        {
            assess2.text = veryhigh[index]
        }
    }
    
    func changeAssess(ffmi:Double,genderr:String)
    {
        assess.text = "FFMI:"+String(format: "%.2f", ffmi)
    }
    
    @IBAction func BGMSwitch(_ sender: UISwitch) {
        if sender.isOn == true {
            player.play()
        } else {
            player.pause()
        }
    }
}
