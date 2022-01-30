//
//  ViewController.swift
//  CameraFilter
//
//  Created by Wody on 2022/01/30.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let photosCollectionViewController = navigationController.viewControllers.first as? PhotosCollectionViewController else { return }
        photosCollectionViewController.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        self.imageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
    @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.imageView.image else  { return }
       
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { [weak self] in
                self?.imageView.image = $0
            }).disposed(by: disposeBag)
    }
}

