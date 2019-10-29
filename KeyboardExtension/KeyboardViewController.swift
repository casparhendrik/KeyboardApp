//
//  KeyboardViewController.swift
//  KeyboardExtension
//
//  Created by Caspar van Boom on 23/10/2019.
//  Copyright © 2019 Caspar van Boom. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var keyboardView: KeyboardView!

    override func viewDidLoad() {
      super.viewDidLoad()
      // 2
      let nib = UINib(nibName: "KeyboardView", bundle: nil)
      let objects = nib.instantiate(withOwner: nil, options: nil)
      keyboardView = objects.first as! KeyboardView
      guard let inputView = inputView else { return }
      inputView.addSubview(keyboardView)
        keyboardView.delegate = self
      
      // 3
      keyboardView.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        keyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
        keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
        keyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
        keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
    }
}

extension KeyboardViewController: KeyboardViewDelegate {
    func insertCharacter(_ newCharacter: String) {
        self.textDocumentProxy.insertText(newCharacter)
    }
    
    func deleteCharacterBeforeCursor() {
    }
    
    func characterBeforeCursor() -> String? {
        return ""
    }
    
    
}
