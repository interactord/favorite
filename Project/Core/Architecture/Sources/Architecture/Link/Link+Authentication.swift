import Foundation

// MARK: - Link.Authentication

extension Link {
  public enum Authentication { }
}

// MARK: - Link.Authentication.Path

extension Link.Authentication {
  public enum Path: String, Equatable {
    case signIn
    case signUp
    case home
  }
}
