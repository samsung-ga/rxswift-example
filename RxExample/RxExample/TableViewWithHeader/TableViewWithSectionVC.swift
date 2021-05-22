//
//  TableViewWithHeaderVC.swift
//  RxExample
//
//  Created by 이재용 on 2021/05/22.
//

import UIKit

class TableViewWithSectionVC: UIViewController {

    let colors: [UIColor] = [.blue, .black, .red, .yellow, .green]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 10
    }
    
    @IBOutlet weak var tableView: UITableView!
    
}

extension TableViewWithSectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewWithSectionTVC", for: indexPath) as? TableViewWithSectionTVC else { return UITableViewCell() }
        
        cell.label.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = colors[Int.random(in: 0..<5)]
        
        let label = UILabel()
        label.text = "Repository"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        return view
    }
    
}
