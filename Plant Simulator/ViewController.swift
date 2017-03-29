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
        environment.dayNightChange(imageview: outsidePic)
    }
    @IBOutlet weak var outsidePic: UIImageView!
    
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
        outsidePic.setValue(#imageLiteral(resourceName: "night.png"), forKey: "daynight")
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
    
    var time = 0
    var temp = 25
    var isDay = true
    func dayNightChange(imageview:UIImageView){
        if(isDay){
            imageview.image = #imageLiteral(resourceName: "night.png")//night
            isDay = false
        }else{
            imageview.image = #imageLiteral(resourceName: "day.png")//day
            isDay = true
        }
    }

}












