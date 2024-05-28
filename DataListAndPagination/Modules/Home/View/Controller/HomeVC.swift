//
//  HomeVC.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - IBOutlets
    
    //
    @IBOutlet weak var tableViewPostList: UITableView!
    
    // MARK: - Variables
    
    private let homeViewModel = HomeViewModel()
    private let reuseIdentifier = "PostTableViewCell"
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Initializing UI Methods
    
    /// initial setup view
    func setupUI() {
        tableViewPostList?.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        tableViewPostList.estimatedRowHeight = 88
        tableViewPostList.rowHeight = UITableView.automaticDimension
        displayData()
        
        homeViewModel.getPostListAPI()
    }

    /// display data
    func displayData() {
        homeViewModel.updateEventHandler = { [weak self] state in
            guard let weakSelf = self else {
                return
            }
            switch state {
            case .loading:
                weakSelf.createTableViewFooterLoader()
            case .success:
                DispatchQueue.main.async {
                    weakSelf.tableViewPostList.tableFooterView = nil
                    weakSelf.tableViewPostList.reloadData()
                }
            case .failedAF(let error):
                DispatchQueue.main.async {
                    weakSelf.tableViewPostList.tableFooterView = nil
                    weakSelf.showAlert(withTitle: "Error", andMessage: "\(error?.localizedDescription ?? "")")
                }
            case .reloadTableView:
                DispatchQueue.main.async {
                    weakSelf.tableViewPostList.reloadData()
                }
            }
        }
    }
    
    // MARK: - Helper Method
    
    /// create table view footer loader
    func createTableViewFooterLoader() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableViewPostList.bounds.width, height: CGFloat(44))
        self.tableViewPostList.tableFooterView = spinner
        self.tableViewPostList.tableFooterView?.isHidden = false
        spinner.startAnimating()
    }
}


// MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.numberOfRows - 1 { //Here am checking if the cell is second last element
            homeViewModel.getPostListAPI()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewPostList?.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        let model = homeViewModel.getPost(index: indexPath.row)
        cell.configureCell(postModel: model)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postDetailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PostDetailsVC") as? PostDetailsVC else { return }
        postDetailsVC.viewModel.postModel = homeViewModel.getPost(index: indexPath.row)
        navigationController?.pushViewController(postDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
