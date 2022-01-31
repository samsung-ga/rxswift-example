//
//  ViewController.swift
//  GoodWeather
//
//  Created by Wody on 2022/01/31.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
class ViewController: UIViewController {
    
    @IBOutlet weak var citynameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.citynameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.citynameTextField.text }
            .compactMap { $0 }
            .subscribe(onNext: {
                self.fetchWeather(by: $0)
            }).disposed(by: disposeBag)
        
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL.urlForWeatherAPI(city: cityEncoded) else {
            return
        }
        
        let resource = Resource<WeatherResult>(url: url)
        let search = URLRequest.load(resource: resource)
            .asDriver(onErrorJustReturn: WeatherResult.empty)

        search.map {"\($0.main.temp) 𝙵" }
        .drive(self.temperatureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💦" }
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag)
    }
}
