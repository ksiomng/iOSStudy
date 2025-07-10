//
//  TodoTableViewCell.swift
//  0707
//
//  Created by Song Kim on 7/10/25.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet var checkboxButton: UIButton!
    @IBOutlet var todoTextLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
