import Foundation

extension GithubEntity {
  public struct Like: Codable, Equatable, Sendable {
    public let repoList: [GithubEntity.Detail.Repository.Response]
    public let userList: [GithubEntity.Detail.User.Response]

    public init(
      repoList: [GithubEntity.Detail.Repository.Response] = [],
      userList: [GithubEntity.Detail.User.Response] = [])
    {
      self.repoList = repoList
      self.userList = userList
    }
  }
}
