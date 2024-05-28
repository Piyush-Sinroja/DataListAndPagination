//
//  PostTableViewCell.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configure Cell
    
    /// configure cell with details
    /// - Parameter postModel: PostDetailsModel
    func configureCell(postModel: PostModel?) {
        guard let postModel = postModel else {
            return
        }
        idLabel.text = "Id: \(postModel.id ?? 0)"
        userIdLabel.text = "User Id: \(postModel.userId ?? 0)"
        titleLabel.text = "Title: \(postModel.title)"
    }
}
