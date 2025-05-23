import Foundation

protocol NamedIdentifiable: Identifiable, Equatable{
    var name: String { get }
}


protocol StringIdentifiableEnum: RawRepresentable, CaseIterable, Identifiable where RawValue == String {
    var displayName: String { get }
}
