//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by Wody on 2022/01/30.
//

import UIKit
import RxCocoa
import RxSwift
class AddTaskViewController: UIViewController {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    private let taskSubject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        taskSubject.asObservable()
    }
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let priority = Priority(rawValue: self?.prioritySegmentedControl.selectedSegmentIndex ?? 0),
                      let title = self?.taskTitleTextField.text else { return }
                let task = Task(title: title, priority: priority)
                self?.taskSubject.onNext(task)
                self?.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)

    }
}
