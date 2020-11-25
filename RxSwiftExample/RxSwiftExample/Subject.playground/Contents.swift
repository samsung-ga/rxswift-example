import UIKit
import RxSwift

public func example(of description: String,
                    action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "PublishSubject"){
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in print(string)})
    
    subject.on(.next("1"))
    subject.on(.next("2")) //new subscriber
    
    //subscriptionOne.dispose()
    //subject.onNext("4")
    
    let subscriptionTwo = subject.subscribe { event in print("2)", event.element ?? event)}
    
    subject.onNext("3")
    
    //1
    subject.onCompleted()
    //2
    subject.onNext("5")
    //3
    subscriptionTwo.dispose()
    let disposeBag = DisposeBag()
    
    //4
    subject.subscribe {
        print("3)", $0.element ?? $0)
    }.disposed(by: disposeBag)
    
    subject.onNext("?")
}

enum MyError:Error {
    case anError
}

example(of: "Behavior Subject")
{
    let subject = BehaviorSubject<String>(value: "")
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in print(string)})
    
    subject.on(.next("1"))
    subject.on(.next("2")) //new subscriber
    
    //subscriptionOne.dispose()
    //subject.onNext("4")
    
    let subscriptionTwo = subject.subscribe { event in print("2)", event.element ?? event)}
    
    subject.onNext("3")
    
    //1
    subject.onCompleted()
    //2
    subject.onNext("5")
    //3
    subscriptionTwo.dispose()
    let disposeBag = DisposeBag()
    
    //4
    subject.subscribe {
        print("3)", $0.element ?? $0)
    }.disposed(by: disposeBag)
    
    subject.onNext("?")
}


func print<T: CustomStringConvertible>(label: String, event: Event<T>)
{
    print(label, event.element ?? event.error
     ?? event)
}

example(of : "ReplaySubject") {
    
    let subject = ReplaySubject<String>.create(bufferSize: 3)
    
    // created new replay subject with a buffer size of 2. Replay subjects are initialized using the type method create(bufferSize: )
    
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    //add three elements onto the subjects
    
    subject.subscribe{
        print(label: "1)", event: $0)
    }.disposed(by: disposeBag)
    
    subject.subscribe{
        print(label: "2)", event: $0)
    }.disposed(by: disposeBag)
    //create twi subscriptions to the subject
}
