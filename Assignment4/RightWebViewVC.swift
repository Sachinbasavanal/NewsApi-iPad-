//
//  RightWebViewVC.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit
import WebKit

class RightVC:UIViewController,WKNavigationDelegate, WKUIDelegate{
    
    var webView = WKWebView(frame: .zero)
    var activityIndicator = UIActivityIndicatorView()
    var url = "https://abcnews.go.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MainPageVC.fetchDataFromApi()
        configureWebView(to: url)
        title = "Detail View"
    }
    
    init(url:String){
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSpinner(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
    func configureWebView(to url:String){
        webView.navigationDelegate = self
        webView.uiDelegate = self
        activityIndicator.center = view.center
        view.addSubview(webView)
        guard let url = URL(string: url) else {
            return
        }
        showSpinner()
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func animateSpinner(show:Bool){
        if show{
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        animateSpinner(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        animateSpinner(show: true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        animateSpinner(show: false)
    }
}
