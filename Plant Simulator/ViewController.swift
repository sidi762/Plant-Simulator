//
//  ViewController.swift
//  Plant Simulator
//
//  Created by 梁思地 on 2017/3/29.
//  Copyright © 2017年 梁思地. All rights reserved.
//

import UIKit
var startedTime = 0
class ViewController: UIViewController {
    
    var environment = Environment()

    @IBOutlet weak var tmpTestBtn: UIButton!
    @IBAction func testBtnTouched(_ sender: UIButton) {
//        environment.dayNightChange(imageview: outsidePic)
        changeOutsidePic()
    }
    @IBOutlet weak var outsidePic: UIImageView!
    
    @IBOutlet weak var nightOutsidePic: UIImageView!
    @IBOutlet weak var window: UIButton!
    
    
    @IBAction func windowTouched(_ sender: UIButton) {
        windowStateChange()
    }
    
    func windowStateChange(){
        if(window.currentImage == #imageLiteral(resourceName: "closed window.png")){
           window.setImage(#imageLiteral(resourceName: "opened window.png"), for: UIControlState.normal)//openwindow
        }else{
            window.setImage(#imageLiteral(resourceName: "closed window.png"), for: UIControlState.normal)//close window
        }
    }
    
    func changeOutsidePic(){
        if(environment.isDay){
            UIView.animate(withDuration: 1, delay: 1 ,animations: {
                self.nightOutsidePic.alpha=1
            })
            environment.isDay = false
        }else{
            UIView.animate(withDuration: 1, delay: 1, animations: {
                self.nightOutsidePic.alpha=0
            })
            environment.isDay = true

        }

           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




class Environment{
    
    var timeOfADay = 0
    var Days = 0
    var temp = 25
    var isDay = true
    func getTimeOfTheDay(){
        let now = NSDate()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let

    }

}












