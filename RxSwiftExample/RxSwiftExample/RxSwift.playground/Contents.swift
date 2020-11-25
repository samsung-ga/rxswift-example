import UIKit
import RxSwift

public func example(of description: String,
                    action: () -> Void) {
    print("\n— Example of:", description, "—")
    action()
}

example(of: "ignoreElements") {
    
    // 1
    let strikes = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    // 2
    strikes
        .ignoreElements()
        .subscribe(
            onNext: { event in
                print(event)
            },
            onCompleted: {
                print("Complete")
            }
        )
        .disposed(by: disposeBag)
    
    strikes.onNext("1")
    strikes.onNext("2")
    strikes.onNext("3")
    strikes.onCompleted()
}

example(of: "elementAt") {
    
    // 1
    let strikes = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    //  2
    strikes
        .element(at: 1)
        .subscribe(
            onNext: { event in
                print(event)
            },
            onCompleted: {
                print("Complete")
            }
        )
        .disposed(by: disposeBag)
    
    strikes.onNext("a")
    strikes.onNext("b")
    strikes.onNext("c")
    
}

example(of: "filter") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of(1,2,3,4,5,6)
        // 2
        .filter({ (int) -> Bool in
            int % 3 == 0
        })
        // 3
        .subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("End")
        })
        .disposed(by: disposeBag)
}

example(of: "skip") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of("A", "B", "C", "D", "E", "F")
        // 2
        .skip(3)
        .subscribe(onNext: {
            print($0)
        }, onCompleted: {
            print("Complete")
        })
        .disposed(by: disposeBag)
}

example(of: "skipWhile") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of(2, 2, 3, 4, 4)
        // 2
        .skip(while: {$0 % 2 == 0})
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "skipUntil") {
    let disposeBag = DisposeBag()
    
    // 1
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    // 2
    subject
        .skip(until: trigger)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    // 3
    subject.onNext("A")
    subject.onNext("B")
    
    // 4
    trigger.onNext("X")
    
    // 5
    subject.onNext("C")
}

example(of: "take") {
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of(1,2,3,4,5,6)
        // 2
        .take(3)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "takeWhile") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of(2, 4, 7, 8, 2, 5, 4, 4, 6, 6)
        // 2
        .enumerated()
        // 3
        .take(while: { index, value in
            // 4
            value % 2 == 0 && index < 3
        })
        // 4
        .map { $0.element }
        // 5
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

example(of: "takeUntil") {
    
    let disposeBag = DisposeBag()
    
    // 1
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    // 2
    subject
        .take(until:trigger)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    // 3
    subject.onNext("1")
    subject.onNext("2")
    
    trigger.onNext("X")
    
//    trigger.disposed(by: disposeBag)
    subject.onNext("3")
    
}

example(of: "distincUntilChanged") {
        let disposeBag = DisposeBag()
        
        // 1
        Observable.of("A", "A", "B", "B", "A")
            //2
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
