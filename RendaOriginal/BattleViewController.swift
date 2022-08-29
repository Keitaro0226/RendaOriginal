//
//  BattleViewController.swift
//  RendaOriginal
//
//  Created by Keitaro Kawahara on 2022/08/29.
//

import UIKit
import AVFoundation

class BattleViewController: UIViewController {
    
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    
    @IBOutlet var startCountLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    var leftnum: Int = 0
    var rightnum: Int = 0
    
    var timeCount: Float = 10.0
    
    var countdown: Int = 4
    
    var timer: Timer = Timer()
    
    var timerS: Timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        leftnum = 0
        rightnum = 0
        
        timeCount = 10.0
        
        countdown = 4
        
        leftButton.layer.cornerRadius = 80
        rightButton.layer.cornerRadius = 80
        
        
        self.disableButton()
        
        //3秒カウントダウンスタート
        self.countDown()
        
    }
    
    @IBAction func leftTap(){
        
        leftnum = leftnum + 1
        
        leftLabel.text = String(leftnum)
        
    }
    
    @IBAction func rightTap() {
        
        rightnum = rightnum + 1
        
        rightLabel.text = String(rightnum)
        
    }
    
    func timerStart() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.down), userInfo: nil, repeats: true)
        }
    }
    
    func countDown(){
        if !timerS.isValid {
            timerS = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startcount), userInfo: nil, repeats: true)
        }
    }
    
    @objc func down() {
        
        if timeCount < 0.00 {
            if timer.isValid {
                timer.invalidate()
            }
            
            timeCount = 0.00
            
            let nextVC = storyboard?.instantiateViewController(withIdentifier: "FinishVC") as! FinishViewController
            
            nextVC.leftCount = leftnum
            nextVC.rightCount = rightnum
            
            self.present(nextVC, animated: true, completion: nil)
        
        }else if timeCount < 3.00 {
            timeLabel.textColor = UIColor.red
            
            timeCount = timeCount - 0.01
            
        }else{
            timeCount = timeCount - 0.01
        }
        timeLabel.text = String(format: "%.2f", timeCount)
    }
    
    @objc func startcount() {
        
        countdown = countdown - 1
        
        if countdown == 0 {
         
            
            startCountLabel.text = "START"
            
            self.enableButton()
            
            //10秒カウントダウンスタート
            self.timerStart()
            
        }else if countdown == -1 {
            if timerS.isValid {
                timerS.invalidate()
            }
            startCountLabel.text = ""
            
            startCountLabel.isHidden = true
            
        }else if countdown == 3 {
            if let soundURL = Bundle.main.url(forResource: "countdown", withExtension: "mp3") {
                do {
                    print("playSound")
                    player = try AVAudioPlayer(contentsOf: soundURL)
                    player?.play()
                } catch {
                    print("error")
                }
            }
            startCountLabel.text = "3"
            
        }else if countdown == 2{
            startCountLabel.text = "2"
          
        }else if countdown == 1{
            startCountLabel.text = "1"
        }
        
    }
    
    func enableButton() {
        leftButton.isEnabled = true
        leftButton.backgroundColor = .systemBlue
        leftButton.setTitleColor(.white, for: .normal)
        leftButton.layer.borderColor = UIColor.systemBlue.cgColor
        
        rightButton.isEnabled = true
        rightButton.backgroundColor = .systemBlue
        rightButton.setTitleColor(.white, for: .normal)
        rightButton.layer.borderColor = UIColor.systemBlue.cgColor
    }

    func disableButton() {
        let goDisableColor = UIColor(red: 11/255, green: 43/255, blue: 94/255, alpha: 1)
        leftButton.isEnabled = false
        leftButton.backgroundColor = goDisableColor
        leftButton.setTitleColor(.gray, for: .disabled)
        leftButton.layer.borderColor = goDisableColor.cgColor
        
        rightButton.isEnabled = false
        rightButton.backgroundColor = goDisableColor
        rightButton.setTitleColor(.gray, for: .disabled)
        rightButton.layer.borderColor = goDisableColor.cgColor
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
