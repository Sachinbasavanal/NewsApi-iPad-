//
//  NewsApiModel.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit

struct NewsApiModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
