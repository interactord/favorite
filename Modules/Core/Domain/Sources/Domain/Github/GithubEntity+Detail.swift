// MARK: - GithubEntity.Detail

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

    // MARK: Public

    public struct Owner: Equatable, Codable, Sendable {
      public let id: Int
      public let avatarURL: String
      public let login: String

      private enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
        case login
      }
    }

    public let id: Int
    public let fullName: String
    public let name: String
    public let desc: String?
    public let starCount: Int
    public let watcherCount: Int
    public let forkCount: Int
    public let topicList: [String]
    public let lastUpdate: String
    public let owner: Owner
    public let htmlURL: String?

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case id
      case fullName = "full_name"
      case name
      case desc = "description"
      case starCount = "stargazers_count"
      case watcherCount = "watchers_count"
      case forkCount = "forks_count"
      case topicList = "topics"
      case lastUpdate = "updated_at"
      case owner
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

    // MARK: Public

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

    // MARK: Private

    private enum CodingKeys: String, CodingKey {
      case login
      case name
      case location
      case avatarURL = "avatar_url"
      case htmlURL = "html_url"
      case bio
      case publicRepoCount = "public_repos"
      case publicGistCount = "public_gists"
      case followerListCount = "followers"
      case followingListCount = "following"
      case createDate = "created_at"
      case updateDate = "updated_at"
    }
  }
}
