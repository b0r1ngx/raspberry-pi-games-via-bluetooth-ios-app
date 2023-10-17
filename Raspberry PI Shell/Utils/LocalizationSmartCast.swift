import Foundation

postfix operator ~
postfix func ~(string: String.LocalizationValue) -> String {
    return String(localized: string)
}
