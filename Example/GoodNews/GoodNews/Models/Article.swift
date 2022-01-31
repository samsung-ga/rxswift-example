//
//  Article.swift
//  GoodNews
//
//  Created by Wody on 2022/01/31.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=kr&apiKey=cb4c23ff636e41f3aa03702bdd077766")!
        return Resource(url: url)
    }()
}
struct Article: Decodable {
    let title: String
    let description: String
}
