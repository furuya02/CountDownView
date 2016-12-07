//
//  ViewController.swift
//  CountDownSample
//
//  Created by hirauchi.shinichi on 2016/12/07.
//  Copyright © 2016年 SAPPOROWORKS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CountDownDelegate {
    
    @IBOutlet weak var screenView: UIView!
    
    var countDownView:CountDownView = CountDownView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countDownView.delegate = self
        self.countDownView.center = CGPoint(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.height / 2.0)
        self.view.addSubview(countDownView)
    }

    func didCount(count: Int) {
        print("didiCount(\(count))")
        self.screenView.alpha -= 0.1
    }
    
    func didFinish() {
        print("didFinish")
        self.screenView.alpha = 0
    }
    
    @IBAction func tapStartButton(_ sender: Any) {
        self.countDownView.start(max: 5)
    }
    
    @IBAction func tapStopButton(_ sender: Any) {
        self.countDownView.stop()
    }
}

