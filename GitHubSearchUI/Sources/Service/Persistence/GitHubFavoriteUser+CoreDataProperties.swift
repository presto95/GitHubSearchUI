//
//  GitHubFavoriteUser+CoreDataProperties.swift
//
//
//  Created by Presto on 2019/12/09.
//
//

import CoreData
import Foundation

extension GitHubFavoriteUser {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<GitHubFavoriteUser> {
    return NSFetchRequest<GitHubFavoriteUser>(entityName: "GitHubFavoriteUser")
  }

  @NSManaged public var avatarURL: String?
  @NSManaged public var id: Int64
  @NSManaged public var score: Double
  @NSManaged public var username: String?
}
