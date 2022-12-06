//
//  TableViewCell.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(repository: GitHubRepository) {
        label.text = repository.fullName
        subtitle.text = repository.description ?? "lorem epsum"
    }
}
