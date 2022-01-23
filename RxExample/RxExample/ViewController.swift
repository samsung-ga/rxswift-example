//
//  ViewController.swift
//  RxExample
//
//  Created by 이재용 on 2021/05/14.
//

import RxSwift
import UIKit

class ViewController: UIViewController {

  let bag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // MARK: Observable Sequences

    let fibonacciSequence = Observable.from([0,1,1,2,3,5,8])
    let dictSequence = Observable.from([1:"Hello",2:"World"])
    
    let helloSequence = Observable.of("Hello Rx")

    let subscription = helloSequence.subscribe { event in
      switch event {
      case .next(let value):
        print(value)
      case .error(let error):
        print(error)
      case .completed:
        print("completed")
      }
    }
    
    // MARK: Subjects
    
    var publishSubject = PublishSubject<String>()
    publishSubject.onNext("Hello")
    publishSubject.onNext("World")
    
    let subscription1 = publishSubject.subscribe(onNext: {
      print($0)
    }).disposed(by: bag)
    publishSubject.onNext("Hello")
    publishSubject.onNext("Again")
    
    let subscription2 = publishSubject.subscribe(onNext:{
      print(#line,$0)
    })

    publishSubject.onNext("Both Subcriptions recieve this message")
    
    
    Observable<Int>.of(1,2,3,4).map { value in
      return value * 10
    }.subscribe(onNext: {
      print($0)
    }).disposed(by: bag)
    
    let sequence1 = Observable<Int>.of(1,2)
    
    
  }
  
}

