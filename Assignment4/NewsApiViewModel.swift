//
//  NewsApiViewModel.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit

class NewsApiViewModel:NSObject{
    
    static let network = AlamofireClass(baseURL: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4f550b85856b45ea88c892e9302a7d66")
    
    var newsApiData = [Article]()
    
    var newViewModel = [CellModel](){
        didSet{
            refreshTableView?()
        }
    }
    var refreshTableView: (()->Void)?
    
    func getViewModel(at indexPath:IndexPath)->CellModel{
        print(indexPath.row)
        return newViewModel[indexPath.row]
    }
    
    func createNewsSubViewModel(newsApiData:Article)->CellModel{
        let name = newsApiData.author
        let title = newsApiData.title
        let url = newsApiData.url
        let imageUrl = newsApiData.urlToImage
        return CellModel(author: name, title: title, url: url,imageUrl: imageUrl)
    }
    
    func fetchNewsData(newsApiData:[Article]){
        self.newsApiData = newsApiData
        var viewModels = [CellModel]()
        for newsArticle in newsApiData{
            viewModels.append(createNewsSubViewModel(newsApiData: newsArticle))
        }
        newViewModel = viewModels
    }
}
