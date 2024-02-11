extension GithubEntity {
  public enum Search {}
}

extension GithubEntity.Search {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String
    public let page: Int
    public let perPage: Int

    public init(query: String, page: Int = 1, perPage: Int = 30) {
      self.query = query
      self.page = page
      self.perPage = perPage
    }

    enum CodingKeys: String, CodingKey {
      case query = "q"
      case page
      case perPage = "per_page"
    }
  }

  public struct Response: Equatable, Codable, Sendable {
    public let totalCount: Int
    public let itemList: [Item]

    private enum CodingKeys: String, CodingKey {
      case totalCount = "total_count"
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Identifiable, Sendable {
    public let id: Int
    public let fullName: String
    public let desc: String?
    public let starCount: Int
    public let watcherCount: Int
    public let forkCount: Int
    public let topicList: [String]
    public let lastUpdate: String
    public let owner: Owner

    private enum CodingKeys: String, CodingKey {
      case id
      case fullName = "full_name"
      case desc = "description"
      case starCount = "stargazers_count"
      case watcherCount = "watchers_count"
      case forkCount = "forks_count"
      case topicList = "topics"
      case lastUpdate = "updated_at"
      case owner
    }
  }

  public struct Owner: Equatable, Codable, Sendable {
    public let id: Int
    public let avatarURL: String

    private enum CodingKeys: String, CodingKey {
      case id
      case avatarURL = "avatar_url"
    }
  }
}

extension GithubEntity.Search {
  public struct Composite: Equatable, Sendable {
    public let request: GithubEntity.Search.Request
    public let response: GithubEntity.Search.Response
    public init(
      request: GithubEntity.Search.Request,
      response: GithubEntity.Search.Response)
    {
      self.request = request
      self.response = response
    }
  }
}
