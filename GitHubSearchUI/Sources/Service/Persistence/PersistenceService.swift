//
//  PersistenceService.swift
//  GitHubSearchUI
//
//  Created by Presto on 2019/12/09.
//  Copyright © 2019 presto. All rights reserved.
//

import CoreData
import class UIKit.UIApplication

// https://medium.com/@ankurvekariya/core-data-crud-with-swift-4-2-for-beginners-40efe4e7d1cc
final class PersistenceService {
  var managedContext: NSManagedObjectContext! {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContaienr.viewContext
  }

  func fetch() -> [GitHubFavoriteUser]? {
    return try? managedContext.fetch(GitHubFavoriteUser.fetchRequest()) as? [GitHubFavoriteUser]
  }

  func save(_ model: GitHubUser) {
    let savingModel = GitHubFavoriteUser(context: managedContext)
    savingModel.avatarURL = model.avatarURLString
    savingModel.id = Int64(model.id)
    savingModel.score = model.score
    savingModel.username = model.username
    try? managedContext.save()
  }

  func delete(_ model: GitHubUser) {
    guard let deletingModel = fetch()?.first(where: { $0.id == model.id }) else { return }
    managedContext.delete(deletingModel)
    try? managedContext.save()
  }

  func contains(_ model: GitHubUser) -> Bool {
    return !(fetch()?.filter { $0.id == model.id }.isEmpty ?? true)
  }
}
