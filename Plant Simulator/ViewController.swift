//
//  ViewController.swift
//  Plant Simulator
//
//  Created by 梁思地 on 2017/3/29.
//  Copyright © 2017年 梁思地. All rights reserved.
//

//note for myself: so far only Cherry tomato are simulated

import UIKit
var startedTime = 0
var timePassInterval = 10.0
var runningSecond = 0
var hour2Min:Double = 60
var min2Sec:Double = 60
var hour2Sec:Double = hour2Min * min2Sec
var sec2Min:Double = 1/60
var min2Hour:Double = 1/60
var sec2Hour:Double = 1/3600
var windowStateOpened:Bool = false
var heaterOn = true
var isWatering = false
var passedSec:Double = 0
var isFahrenheit = false


class ViewController: UIViewController {
    
    var environment = Environment()
    var myPlant = Plant()
    
    @IBOutlet weak var setRatelabe: UILabel!
    @IBOutlet weak var setHeaterleb: UILabel!
    @IBOutlet weak var tempIndorlabe: UILabel!
    @IBOutlet weak var tempOutdorlabe: UILabel!
    @IBOutlet weak var closeTabBtn: UIButton!
    @IBOutlet weak var setSimRate: UITextField!
    @IBOutlet weak var setHeater: UITextField!
    @IBOutlet weak var tempIndoor: UILabel!
    @IBOutlet weak var tempOutdoor: UILabel!
    @IBOutlet weak var tempSecg: UISegmentedControl!
    @IBOutlet weak var infoTab: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var addSoilBtn: UIButton!
    @IBOutlet weak var seedBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var waterBtn: UIButton!
    @IBOutlet weak var waterPot: UIButton!
    @IBOutlet weak var waterInSoil: UIImageView!
    @IBOutlet weak var tooMuchWaterInSoil: UIImageView!
    @IBOutlet weak var tempF: UIImageView!
    @IBOutlet weak var tempC: UIImageView!
    @IBOutlet weak var tempsurface: UIImageView!
    @IBOutlet weak var tmpTestBtn: UIButton!
    @IBAction func waterClicked(_ sender: Any) {
        if(waterPot.isHidden){
            waterPot.isHidden = false
        }else{
            waterPot.isHidden = true
        }
    }
    @IBAction func testBtnTouched(_ sender: UIButton) {
//        environment.dayNightChange(imageview: outsidePic)
        timeRuns()
    }
    @IBOutlet weak var outsidePic: UIImageView!
  
    @IBOutlet weak var heater: UIButton!
    
    @IBOutlet weak var nightOutsidePic: UIImageView!
    @IBOutlet weak var window: UIButton!
    @IBOutlet weak var lightshadowimage: UIImageView!

    
    func showInfo(){
        closeTabBtn.isHidden = false
        setSimRate.isHidden = false
        setHeater.isHidden = false
        tempOutdoor.isHidden = false
        tempIndoor.isHidden = false
        tempSecg.isHidden = false
        infoTab.isHidden = false
        tempIndorlabe.isHidden = false
        tempOutdorlabe.isHidden = false
        setHeaterleb.isHidden = false
        setRatelabe.isHidden = false
    }
    
    @IBOutlet var controlUI: UIControl!
    
