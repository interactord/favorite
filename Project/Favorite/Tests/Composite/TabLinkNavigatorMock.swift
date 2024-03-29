import Foundation
import LinkNavigator
import UIKit

public class TabLinkNavigatorMock {

  public var value: Value = .init()
  public var event: Event = .init()

  public func resetEvent() {
    event = .init()
  }

  public func resetValue() {
    value = .init()
  }

  public func resetAll() {
    resetEvent()
    resetValue()
  }
}

extension TabLinkNavigatorMock {
  public struct Value: Equatable, Sendable {
    public var currentPaths: [String] = []
    public var currentRootPaths: [String] = []
    public var rangePaths: [String] = []
  }

  public struct Event: Equatable, Sendable {
    public var next: Int = .zero
    public var rootNext: Int = .zero
    public var sheet: Int = .zero
    public var fullSheet: Int = .zero
    public var customSheet: Int = .zero
    public var replace: Int = .zero
    public var rootReplace: Int = .zero
    public var backOrNext: Int = .zero
    public var rootBackOrNext: Int = .zero
    public var back: Int = .zero
    public var remove: Int = .zero
    public var rootRemove: Int = .zero
    public var backToLast: Int = .zero
    public var rootBackToLast: Int = .zero
    public var close: Int = .zero
    public var reloadLast: Int = .zero
    public var rootReloadLast: Int = .zero
    public var alert: Int = .zero
    public var send: Int = .zero
    public var currentTabSend: Int = .zero
    public var mainSend: Int = .zero
    public var allSend: Int = .zero
    public var currentTabAllSend: Int = .zero
    public var moveTab: Int = .zero
    public var range: Int = .zero
    public var getCurrentRootPaths: Int = .zero
    public var getCurrentPaths: Int = .zero
  }
}

extension TabLinkNavigatorMock: LinkNavigatorFindLocationUsable, TabLinkNavigatorProtocol {
  public func getCurrentPaths() -> [String] {
    event.getCurrentPaths += 1
    return value.currentPaths
  }
  
  public func getCurrentRootPaths() -> [String] {
    event.getCurrentRootPaths += 1
    return value.currentRootPaths
  }
  
  public func next(linkItem: LinkItem, isAnimated: Bool) {
    event.next += 1
  }
  
  public func rootNext(linkItem: LinkItem, isAnimated: Bool) {
    event.rootNext += 1
  }
  
  public func sheet(linkItem: LinkItem, isAnimated: Bool) {
    event.sheet += 1
  }
  
  public func fullSheet(linkItem: LinkItem, isAnimated: Bool, prefersLargeTitles: Bool?) {
    event.fullSheet += 1
  }
  
  public func customSheet(
    linkItem: LinkItem,
    isAnimated: Bool,
    iPhonePresentationStyle: UIModalPresentationStyle,
    iPadPresentationStyle: UIModalPresentationStyle,
    prefersLargeTitles: Bool?)
  {
    event.customSheet += 1
  }
  
  public func replace(linkItem: LinkItem, isAnimated: Bool) {
    event.replace += 1
  }
  
  public func rootReplace(linkItem: LinkItem, isAnimated: Bool, closeAll: Bool) {
    event.rootReplace += 1
  }
  
  public func backOrNext(linkItem: LinkItem, isAnimated: Bool) {
    event.backOrNext += 1
  }
  
  public func rootBackOrNext(linkItem: LinkItem, isAnimated: Bool) {
    event.rootBackOrNext += 1
  }
  
  public func back(isAnimated: Bool) {
    event.back += 1
  }
  
  public func remove(pathList: [String]) {
    event.remove += 1
  }
  
  public func rootRemove(pathList: [String]) {
    event.rootRemove += 1
  }
  
  public func backToLast(path: String, isAnimated: Bool) {
    event.backToLast += 1
  }
  
  public func rootBackToLast(path: String, isAnimated: Bool) {
    event.rootBackToLast += 1
  }
  
  public func close(isAnimated: Bool, completeAction: @escaping () -> Void) {
    event.close += 1
  }
  
  public func range(path: String) -> [String] {
    event.range += 1
    return value.rangePaths
  }
  
  public func reloadLast(linkItem: LinkItem, isAnimated: Bool) {
    event.reloadLast += 1
  }
  
  public func rootReloadLast(linkItem: LinkItem, isAnimated: Bool) {
    event.rootReloadLast += 1
  }
  
  public func alert(target: NavigationTarget, model: Alert) {
    event.alert += 1
  }
  
  public func send(targetTabPath: String?, linkItem: LinkItem) {
    event.send += 1
  }
  
  public func currentTabSend(linkItem: LinkItem) {
    event.currentTabSend += 1
  }
  
  public func mainSend(linkItem: LinkItem) {
    event.mainSend += 1
  }
  
  public func allSend(linkItem: LinkItem) {
    event.allSend += 1
  }
  
  public func currentTabAllSend(linkItem: LinkItem) {
    event.currentTabAllSend += 1
  }
  
  public func moveTab(path: String) {
    event.moveTab += 1
  }

}
