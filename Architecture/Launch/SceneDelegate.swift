//
//  SceneDelegate.swift
//  Architecture
//
//  Created by Hanson on 2022/3/11.
//

import AdSupport
import AppTrackingTransparency
import UIKit
var identify: UUID?

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // 参考苹果的官方文档 https://developer.apple.com/documentation/
        // apptrackingtransparency/attrackingmanager/3547037-requesttrackingauthorization
        // 1.在APP进入激活后，再进行检查授权
        // 2.查看授权状态，如果 notDetermined 发起授权请求
//        checkTracking()
    }
}

extension SceneDelegate {
    private func checkTracking() {
        if #available(iOS 14, *) {
            let trackState = ATTrackingManager.trackingAuthorizationStatus
            switch trackState {
            case .authorized:// 已经授权
                identify = ASIdentifierManager.shared().advertisingIdentifier
                print(identify?.uuidString ?? "")
            case .notDetermined:// 还未弹窗给用户, 延迟 0.5 秒弹窗，让APP完全进入 Active
                GCDUtils.delay(0.5) { self.requestTrackingAuthorization() }
            case .denied, .restricted:// 拒绝/受限 跳转设置
                showMessageAndGoSetting()
            default:
                break
            }
        } else {
            if !ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                showMessageAndGoSetting()
            } else {
                identify = ASIdentifierManager.shared()
                    .advertisingIdentifier
                print(identify?.uuidString ?? "")
            }
        }
    }

    private func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in
                GCDUtils.main { self.checkTracking() }
            }
        }
    }

    private func showMessageAndGoSetting() {
        // 1.显示提示，我这里就忽略了，直接跳转设置
        // 2.用户点击提示框上的按钮，再跳转设置页面
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
