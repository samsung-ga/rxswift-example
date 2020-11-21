//
//  ViewController.swift
//  RxSwiftProject1
//
//  Created by 이재용 on 2020/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 이런식으로 할 경우 뷰업데이트가 막힙니다.
        DispatchQueue.main.async {
            self.doWork()
            self.view.backgroundColor = .black
        }
        
        let queue = DispatchQueue.init(label: "work-queue")
        queue.async {
            self.doWork()
        }
        DispatchQueue.main.async {
            self.view.backgroundColor = .black
        }
    }
    
    private func doWork() {
        
    }

}

