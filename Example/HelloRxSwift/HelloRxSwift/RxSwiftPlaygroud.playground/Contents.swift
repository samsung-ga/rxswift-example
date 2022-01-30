import UIKit
import RxSwift
import PlaygroundSupport

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()
let trigger = PublishSubject<String>()

subject.sample(trigger, defaultValue: nil)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

subject.onNext("A")
subject.onNext("B")

trigger.onNext("Go")

subject.onNext("C")

trigger.onNext("Go")
trigger.onNext("Go")

subject.onNext("C")

trigger.onNext("Go")
