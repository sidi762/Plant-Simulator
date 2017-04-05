//
//  ViewController.swift
//  Plant Simulator
//
//  Created by 梁思地 on 2017/3/29.
//  Copyright © 2017年 梁思地. All rights reserved.
//

import UIKit
var startedTime = 0
var timePassInterval = 10.0
var runningSecond = 0
var hour2Min:Float = 60
var min2Sec:Float = 60
var hour2Sec:Float = hour2Min * min2Sec
var sec2Min:Float = 1/60
var min2Hour:Float = 1/60
var sec2Hour:Float = 1/3600

class ViewController: UIViewController {
    
    var environment = Environment()
    
    @IBOutlet weak var tmpTestBtn: UIButton!
    @IBAction func testBtnTouched(_ sender: UIButton) {
//        environment.dayNightChange(imageview: outsidePic)
        timeRuns()
    }
    @IBOutlet weak var outsidePic: UIImageView!
    
    @IBOutlet weak var nightOutsidePic: UIImageView!
    @IBOutlet weak var window: UIButton!
    
    
    @IBAction func windowTouched(_ sender: UIButton) {
        windowStateChange()
    }
    
    func windowStateChange(){
        if(window.currentImage == #imageLiteral(resourceName: "closed window.png")){
           windowOpen()
            }else{
          windowClose()
                    }
    }
    
    func windowOpen(){
        window.setImage(#imageLiteral(resourceName: "opened window.png"), for: UIControlState.normal)//openwindow
    }
    
    func windowClose(){
        window.setImage(#imageLiteral(resourceName: "closed window.png"), for: UIControlState.normal)//close window

    }
    func timeRuns(){
        
        let changePicInterval = Int(timePassInterval)
        runningSecond = runningSecond + 1
        print(runningSecond)
        if(runningSecond % changePicInterval == 0){
        if(environment.isDay){
            UIView.animate(withDuration: 1, delay: 1 ,animations: {
                self.nightOutsidePic.alpha=1
            })
            environment.isDay = false
            print("is night")
        }else{
            UIView.animate(withDuration: 1, delay: 1, animations: {
                self.nightOutsidePic.alpha=0
            })
            environment.isDay = true
            print("is day")

        }
        }

           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        timePassInterval = Double(environment.PassScale * 12.0 * hour2Sec)
        print("Time Pass Interval: ")
        print(timePassInterval)
        print(environment.PassScale)
        //let changePicInterval = timePassInterval
        environment.timer = Timer.scheduledTimer(timeInterval: 1,
                                                       target:self,selector:#selector(ViewController.timeRuns),
                                                       userInfo:nil,repeats:true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}




class Environment{
    
    init(){
        print("Environment initized!")
        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            let now = NSDate()
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            startedTime = timeStamp
            print("初始时间戳：\(timeStamp)")
            print("starting point was setted!")
        }

    }
    var timeOfADay = 0
    var Days = 0
    var temp = 25
    var isDay = true
    var timer:Timer!
    var PassScale = sec2Hour
    
    
    
    func getYear() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.year!
    }
    
    func getMonth() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.month!
    }
    
    
    
    func getDay() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.day!
    }

    func getHour() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.hour!
    }

    func getMinute() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.minute!
    }
    
    func getSecond() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day, .weekday, .hour, .minute,.second], from: Date())
        return comps.second!
    }
    


}












