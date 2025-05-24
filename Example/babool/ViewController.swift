//
//  ViewController.swift
//  babool
//
//  Created by 6260612 on 07/14/2024.
//  Copyright (c) 2024 6260612. All rights reserved.
//

import UIKit
import Babool

class ViewController: UIViewController {

    private var babool: BaboolBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func localog() {
        babool = BaboolBoard(boardType: .localSheet(csvName: "Babool-Log"))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.babool?.write(payload: DefaultPayload(title: "My Title", description: "I dont have anything to write here", category: "DEBUG"))
        })
    }
    
    func logOnGoogleSheet() {
        babool = BaboolBoard(boardType: .googleSheet(apiPath: URL(string: "")!))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.babool?.write(payload: DefaultPayload(title: "My Title", description: "I dont have anything to write here", category: "DEBUG"))
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

