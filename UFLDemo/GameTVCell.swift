//
//  GameTVCell.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 23/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class GameTVCell : UITableViewCell {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var homeTeamBadge: UIImageView!
    @IBOutlet weak var awayTeamBadge: UIImageView!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gameStatusLabel: UILabel!
    
    func configure(withPresenter presenter: GamePresentable) {
        //configure the cell UI
        self.homeTeamBadge.image = UIImage(named:presenter.homeTeamImageName)
        self.awayTeamBadge.image = UIImage(named:presenter.awayTeamImageName)
        self.homeTeam.text = presenter.homeTeam
        self.awayTeam.text = presenter.awayTeam
        self.indicatorView.backgroundColor = UIColor(hex:presenter.gameHexColor)
        
        self.scoreLabel.text = presenter.score
        self.timeLabel.text = presenter.gameTime
        
        //hide or show the time and score, depending if the game is finished or not
        self.timeLabel.hidden = presenter.gameFinished
        self.gameStatusLabel.hidden = !presenter.gameFinished
        self.scoreLabel.hidden = !presenter.gameFinished
    }
}
