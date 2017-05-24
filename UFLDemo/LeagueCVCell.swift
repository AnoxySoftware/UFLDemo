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
    
    func configure(withPresenter presenter: HeaderPresentable) {
        self.imgView.image = UIImage(named: presenter.leagueImageName)
        
        if (presenter.leagueTitle.characters.count > 9 && presenter.leagueTitle.containsString(" ")) {
            //we can split the name into 2 rows
            self.label.numberOfLines = 2
            self.label.text = presenter.leagueTitle.stringByReplacingOccurrencesOfString(" ", withString: "\n")
        }
        else {
            self.label.numberOfLines = 1
            self.label.text = presenter.leagueTitle
        }
    }
    
    func setCellData(imageName imageName: String, label:String) {
        self.label.text = label
        self.imgView.image = UIImage(named: imageName)
        self.label.numberOfLines = label.containsString("\n") ? 2 : 1
    }
    
    func highLightCell() {
        self.label.textColor = UIColor.btnSelectedColor
    }
    
    func deHighLightCell() {
        self.label.textColor = UIColor.whiteColor()
    }
}
