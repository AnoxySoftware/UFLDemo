//
//  headerView.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 24/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class headerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    func initViewFromNib() {
        NSBundle.mainBundle().loadNibNamed("headerView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        //use VFL to adjust the view
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options:[], metrics:nil, views:["contentView":contentView])
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options:[], metrics:nil, views:["contentView":contentView])
                
        self.addConstraints(horizontalConstraint)
        self.addConstraints(verticalConstraint)
    }
    
    func configure(withPresenter presenter: HeaderPresentable) {
        self.dateLabel.text = presenter.dateString
        self.leagueLabel.text = presenter.leagueTitle
        self.imgView.image = UIImage(named: presenter.leagueImageName)
        self.dateLabel.hidden = presenter.dateString.isEmpty
    }
}
