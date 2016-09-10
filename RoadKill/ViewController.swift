//
//  ViewController.swift
//  RoadKill
//
//  Created by jianhao on 2016/9/10.
//  Copyright © 2016年 cocoaswifty. All rights reserved.
//  https://developers.facebook.com/docs/swift/sharing/content-types
//  https://developers.facebook.com/apps/1869901443231083/review-status/

import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare

class ViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createLoginButton()

        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let accessToken = AccessToken.current {
            // User is logged in, use 'accessToken' here.
            print(accessToken.userId)
            print(accessToken.authenticationToken)
            print(accessToken.grantedPermissions)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

//Facebook
extension ViewController {
    
    @IBAction func shareButtonPressed(sender: UIButton) {
        let content = LinkShareContent(url: NSURL(fileURLWithPath: "https://developers.facebook.com"))
        
        let sharer = GraphSharer(content: content)
        sharer.failsOnInvalidData = true
        sharer.completion = { result in
            // Handle share results
        }
        
        
        do {
            try sharer.share()
        } catch {
            print(error)
        }
//
//        
//        let content = LinkShareContent(url: NSURL(fileURLWithPath: "https://developers.facebook.com"), title: "MyTitle")
//        
//        let shareDialog = ShareDialog(content: content)
//        shareDialog.mode = .Native
//        shareDialog.failsOnInvalidData = true
//        shareDialog.completion = { result in
//            // Handle share results
//            print(result)
//        }
//        
//        do {
//            try shareDialog.show()
//        } catch {
//            print(error)
//        }
        
//        let photo = Photo(image: UIImage(named: "logo")!, userGenerated: true)
//        let content = PhotoShareContent(photos: [photo])
//        
//        let dialog = ShareDialog(content: content)
//        dialog.presentingViewController = self
//        dialog.mode = .Automatic
//        do {
//            try dialog.show()
//        } catch (let error) {
//            let alertController = UIAlertController(title: "Invalid share content", message: "Failed to present share dialog with error \(error)", preferredStyle: .ActionSheet)
//            let action = UIAlertAction(title: "OK", style: .Default) { _ in
//                print("ok")
//            }
//            alertController.addAction(action)
//            presentViewController(alertController, animated: true, completion: nil)
//        }
        
        
        
        
    }
    
    func createLoginButton() {
        //        // Add a custom login button to your app
        //        let myLoginButton = UIButton(type: .Custom)
        //        myLoginButton.backgroundColor = UIColor.darkGrayColor()
        //        myLoginButton.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        //        myLoginButton.center = view.center
        //        myLoginButton.setTitle("My Login Button", forState: .Normal)
        //
        //        // Handle clicks on the button
        //        myLoginButton.addTarget(self, action: #selector(loginButtonClicked), forControlEvents: .TouchUpInside)
        //
        //        // Add the button to the view
        //        view.addSubview(myLoginButton)
        
        
        
        let loginButton = LoginButton(readPermissions: [ .PublicProfile ])
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
    }
    
    
    func loginManagerDidComplete(result: LoginResult) {
        var alertController: UIAlertController
        switch result {
        case .Failed(let error):
            print(error)
            alertController = UIAlertController(title: "Login Fail", message: "Login failed with error \(error)", preferredStyle: .Alert)
        case .Cancelled:
            print("User cancelled login.")
            alertController = UIAlertController(title: "Login Cancelled", message: "User cancelled login.", preferredStyle: .Alert)
        case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
            print(grantedPermissions, declinedPermissions, accessToken)
            print("Logged in!")
            alertController = UIAlertController(title: "Login Success",
                                                message: "登入成功", preferredStyle: .ActionSheet)
        }
        let action = UIAlertAction(title: "OK", style: .Default) { _ in
            print("ok")
        }
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func loginButtonDidCompleteLogin(loginButton: LoginButton, result: LoginResult) {
        loginManagerDidComplete(result)
    }
    
    func loginButtonDidLogOut(loginButton: LoginButton) {
        print("log out")
    }
    
    
    
    //    func loginButtonClicked() {
    //
    //        let loginManager = LoginManager()
    //        loginManager.logIn([ .PublicProfile, .Email ], viewController: self) { loginResult in
    //            var alertController: UIAlertController
    //            switch loginResult {
    //            case .Failed(let error):
    //                print(error)
    //                alertController = UIAlertController(title: "Login Fail", message: "Login failed with error \(error)", preferredStyle: .Alert)
    //            case .Cancelled:
    //                print("User cancelled login.")
    //                alertController = UIAlertController(title: "Login Cancelled", message: "User cancelled login.", preferredStyle: .Alert)
    //            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
    //                print(grantedPermissions, declinedPermissions, accessToken)
    //                print("Logged in!")
    //                alertController = UIAlertController(title: "Login Success",
    //                                                    message: "Login succeeded with granted permissions: \(grantedPermissions)", preferredStyle: .Alert)
    //            }
    //            self.presentViewController(alertController, animated: true, completion: nil)
    //        }
    //        
    //    }
}

