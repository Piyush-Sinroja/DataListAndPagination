//
//  PostDetailsVC.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import UIKit

class PostDetailsVC: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var lblPostDetails: UILabel!
    
    // MARK: - Variables
    let viewModel = PostDetailsViewModel()
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        lblPostDetails.text = "\(viewModel.postModel?.body ?? "")"
    }
}