    @IBAction func touchedUpInsideControl(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    func dismissInfo(){
        closeTabBtn.isHidden = true
        setSimRate.isHidden = true
        setHeater.isHidden = true
        tempOutdoor.isHidden = true
        tempIndoor.isHidden = true
        tempSecg.isHidden = true
        infoTab.isHidden = true
        tempIndorlabe.isHidden = true
        tempOutdorlabe.isHidden = true
        setHeaterleb.isHidden = true
        setRatelabe.isHidden = true

    }
    
    @IBAction func closeInfoClicked(_ sender: Any) {
        dismissInfo()
    }
    
    
    @IBAction func heaterSetted(_ sender: Any) {
        if(setHeater.text != nil){
        self.environment.tempHeater = Double(self.setHeater.text!)!
        }
    }
    @IBAction func infoClicked(_ sender: Any) {
        showInfo()
    }
    @IBAction func windowTouched(_ sender: UIButton) {
        windowStateChange()
    }
    
    @IBAction func heaterStateChange(_ sender: UIButton) {
        if(heaterOn == false){
            heaterOn = true
            heater.setImage(#imageLiteral(resourceName: "heateron.png"), for: UIControlState.normal)
        }else{
            heaterOn = false
            heater.setImage(#imageLiteral(resourceName: "heateroff.png"), for: UIControlState.normal)
        }
        
    }
    
    @IBAction func simRateSetted(_ sender: Any) {
        if(setSimRate.text != nil){
            let tempscale = Double(setSimRate.text!)
            environment.PassScale = 1/tempscale!
        }

    }
    @IBOutlet weak var flowerpot: UIImageView!
    @IBAction func AddSoilTouched(_ sender: UIButton) {
        flowerpot.image = #imageLiteral(resourceName: "flowerpotwithsoil.png")
        addSoilBtn.isHidden = true
        waterBtn.isEnabled = true
        resetBtn.isEnabled = true
        seedBtn.isEnabled =  true
        UserDefaults.standard.set(true, forKey: "everAddedSoil")
        
    }
    @IBAction func changedCF(_ sender: Any) {
        if(tempSecg.selectedSegmentIndex == 0){
            isFahrenheit = false
        }else{
            isFahrenheit = true
        }
    }
    
    
    
    
    @IBAction func water(_ sender: Any) {
        waterPot.setImage(UIImage(named: "倒水.png"), for: UIControlState.normal)
        isWatering = true
    }
    
    
    @IBAction func stopWater(_ sender: Any) {
        waterPot.setImage(UIImage(named: "水壶.png"), for: UIControlState.normal)
        isWatering = false
        
    }
    
    func windowStateChange(){
        if(window.currentImage == #imageLiteral(resourceName: "closed window.png")){
           windowOpen()
            }else{
          windowClose()
                    }
    }
    @IBAction func resetClicked(_ sender: UIButton) {
        let appDomain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: appDomain)
        exit(0)
    }
    
    func windowOpen(){
        window.setImage(#imageLiteral(resourceName: "opened window.png"), for: UIControlState.normal)//openwindow
        windowStateOpened = true
    }
    
    
    
    func watering(){
        environment.soilMoisture = environment.soilMoisture + 0.1
    }
    func windowClose(){
        window.setImage(#imageLiteral(resourceName: "closed window.png"), for: UIControlState.normal)//close window
        windowStateOpened = false

    }
    
    func c2F(value:Double) -> Double{
        return (1.8*value)+32
    }
    
    @IBAction func SeedPlaced(_ sender: UIButton) {
        seedBtn.isHidden = true
        UserDefaults.standard.set(true, forKey: "everStartedPlanting")
        myPlant.growPercentage = 0.0
        myPlant.isPlanted = true
        infoBtn.isHidden = false
    
    }
    func plantRestart(){
        UserDefaults.standard.set(false, forKey: "everStartedPlanting")
        myPlant.isPlanted = false
        seedBtn.isHidden = false
    }
    
    
    
    
        func timeRuns(){
        
          
        passedSec+=1
        print("passedSec:\(passedSec)")
        tmpTestBtn.setTitle("passedSec:\(passedSec)", for: .normal)
        let changePicInterval = Int(timePassInterval)
        runningSecond = runningSecond + 1
        print(runningSecond)
            
        //plantGrow
            

            var growCount:Double = 0
            while(growCount <= (1/environment.PassScale)){
            if(myPlant.isPlanted){
                if(myPlant.growPercentage >= 0.04){
                    plantImage.isHidden = false
                    plantImage.image = UIImage(named:"bud.png")
                    print("sprouted!")
                }
                
                myPlant.growing()
                myPlant.storeGrowingProccess()
                
                
                
                }
                growCount += 1
            }
        //day night change
            
        if(runningSecond % changePicInterval == 0){
        if(environment.isDay){
            UIView.animate(withDuration: 1, delay: 1 ,animations: {
                self.nightOutsidePic.alpha=1
                self.lightshadowimage.alpha = 1
            })
            environment.isDay = false
            print("is night")
        }else{
            UIView.animate(withDuration: 1, delay: 1, animations: {
                self.nightOutsidePic.alpha=0
                self.lightshadowimage.alpha = 0
            })
            environment.isDay = true
            print("is day")

        }
            }
            
            //Temp update
            var i:Double = 0
            while(i <= (1/environment.PassScale)){
                tempChange()
                thrmeterUpdate()
                i = i + 1
            }
            

            //soilMoisture update
            let soilMoistureInterval = Int(environment.PassScale * 1 * hour2Sec)
            
            if(runningSecond % soilMoistureInterval == 0){
                environment.soilMoisture = environment.soilMoisture - 0.02
                
                
                }
            var SoilI = 0
            while(SoilI <= 10){
                if(environment.soilMoisture <= 1){
                    tooMuchWaterInSoil.isHidden = true
                    UIView.animate(withDuration: 0.01, delay: 0, animations: {
                    self.waterInSoil.alpha = CGFloat(0.2 * self.environment.soilMoisture)
                    })
                                }else{
                    tooMuchWaterInSoil.isHidden = false
                    waterInSoil.alpha = 0.0
                }
                SoilI += 1
            }
            var j:Double = 0
            if(isWatering){
                while(j <= (1/environment.PassScale)){
                    watering()
                    j = j + 1
                }
            }
            print("soilMoisture:")
            print(environment.soilMoisture)
            
            
            
            //info update
            let simRateInfo = 1/(environment.PassScale)
            setSimRate.placeholder = "\(simRateInfo)"
            if(!(isFahrenheit)){
                tempIndoor.text = "\(environment.temp)"
                tempOutdoor.text = "\(environment.tempOutside)"
                setHeater.placeholder = "\(environment.tempHeater)"
                }else{
                tempIndoor.text = "\(c2F(value: environment.temp))"
                tempOutdoor.text = "\(c2F(value:environment.tempOutside))"
                setHeater.placeholder = "\(c2F(value:environment.tempHeater))"
            }
            
            
            
    }
    
    
    
    
    func tempChange(){
            let differenceT = environment.tempOutside - environment.temp
            let ww = 0.01375 * abs(Double(differenceT))
            let decendT = ww / (193.5 * 0.055)
            //let differenceHeaterT:Double = environment.tempHeater - environment.temp
            //print("differenceHeaterT:  \(differenceHeaterT)")
            let δ = (5.6704 * 0.00000008)
            let pp = 0.1 * δ * pow(environment.tempHeater, 4)
            let heat = pp / (0.055 * 193.5)
            let heatLostWall = (0.18 * 0.3 * abs(Double(differenceT)))/(0.055 * 193.5)
            //print("heatLostWall: \(heatLostWall)")
        
            if(heaterOn){
                environment.temp = environment.temp + heat
            }
        
            environment.temp = environment.temp - heatLostWall
            //print("currentTemp: \(environment.temp)")
            //print("displayTemp: \(Int(environment.temp))")
        
        
            if(windowStateOpened){
                environment.temp = environment.temp - decendT
                //print("everySec: \(environment.temp - decendT)")
                //print("tempOutside: \(environment.tempOutside)")
                //print("decendT: \(decendT)")
                
                }
        
                }

    
    func thrmeterUpdate(){
        if(Int(environment.temp) <= 20 && Int(environment.temp) >= -20){
            self.tempC.image = UIImage(named:"\(Int(environment.temp)).png")
        }else{
            self.tempC.image = UIImage(named: "err.png")
        }

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
        if(!(UserDefaults.standard.bool(forKey: "everStartedPlanting"))){
            seedBtn.isHidden = false
            myPlant.isPlanted = false
            infoBtn.isHidden = true
        }else{
            infoBtn.isHidden = false
            seedBtn.isHidden = true
            myPlant.isPlanted = true
        }
        if(!(UserDefaults.standard.bool(forKey: "everAddedSoil"))){
            addSoilBtn.isHidden = false
        }else{
            addSoilBtn.isHidden = true
            flowerpot.image = #imageLiteral(resourceName: "flowerpotwithsoil.png")
        }
        if (!(UserDefaults.standard.bool(forKey: "everStartedCounting"))) {
           UserDefaults.standard.set(true, forKey: "everStartedCounting")
            print("started counting")
            waterBtn.isEnabled = false
            resetBtn.isEnabled = false
            seedBtn.isEnabled =  false
            passedSec = 0
        }else{
            let now = NSDate()
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            startedTime = Int(UserDefaults.standard.integer(forKey: "startedTimeSec"))
            passedSec = Double(timeStamp - startedTime)
            waterBtn.isEnabled = true
            resetBtn.isEnabled = true
            
        }

        
        
        
        timePassInterval = Double(environment.PassScale * 12.0 * hour2Sec)
        print("Time Pass Interval: ")
        print(timePassInterval)
        print(environment.PassScale)
        //let changePicInterval = timePassInterval
        waterInSoil.alpha = CGFloat(0.2 * environment.soilMoisture)
        environment.timer = Timer.scheduledTimer(timeInterval: 1,
                                                       target:self,selector:#selector(ViewController.timeRuns),
                                                       userInfo:nil,repeats:true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

}


class Plant{
    
    init(){
        if(!UserDefaults.standard.bool(forKey: "everStartedPlanting")){
            print("Plant initized!")
        }else{
            growPercentage = UserDefaults.standard.double(forKey: "storedGrowPercentage")
        }
        
    }
    var isPlanted = false
    var growSpeed = 0.00000019
    var growPercentage:Double = 0
    
    func growing(){
        growPercentage = growPercentage + growSpeed
        //printGrowPercentage()
    }
    
    func printGrowPercentage(){
        print(growPercentage)
    }
    
    func storeGrowingProccess(){
        UserDefaults.standard.set(growPercentage, forKey: "storedGrowPercentage")
    }
    
    
    
    
    
    
}






class Environment{
    
    init(){
        print("Environment initized!")
        print("tempHeater: \(tempHeater)")
        print("temp: \(temp)")

        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            let now = NSDate()
            let timeInterval:TimeInterval = now.timeIntervalSince1970
            let timeStamp = Int(timeInterval)
            startedTime = timeStamp
            print("初始时间戳：\(timeStamp)")
            print("starting point was setted!")
           
        }//else{
           // PassScale = UserDefaults.standard.double(forKey: "settedPassScale")
           // temp = UserDefaults.standard.double(forKey: "tempInside")
        //}
        

    }
    var timeOfADay = 0
    var Days = 0
    var tempOutside:Double = 0
    var temp:Double = 20
    var soilMoisture = 0.0
    var isDay = true
    var timer:Timer!
    var PassScale:Double = sec2Hour
    var tempHeater = 73.0
   
    
    
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












