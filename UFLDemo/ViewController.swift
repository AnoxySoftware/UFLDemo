//
//  ViewController.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var filterBarVisible = false

    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleFilterBar(sender: AnyObject) {
        filterBarVisible = !filterBarVisible
        
        if let button: UIBarButtonItem = sender as? UIBarButtonItem {
            button.tintColor = filterBarVisible ? UIColor.btnSelectedColor : UIColor.whiteColor()
        }
        
        //animate the filter bar (the extra 5 pixels in the filterView height are for the drop shadow)
        UIView.animateWithDuration(0.4,
                                   delay: 0,
                                   options:.CurveEaseOut,
                                   animations: {
                                    self.filterTopConstraint.constant = self.filterBarVisible ? 0 : -(self.filterView.frame.size.height+5)
                                    self.view.layoutIfNeeded()
                                   },
                                   completion: nil)
    }
    
}

