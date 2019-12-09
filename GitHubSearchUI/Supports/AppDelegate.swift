//
//  AppDelegate.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/03.
//  Copyright © 2019 presto. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {}

  // MARK: - Core Data Stack

  lazy var persistentContaienr: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "GitHubSearchUI")
    container.loadPersistentStores { _, error in
      if let error = error {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
    return container
  }()

  func saveContext() {
    let context = persistentContaienr.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch let error as NSError {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
}
