import UIKit
import RxSwift

public func example(of description: String,
                    action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "just, of, from") {
    
    let one = 1
    let two = 2
    let three = 3
    
    // 하나만
    let observable: Observable<Int> = Observable<Int>.just(one)
    
    observable.subscribe { (event) in
        if let element = event.element {
            print(element)
        }
    }
    // 여러가지 모두, 배열까지
    let observable2 = Observable.of(one, two, three)
    
    observable2.subscribe { (event) in
        if let element = event.element {
            print(element)
        }
    }
    
    observable2.subscribe { (element) in
        print(element)
    }
    
    let observable3 = Observable.of([one, two, three])
    
    observable3.subscribe { (event) in
        if let element = event.element {
            print(element)
        }
    }
    // 배열만
    let observable4 = Observable.from([one, two, three])
    
    observable4.subscribe { (event) in
        if let element = event.element {
            print(element)
        }
    }
    // iterator, next 문법
    //let sequence = 0..<3
    //var iterator = sequence.makeIterator()
    //while let n = iterator.next() {
    //print(n)
    //}
    
    
}

example(of: "empty") {
    
    let observable = Observable<Void>.empty()
    
    observable
        .subscribe(
            
            // 1
            onNext: { element in
                print(element)
            },
            
            // 2
            onCompleted: {
                print("Completed")
            }
        )
}

example(of: "never") {
  
  let observable = Observable<Any>.never()
  
  observable
    .subscribe(
      onNext: { element in
        print(element)
    },
      onCompleted: {
        print("Completed")
    }
  )
}

example(of: "range") {
  
  // 1
  let observable = Observable<Int>.range(start: 1, count: 10)
  
  observable
    .subscribe(onNext: { i in
      
      // 2
      let n = Double(i)
      let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
      print(fibonacci)
  })
}

example(of: "dispose") {
    
    // 1
    let observable = Observable.of("A", "B", "C")
    
    // 2
    let subscription = observable.subscribe({ (event) in
        
        // 3
        print(event)
    })
    
    subscription.dispose()
}

example(of: "DisposeBag") {
     
     // 1
     let disposeBag = DisposeBag()
     
     // 2
     Observable.of("A", "B", "C")
         .subscribe{ // 3
             print($0)
         }
         .disposed(by: disposeBag) // 4
    
 }

example(of: "create") {
    let disposeBag = DisposeBag()
    
    Observable<String>.create({ (observer) -> Disposable in
        // 1
        observer.onNext("1")
        
        // 2
        observer.onCompleted()
        
        // 3
        observer.onNext("?")
        
        // 4
        return Disposables.create()
    })
        .subscribe(
            onNext: { print($0) },
            onError: { print($0) },
            onCompleted: { print("Completed") },
            onDisposed: { print("Disposed") }
    ).disposed(by: disposeBag)
}

enum MyError: Error {
     case anError
 }
 
 example(of: "create") {
     let disposeBag = DisposeBag()
     
     Observable<String>.create({ (observer) -> Disposable in
         // 1
         observer.onNext("1")
         
         // 3
         observer.onNext("?")
         
         // 4
         return Disposables.create()
     })
         .subscribe(
             onNext: { print($0) },
             onError: { print($0) },
             onCompleted: { print("Completed") },
             onDisposed: { print("Disposed") }
     ).disposed(by: disposeBag)
 }
