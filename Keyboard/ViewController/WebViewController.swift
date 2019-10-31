//
//  ViewController.swift
//  Keyboard
//
//  Created by Caspar van Boom on 23/10/2019.
//  Copyright © 2019 Caspar van Boom. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UISearchBarDelegate, WKUIDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadBar: UIProgressView!

    lazy var webViewPresenter = WebViewPresenter(with: self)
    
    @IBAction func back(_ sender: Any) {
        if (webView.canGoBack) {
            webView.goBack()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func next(_ sender: Any) {
        if (webView.canGoForward) {
            webView.goForward()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        loadBar.setProgress(0, animated: false)
        if let url = URL(string: searchBar.text!) {
            webView.load(URLRequest(url: url))
        } else {
            print("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        loadBar.progressViewStyle = .default
        loadBar.sizeToFit()
        
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        
        self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        webViewPresenter.getDeviceData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "estimatedProgress") {
            loadBar.setProgress(Float(webView!.estimatedProgress), animated: true)
        }
    }
}


extension WebViewController: WebViewPresenterView {
    func sendHardWareDataToView(deviceName: String, deviceModel: String) {
//        let alertController = UIAlertController(title: "Alert", message: "You are using this device: " + deviceName + " " + deviceModel, preferredStyle: .alert)
//        self.present(alertController, animated: true, completion: nil)
    }
}

