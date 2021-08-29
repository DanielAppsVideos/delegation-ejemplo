//
//  LevelsTableViewCell.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 11/08/21.
//

import UIKit

class LevelsTableViewCell: UITableViewCell {
    
    static let identifier = "levelsCell"
    static let nibName = "LevelsTableViewCell"
    
    @IBOutlet weak var levelState: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        levelLabel.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
