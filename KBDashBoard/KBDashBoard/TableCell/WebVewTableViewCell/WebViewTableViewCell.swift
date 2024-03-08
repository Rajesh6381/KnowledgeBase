//
//  WebViewTableViewCell.swift
//  KBDashBoard
//
//  Created by Rajesh R on 01/03/24.
//

import UIKit
import WebKit

enum HtmlId: String{
    case BodyHeight = "getHeight"
}

protocol WebView: AnyObject{
    func webViewCellHeightDidChange( height: CGFloat)
}

class WebViewTableViewCell: UITableViewCell, WKNavigationDelegate {
    
    weak var delegate: WebView?
    @IBOutlet weak var webContents: WKWebView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    static let identifier = "WebViewTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.webContents.navigationDelegate = self
        self.webContents.isInspectable = true
        self.webContents.scrollView.bounces = false
        self.webContents.scrollView.showsVerticalScrollIndicator = false
    }
    
    
    
    static func nib() -> UINib{
        return UINib(nibName: WebViewTableViewCell.identifier, bundle: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webContents.evaluateJavaScript("Math.max(document.body.getBoundingClientRect().height,35)"){(value,error) in
            guard let height = value as? CGFloat else{
                return
            }
            self.delegate?.webViewCellHeightDidChange(height: height + 20.0)
        }
    }
    
    

    func update(div: String) {
        let html = div.htmlFormat()
        webContents.loadHTMLString(html, baseURL: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
