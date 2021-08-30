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
    
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        tableView.delegate = self
        tableView.dataSource = self
        MainPageVC.viewmodel.refreshTableView = {[weak self] in
            self?.tableView.reloadData()
        }
        var cellNib = UINib(nibName: rowCellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: rowCellIdentifier)
        cellNib = UINib(nibName: loadingCellIdentifier, bundle: .main)
        tableView.register(cellNib, forCellReuseIdentifier: loadingCellIdentifier)
        title = "LeftTableVC"
        print(model?.newsApiModel?.totalResults as Any)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            return cell
            
        case .success(let data):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: rowCellIdentifier, for: indexPath) as? TableViewCell else {
                fatalError("Cell with data doesnot exist")
            }
            let newResult = data.articles[indexPath.row]
            cell.authorOutlet.text = newResult.author
            cell.titleOutlet.text = newResult.title
            return cell
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellResult = MainPageVC.viewmodel.getCellViewModel(at: indexPath)
        let url = RightVC(url: cellResult.url!)
        showDetailViewController(url, sender: nil)
    }
}
