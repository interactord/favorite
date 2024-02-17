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
