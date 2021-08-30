//
//  ViewController.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit



class MainPageVC: UIViewController {

    static var viewmodel = {
        NewsApiViewModel()
    }()
    
    static let baseUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4f550b85856b45ea88c892e9302a7d66"
    static let fetchData = AlamofireClass(baseURL: baseUrl)
    let splitVC = UISplitViewController(style: .doubleColumn)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSplitVC()
        fetchDataFromApi()
    }
    
    func fetchDataFromApi(){
        MainPageVC.fetchData.fetchData(){ success in
            print(success)
            if success{
                switch MainPageVC.fetchData.state{
                case .loading:
                    print("loading>>")
                case .success(let data):
                    MainPageVC.viewmodel.fetchNewsData(newsApiData: data.articles)
                }
            }else{
                print("No data to print")
            }
        }
    }
    
    func configureSplitVC(){
        view.addSubview(splitVC.view)
        let leftVC = LeftTableVC(style: .plain)
        let rightVC = RightVC()
        //leftVC.delegate = self
        rightVC.view.frame = view.bounds
        splitVC.viewControllers = [
            UINavigationController(rootViewController: leftVC),
            UINavigationController(rootViewController: rightVC)
        ]
        present(splitVC, animated: true)
    }
    
    func configureButton(){
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
        button.backgroundColor = .systemBlue
        button.setTitle("Show News results", for: .normal)
        view.addSubview(button)
        button.center = view.center
    }
}


