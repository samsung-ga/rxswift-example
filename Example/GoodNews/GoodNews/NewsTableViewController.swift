//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Wody on 2022/01/30.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private var articles: [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        pupulateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError() }
        
        cell.titleLabel.text = articles[indexPath.row].title
        cell.subTitleLabel.text = articles[indexPath.row].description
        
        return cell
    }
    private func pupulateNews() {
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] in
                if let result = $0 {
                    self?.articles = result.articles
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    
}
