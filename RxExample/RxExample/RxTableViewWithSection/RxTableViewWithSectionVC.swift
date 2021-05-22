//
//  RxTableViewWithSectionVC.swift
//  RxExample
//
//  Created by 이재용 on 2021/05/22.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa

class RxTableViewWithSectionVC: UIViewController {

    let disposeBag = DisposeBag()
    let items = Observable.just([
        SectionModel(model: "Mammal", items: [
            "Elephants",
            "Rabbits",
            "Tiger"
        ]),
        SectionModel(model: "Reptile", items: [
            "Snake",
            "Lizard"
        ])
    ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
            configureCell: { (_, tv, indexPath, element) in
                guard let cell = tv.dequeueReusableCell(withIdentifier: "RxTableViewWithSectionTVC") as? RxTableViewWithSectionTVC else  {
                    print("Error")
                    return UITableViewCell() }

                cell.textLabel?.text = element
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
        
        items
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
    
    @IBOutlet weak var tableView: UITableView!
}
