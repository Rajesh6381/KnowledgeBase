//
//  Extension.swift
//  KBDashBoard
//
//  Created by Rajesh R on 05/03/24.
//

import Foundation

extension String{
    func changeDateFormat() -> String?{
        let inputFormatter = ISO8601DateFormatter()
        inputFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMM yyyy hh:mm a"
            
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    func htmlFormat() -> String{
        let html = """
<!DOCTYPE html>
<html>
<head>
<script>
    function notify(){
        var body = document.body,
        html = document.documentElement;
        var contentHeight = document.getElementById(bodyContent);

        console.log(body.getBoundingClientRect().height)

        var height = Math.max(body.getBoundingClientRect().height,35);
        console.log("Notifier called" + height);
        window.webkit.messageHandlers.getHeight.postMessage({height: height})
        
    }
</script>
        <meta name="viewport" content="height=device-height" />
</head>
<body onload="notify()" id="bodyContent">
    \(self)
</body>

</html>
"""
        return html
    }
}
