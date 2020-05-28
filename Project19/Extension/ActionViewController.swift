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
    var scripts = [String]()
    var titleScript: String?
    var bodyScript: String?
    
    // MARK: - Actions
    
    @objc func recentsTapped() {
        let ac = UIAlertController(title: "Scripts", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Examples", style: .default) { [weak self] _ in
            self?.examplesTapped()
        })
        present(ac, animated: true)
    }
    

    
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
                    self.saveURL(javaScriptValues["URL"] as? String ?? "", title: javaScriptValues["title"] as? String ?? "")
                    
                    DispatchQueue.main.async {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }
    
    func customizeNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(recentsTapped))
    }
    
    func keyboardHandler() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func examplesTapped() {
        let ac = UIAlertController(title: "Examples", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        for script in Script.shared.script {
            ac.addAction(UIAlertAction(title: script.title, style: .default) { [weak self] _ in
                self?.script.text = script.body
            })
        }
        
        present(ac, animated: false)
    }
    
    func saveURL(_ url: String, title: String) {
        guard let url = URL(string: url) else { return }
        let userDefaults = UserDefaults.standard
        userDefaults.set(url.host, forKey: title)
    }
    
    func setScriptTitle() {
        let ac = UIAlertController(title: "Script Name", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter script title, please!"
        }
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] (action) in
            guard let title = ac.textFields?.first?.text else { self?.setScriptTitle(); return }
            self?.titleScript = title
        }))
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
        bodyScript = script.text ?? ""
        Script.shared.script.append(UserScript(title: titleScript ?? "Unknown", body: bodyScript ?? "Empty"))
        self.extensionContext!.completeRequest(returningItems: [item])
    }

}
