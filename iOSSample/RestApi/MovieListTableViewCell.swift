//
//  MovieListTableViewCell.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/30.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblGenre: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
