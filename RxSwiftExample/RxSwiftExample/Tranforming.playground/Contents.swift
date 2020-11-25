import UIKit
import RxSwift

public func example(of description: String,
                    action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}

example(of: "toArray") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of("A", "B", "C")
        // 2
        .toArray()
        .subscribe(onSuccess: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    Observable.of("A","B","C")
        .toArray()
        .subscribe({
            print($0)
        })
}

example(of: "map") {
    
    let disposeBag = DisposeBag()
    
    // 1
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    // 저번 부분에 나왔던 문법
    
    // 2
    Observable<NSNumber>.of(123, 4, 56)
        // 3
        .map {
            formatter.string(from: $0) ?? ""
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    Observable.of(123, 4, 56)
        .map {
            formatter.string(from: $0) ?? ""
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}


example(of: "enumerated and map") {
    
    let disposeBag = DisposeBag()
    
    // 1
    Observable.of(1, 2, 3, 4, 5, 6)
        // 2
        .enumerated()
        // 3
        .map { index, integer in
            index > 2 ? integer * 2 : integer
        }
        // 4
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
}

struct Element {
    var element: BehaviorSubject<Int>
}

example(of: "flatMap Example 1") {
    
    let disposeBag = DisposeBag()
    
    // 초기 element 1, 2, 3
    let element1 = Element(element: BehaviorSubject(value: 1))
    let element2 = Element(element: BehaviorSubject(value: 2))
    let element3 = Element(element: BehaviorSubject(value: 3))
    
    let finalSequence = PublishSubject<Element>()
    // transform된 element를 subscribe한다. 이벤트가 발생할시 값을 출력
    
    finalSequence
        .flatMap { $0.element }
        .subscribe(onNext: {
            print($0 * 10)
        })
        .disposed(by: disposeBag)
    
    finalSequence.onNext(element1)
    finalSequence.onNext(element2)
    finalSequence.onNext(element3)
    
    element1.element.onNext(4)
    element2.element.onNext(5)
    finalSequence.dispose()
}

struct Student {
    
    var score: BehaviorSubject<Int>
}

example(of: "flatMap Example 2") {
    
    let disposeBag = DisposeBag()
    
    // 1
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    
    // 2
    let student = PublishSubject<Student>()
    
    // 3
    student
        .flatMap {
            $0.score
        }
        // 4
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    student.onNext(ryan)
    ryan.score.onNext(85)
    
    student.onNext(charlotte)
    ryan.score.onNext(95)
    
    charlotte.score.onNext(100)
    
}

example(of: "flatMapLatest") {
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMapLatest {
            $0.score
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    student.onNext(ryan)
    
    ryan.score.onNext(85)
    
    student.onNext(charlotte)
    
    // 1
    ryan.score.onNext(95)
    
    charlotte.score.onNext(100)
}

example(of: "materialize and dematerialize") {
    
    // 1
    enum MyError: Error {
        
        case anError
    }
    
    let disposeBag = DisposeBag()
    
    // 2
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 100))
    
    let student = PublishSubject<Student>()
    
    // 1
    let studentScore = student
        .flatMapLatest {
            $0.score.materialize()
        }
    
    // 2
    studentScore
        // 1
        .filter {
            guard $0.error == nil else {
                print($0.error!)
                return false
            }
            
            return true
        }
        // 2
        .dematerialize()
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    // 3
    
    student.onNext(ryan)
    
    ryan.score.onNext(85)
    
    ryan.score.onError(MyError.anError)
    
    ryan.score.onNext(90)
    
    // 4
    student.onNext(charlotte)
}
