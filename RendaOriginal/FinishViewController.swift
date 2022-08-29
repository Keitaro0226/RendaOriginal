//
//  FinishViewController.swift
//  RendaOriginal
//
//  Created by Keitaro Kawahara on 2022/08/29.
//

import UIKit


class FinishViewController: UIViewController {
    
    @IBOutlet var winLabel: UILabel!
    
    var leftCount: Int?
    var rightCount: Int?
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(leftCount)
        print(rightCount)
        
        self.hantei()
    }
    
    func hantei() {
        if leftCount! > rightCount! {
            winLabel.text = "左側の人の勝ち"
        }else if leftCount! < rightCount! {
            winLabel.text = "右側の人の勝ち"
        }else if leftCount! == rightCount! {
            winLabel.text = "引き分け"
        }else{
            print("err")
        }
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
