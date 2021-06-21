//
//  ViewController.swift
//  ExploringEventKit
//
//  Created by anthony byrd on 6/20/21.
//

import UIKit
import EventKitUI
import EventKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    let store = EKEventStore()

    @objc func addButtonTapped() {
//        let calendarVC = EKCalendarChooser()
//        present(calendarVC, animated: true, completion: nil)
        
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.store else { return }

                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = "Testing EventKit"
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()

                    let editVC = EKEventEditViewController()
                    editVC.eventStore = store
                    editVC.event = newEvent
                    self?.present(editVC, animated: true, completion: nil)

                    let eventVC = EKEventViewController()
                    eventVC.delegate = self
                    eventVC.event = newEvent

//                    let navVC = UINavigationController(rootViewController: eventVC)
//                    self?.present(navVC, animated: true)
                }
            }
        }
    }
    
}//End of class

//MARK: - Extension
extension ViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        //AnthonyByrd - Add events
        controller.dismiss(animated: true, completion: nil)
    }
}//End of extension
