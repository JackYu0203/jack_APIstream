//
//  TableViewCell.swift
//  jack_APIstream
//
//  Created by JackYu on 2021/3/1.
//

import UIKit

class TableViewCell: UITableViewCell {
    

    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
