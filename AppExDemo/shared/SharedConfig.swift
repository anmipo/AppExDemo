import Foundation

enum SharedConfig {
    static let kClientID = "8ae5b7df-e338-45f5-8cf4-fd9cae07ec20"
    static let kRedirectUri = "msauth.com.notcontoso.appexdemo://auth"
    static let kAuthority = "https://login.microsoftonline.com/common"
    static let kGraphEndpoint = "https://graph.microsoft.com/"
    
    // Enables data sharing between the app and extension
    static let appGroupID = "group.com.notcontoso.appexdemo"
    static func getSharedContainerURL() -> URL? {
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupID)
    }
}
