//
//  LeftTableVC.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit

class LeftTableVC: UITableViewController {
    
    var model:AlamofireClass?
    let rowCellIdentifier = "TableViewCell"
    let loadingCellIdentifier = "LoadingCell"
    let refresher = UIRefreshControl()
    var downloadTask:URLSessionDownloadTask?
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.delegate = self
        tableView.dataSource = self
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refresher
        downloadTask?.cancel()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Helper methods
    
    func configureTableView(){
        MainPageVC.viewmodel.refreshTableView = {[weak self] in
            self?.tableView.reloadData()
        }
        var cellNib = UINib(nibName: rowCellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: rowCellIdentifier)
        cellNib = UINib(nibName: loadingCellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: loadingCellIdentifier)
        title = "News Update"
    }
    
    @objc func refresh(){
        MainPageVC.fetchDataFromApi()
        MainPageVC.viewmodel.refreshTableView = {[weak self] in
            self?.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
    }
    
    func customiseTableViewCell(_ tableCell:UITableViewCell){
        tableCell.backgroundColor = UIColor.white
        tableCell.layer.borderColor = UIColor.gray.cgColor
        tableCell.layer.borderWidth = 3
        tableCell.layer.cornerRadius = 8
        tableCell.clipsToBounds = true
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MainPageVC.fetchData.state{
        case .loading:
            return 1
            
        case .success(let data):
            return data.articles.count
        }
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MainPageVC.fetchData.state{
        case .loading:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier, for: indexPath) as? LoadingCell else {
                fatalError("Cell with data doesnot exist")
            }
            let spinner = cell.viewWithTag(10) as! UIActivityIndicatorView
            spinner.startAnimating()
            //customiseTableViewCell(cell)
            return cell
            
        case .success(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: rowCellIdentifier, for: indexPath) as? TableViewCell else {
                fatalError("Cell with data doesnot exist")
            }
            let loadingSpinner = cell.viewWithTag(11) as! UIActivityIndicatorView
            loadingSpinner.startAnimating()
            let newResult = data.articles[indexPath.row]
            downloadTask = cell.imageOutlet.loadImage(url: URL(string: newResult.urlToImage ??  "https://picsum.photos/id/870/200/300?grayscale&blur=2")!)
            cell.imageOutlet.clipsToBounds = true
            cell.imageOutlet.contentMode = .scaleAspectFill
            cell.imageOutlet.layer.cornerRadius = 10
            cell.titleOutlet.text = newResult.title
            cell.bgView.frame = cell.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            //customiseTableViewCell(cell)
            return cell
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellResult = MainPageVC.viewmodel.getViewModel(at: indexPath)
        let url = RightVC(url: cellResult.url!)
        showDetailViewController(url, sender: nil)
    }
}
