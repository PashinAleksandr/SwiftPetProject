//
//  ViewController.swift
//  Core data
//
//  Created by Aleksandr Pashin on 23.08.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        saveUsers()
        
        let users = fetchUsers()
        users.forEach { user in
            print(user.name! + " " + user.email!)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        users[0].email = "gmail.com"
        try? context.save()
//        delete(user: users[0])
    }
    
    func delete(user: User) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(user)
        try? context.save()
    }
    
    func saveUsers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let andey: User = User(context: context)
        let alex: User = User(context: context)
        let dima: User = User(context: context)
        let masha: User = User(context: context)
        let ira: User = User(context: context)
        
        alex.email = "2112412"
        alex.name = "Alex"
        andey.name = "akdnj"
        andey.email = ""
        ira.email = "|"
        ira.name = "w2w242"
        masha.email = "242"
        masha.name = "daaf"
        dima.email = "qr12r13"
        dima.name = "124141gwt"
        
        try? context.save()
    }
    
    func fetchUsers() -> [User] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let users = try! context.fetch(User.fetchRequest()) as! [User]
        return users
    }


}

