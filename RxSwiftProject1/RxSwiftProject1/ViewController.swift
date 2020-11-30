//
//  ViewController.swift
//  RxSwiftProject1
//
//  Created by 이재용 on 2020/11/21.
//

import UIKit
import RxSwift

let MOVIE_LIST: String = "https://my.api.mockaroo.com/myapi.json?key=30fca5f0"

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var editView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timerLabel.text = "\(Date().timeIntervalSince1970)"
        }
    }
    
    private func setVisibleWithAnimation(_ v: UIView?, _ s: Bool) {
        
        guard let v = v else { return }
        UIView.animate(withDuration: 0.3, animations: { [weak v] in
            v?.isHidden = !s
        }, completion: { [weak self] _ in
            self?.view.layoutIfNeeded()
        })
    }
    
    private func download(_ url: String) -> Observable<String?> {
        
        // Thread 생성
        return Observable.create { (emitter) -> Disposable in
            
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard error == nil else  {
                    emitter.onError(error!)
                    return
                }
                
                if let dat = data, let json = String(data: dat, encoding: .utf8) {
                    // 방출된 값으로 UIView를 조작할 경우 main Thread에서 실행되어야함
                    emitter.onNext(json)
                    return
                }
                
                emitter.onCompleted()
            }
            
            task.resume()
            
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func onLoad(_ sender: UIButton) {
        editView.text = ""
        setVisibleWithAnimation(activityIndicator, true)
        
        _ = download(MOVIE_LIST).subscribe({ (event) in
            switch event {
            case .next(let data):
                // 이 부분을 줄이는 방법도 있읉텐데
                DispatchQueue.main.async {
                    self.editView.text = data
                    self.setVisibleWithAnimation(self.activityIndicator, false)
                }
                break
            case .error(let error):
                let alertVC = UIAlertController(title: "오류", message: "\(error)", preferredStyle: .alert)
                self.present(alertVC, animated: true, completion: nil)
                break
            case .completed:
                break
            }
        })
        
//        DispatchQueue.global().async {
//            let url = URL(string: MOVIE_LIST)!
//            let data = try! Data(contentsOf: url)
//            let json = String(data: data, encoding: .utf8)
//            DispatchQueue.main.async {
//                self.editView.text = json
//                self.setVisibleWithAnimation(self.activityIndicator, false)
//            }
//        }
        
    }
}

