import UIKit
import RxSwift
import RxRelay
import PlaygroundSupport

let disposeBag = DisposeBag()

let observable = Observable.of(1,2,3)
observable
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

observable
    .reduce(0, accumulator: {
        summary, newValue in
        return summary + newValue
    })
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)

