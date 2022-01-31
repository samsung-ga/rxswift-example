import UIKit
import RxSwift
import RxRelay
import PlaygroundSupport

let disposeBag = DisposeBag()

Observable.of(1,2,3,4,5,6,7,8,9)
    .buffer(timeSpan: .seconds(2), count: 4, scheduler: MainScheduler.instance)
    .subscribe(onNext: {
        print($0)
    }).disposed(by: disposeBag)
