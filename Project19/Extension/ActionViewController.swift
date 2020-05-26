//
//  ActionViewController.swift
//  Extension
//
//  Created by Daniel Gx on 25/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var script: UITextView!
    var pageTitle = ""
    var pageURL = ""
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        customizeNavigationController()
        keyboardHandler()
    }
    
    // MARK: - Methods
    
    func setup() {
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard
                        let self = self,
                        let itemDictionary = dict as? NSDictionary,
                        let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary
                        else { return }
                    
                    self.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }
    
    func customizeNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
    
    func keyboardHandler() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Actions
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text ?? ""]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        self.extensionContext!.completeRequest(returningItems: [item])
    }

}
