//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by 이재용 on 2020/11/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "채워주세요"
        
        return textField
    }()
        
    lazy var button: UIButton = {
        let button = UIButton()
        
        button.isHidden = true
        
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        
        textField.rx.text.filter {
            text in
            if text == "버튼 나와라!" {
                self.button.isHidden = false
                return false
            } else if text == "버튼 없어져라!" {
                self.button.isHidden = true
                return false
            } else {
                return true
            }
        }.subscribe { (text) in
            print(text ?? "")
        }.disposed(by: disposeBag)

        // Observer
        button.rx.tap.subscribe { (next) in
            self.textField.text = ""
        }.disposed(by: disposeBag)

    }

    func layout() {
        view.addSubview(button)
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textField.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        textField.layer.cornerRadius = 5
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }

}

