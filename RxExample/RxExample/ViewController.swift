//
//  ViewController.swift
//  RxExample
//
//  Created by 이재용 on 2021/05/14.
//

import RxSwift
import UIKit

class ViewController: UIViewController {

    // MARK: - Constants
    let disposeBag = DisposeBag()
    let MY_API: String = "https://my.api.mockaroo.com/myapi.json?key=30fca5f0"
    
    // MARK: - Properties

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "TestLabel"
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        updateUI()
    }

    // MARK: - Private Methods

    private func setUI() {
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        label.numberOfLines = 0
    }
    
    func showLabelText(_ url: String) -> Observable<String> {
        return Observable.create { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                if let d = data, let json = String(data: d, encoding: .utf8) {
                        emitter.onNext(json)
                }
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
              
    
    private func updateUI() {
        showLabelText(MY_API)
            .subscribe(onNext: { t in
                DispatchQueue.main.async {
                    self.label.text = t
                }
                print("next")
            }, onError: { e in
                print(e)
            }, onCompleted: {
                print("done")
            }, onDisposed: {
                print("disposed")
            })
            .dispose()
    }
}

