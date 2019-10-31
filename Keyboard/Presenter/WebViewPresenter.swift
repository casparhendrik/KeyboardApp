//
//  webViewPresenter.swift
//  Keyboard
//
//  Created by Caspar van Boom on 30/10/2019.
//  Copyright © 2019 Caspar van Boom. All rights reserved.
//

import ALSystemUtilities

protocol WebViewPresenterView: class {
    func sendHardWareDataToView(deviceName: String, deviceModel: String)
}

class WebViewPresenter {
    
    weak var view: WebViewPresenterView?
    
    init(with view: WebViewPresenterView) {
        self.view = view
    }
    
    func getDeviceData() {
        var systemInfo = utsname()
        
        self.view?.sendHardWareDataToView(deviceName: ALHardware.deviceName(), deviceModel: ALHardware.platformType())
        
    }
}
