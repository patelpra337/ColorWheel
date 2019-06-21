//
//  ViewController.swift
//  ColorWheel
//
//  Created by patelpra on 6/20/19.
//  Copyright © 2019 Pravin Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func changeColor(_ sender: ColorWheel) {
        view.backgroundColor = sender.color
    }
  
    @IBAction func touchInSide(_ sender: ColorWheel) {
        view.backgroundColor = .white
    }
    
    @IBAction func touchOutSide(_ sender: ColorWheel) {
        view.backgroundColor = .white
    }
    
}

