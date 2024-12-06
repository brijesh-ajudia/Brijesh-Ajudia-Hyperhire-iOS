//
//  PlaylistTVCell.swift
//  DemoHyperhire
//
//  Created by Brijesh Ajudia on 06/12/24.
//

import UIKit

class PlaylistTVCell: UITableViewCell {
    
    @IBOutlet weak var imgCover: UIImageView!
    
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongBy: UILabel!
    
    @IBOutlet weak var btnMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
