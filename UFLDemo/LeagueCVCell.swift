//
//  LeagueCVCell.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class LeagueCVCell : UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    func setCellData(imageName imageName: String, label:String) {
        self.label.text = label
        self.imgView.image = UIImage(named: imageName)
        self.label.numberOfLines = label.containsString("\n") ? 2 : 1
    }
}
