//
//  TableViewCell.swift
//  iOSSample
//
//  Created by HongInJun on 2021/04/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
