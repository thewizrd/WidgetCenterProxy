//
//  WidgetCenterProxy.swift
//  WidgetCenterProxy
//
//  Created by huszarcsaba on 2020. 09. 22..
//

import Foundation
import WidgetKit
import Intents

@available(iOS 14.0, *)
@objc(WidgetCenterProxy)
public class WidgetCenterProxy : NSObject {
    
    @objc
    public func reloadTimeLines(ofKind: String){
        WidgetCenter.shared.reloadTimelines(ofKind: ofKind)
    }
    
    @objc
    public func reloadAllTimeLines() {
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    @available(iOS 16.0, *)
    @objc
    public func invalidateConfigurationRecommendations() {
        WidgetCenter.shared.invalidateConfigurationRecommendations()
    }
    
    @objc
    public func getCurrentConfigurations( completion: @escaping ([WidgetInfoProxy]) -> Void){
        WidgetCenter.shared.getCurrentConfigurations { results in
            do {
                let value = try results.get()
                
                var widgetInfoArr: [WidgetInfoProxy] = []
                
                for widgetInfo in value {
                    let proxy = WidgetInfoProxy()
                    proxy.kind = widgetInfo.kind
                    proxy.family = widgetInfo.family.rawValue
                    proxy.configuration = widgetInfo.configuration
                    
                    widgetInfoArr.append(proxy)
                }

                completion(widgetInfoArr)
            } catch {
                completion([])
            }
        }
    }
}
