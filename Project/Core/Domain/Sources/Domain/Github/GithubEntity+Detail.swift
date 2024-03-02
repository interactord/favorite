extension GithubEntity {
  public enum Detail {
    public enum Repository { }
    public enum User { }
  }

}

extension GithubEntity.Detail.Repository {
  public struct Request: Equatable, Codable, Sendable {
    public let ownerName: String
    public let repositoryName: String

    public init(ownerName: String, repositoryName: String) {
      self.ownerName = ownerName
      self.repositoryName = repositoryName
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let fullName: String
    public let htmlURL: String

    private enum CodingKeys: String, CodingKey {
      case fullName = "full_name"
      case htmlURL = "html_url"
    }
  }
}

extension GithubEntity.Detail.User {
  public struct Request: Equatable, Codable, Sendable {
    public let ownerName: String

    public init(ownerName: String) {
      self.ownerName = ownerName
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let login: String
    public let name: String?
    public let location: String?
    public let avatarURL: String
    public let htmlURL: String
    public let bio: String
    public let publicRepoCount: Int
    public let publicGistCount: Int
    public let followerListCount: Int
    public let followingListCount: Int
    public let createDate: String
    public let updateDate: String

    private enum CodingKeys: String, CodingKey {
      case login = "login"
      case name = "name"
      case location = "location"
      case avatarURL = "avatar_url"
      case htmlURL = "html_url"
      case bio = "bio"
      case publicRepoCount = "public_repos"
      case publicGistCount = "public_gists"
      case followerListCount = "followers"
      case followingListCount = "following"
      case createDate = "created_at"
      case updateDate = "updated_at"
    }
  }
}
