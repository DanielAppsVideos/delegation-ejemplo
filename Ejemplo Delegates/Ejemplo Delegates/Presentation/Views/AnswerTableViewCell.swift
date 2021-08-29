//
//  AnswerTableViewCell.swift
//  Ejemplo Delegates
//
//  Created by danielapps on 18/08/21.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    static let identifier = "AnswerCell"
    static let nib = "AnswerTableViewCell"
    var minHeight: CGFloat?
    @IBOutlet weak var answerOption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minimalHeight = minHeight else {return size}
        return CGSize(width: size.width, height: max(size.height, minimalHeight))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
