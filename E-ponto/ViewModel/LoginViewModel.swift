//
//  LoginViewModel.swift
//  E-ponto
//
//  Created by Denis Nascimento on 31/05/17.
//  Copyright (c) 2017 Denis Nascimento. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let validatedEmail: Driver<Bool>
    let validatedPassword: Driver<Bool>
    let loginEnabled: Driver<Bool>
    
    let signedIn: Driver<User?>
    
    let signingIn: Driver<Bool>
    
    init(input: (username: Driver<String>,
        password: Driver<String>,
        loginTap: Driver<Void>)) {
        
        self.validatedEmail = input.username
            .map { $0.characters.count >= 5 }
        
        self.validatedPassword = input.password
            .map { $0.characters.count >= 4 }
        
        self.loginEnabled = Driver.combineLatest(validatedEmail, validatedPassword ) { $0 && $1 }
        let userAndPassword = Driver.combineLatest(input.username, input.password) {($0,$1)}
        
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asDriver()
        
        signedIn = input.loginTap.withLatestFrom(userAndPassword)
            .flatMapLatest{ (username, password) in
            return LoginViewModel.login(username: username, password: password)
                .trackActivity(signingIn)
                .asDriver(onErrorJustReturn: nil)
        }
    }
    
    private class func login(username: String?, password: String?) -> Observable<User?> {
        return  Observable.create { observer in
            let disposeBag = Disposables.create()
            
            guard let username = username, let password = password else {
                observer.onError(AError.General("Username or password null."))
                return disposeBag
            }
            
            Auth.auth().signIn(withEmail: username, password: password, completion: { (user, error) in
                if let user = user {
                    observer.onNext(User(email: user.email ?? "", password: ""))
                }
                if let er = error {
                    observer.onError(er)
                }
            })
            
            return disposeBag
        }
    }
}


