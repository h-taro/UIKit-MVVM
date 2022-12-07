//
//  TableViewCell.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import THLogger
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    private lazy var apiService: APIService = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(repository: GitHubRepository) {
        label.text = repository.fullName
        subtitle.text = repository.description ?? "lorem epsum"
        updateThumbnail(repository.owner.avatarURL)
    }
    
    private func updateThumbnail(_ url: String) {
        Task {
            guard let url = URL(string: url) else { return }
            
            do {
                let data = try await apiService.getAvatarData(avatarURL: url)
                
                let image = UIImage(data: data)
                avatarImageView.image = image
            } catch {
                THLogger.error(error)
            }
        }
    }
}
