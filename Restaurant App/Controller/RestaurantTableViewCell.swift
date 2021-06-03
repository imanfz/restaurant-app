//
//  RestaurantTableViewCell.swift
//  Restaurant App
//
//  Created by Iman Faizal on 01/06/21.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var nameRestaurant: UILabel!
    @IBOutlet weak var descRestaurant: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
