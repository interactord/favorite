// MARK: - GithubEntity.Search

extension GithubEntity {
  public enum Search {
    public enum Repository { }
    public enum User { }
  }
}

extension GithubEntity.Search.Repository {
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

    public init(totalCount: Int, itemList: [Item]) {
      self.totalCount = totalCount
      self.itemList = itemList
    }

    private enum CodingKeys: String, CodingKey {
      case totalCount = "total_count"
      case itemList = "items"
    }
  }

  public struct Item: Equatable, Codable, Identifiable, Sendable {

    // MARK: Public

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
}

// MARK: - GithubEntity.Search.Repository.Composite

extension GithubEntity.Search.Repository {
  public struct Composite: Equatable, Sendable {
    public let request: GithubEntity.Search.Repository.Request
    public let response: GithubEntity.Search.Repository.Response
    public init(
      request: GithubEntity.Search.Repository.Request,
      response: GithubEntity.Search.Repository.Response)
    {
      self.request = request
      self.response = response
    }
  }
}

extension GithubEntity.Search.User {
  public struct Request: Equatable, Codable, Sendable {
    public let query: String
    public let page: Int

    public init(query: String, page: Int = 1) {
      self.query = query
      self.page = page
    }

    private enum CodingKeys: String, CodingKey {
      case query = "q"
      case page
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
    public let loginName: String
    public let avatarUrl: String

    private enum CodingKeys: String, CodingKey {
      case id
      case loginName = "login"
      case avatarUrl = "avatar_url"
    }
  }
}

// MARK: - GithubEntity.Search.User.Composite

extension GithubEntity.Search.User {
  public struct Composite: Equatable, Sendable {
    public let request: GithubEntity.Search.User.Request
    public let response: GithubEntity.Search.User.Response

    public init(
      request: GithubEntity.Search.User.Request,
      response: GithubEntity.Search.User.Response)
    {
      self.request = request
      self.response = response
    }
  }
}
