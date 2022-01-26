import Foundation

struct Meanings: Codable {
    let id: String
    let wordID, difficultyLevel: Int
    let partOfSpeechCode, welcomePrefix, text, soundURL: String
    let transcription: String
    let properties: Properties
    let updatedAt, mnemonics: String
    let translation: Translations
    let images: [Image]
    let definition: Definition
    let examples: [Definition]
    let meaningsWithSimilarTranslations: [MeaningsWithSimilarTranslations]
    let alternativeTranslationss: [AlternativeTranslations]

    enum CodingKeys: String, CodingKey {
        case id
        case wordID = "wordId"
        case difficultyLevel, partOfSpeechCode
        case welcomePrefix = "prefix"
        case text
        case soundURL = "soundUrl"
        case transcription, properties, updatedAt, mnemonics, translation, images, definition, examples, meaningsWithSimilarTranslations, alternativeTranslationss
    }
}

struct AlternativeTranslations: Codable {
    let text: String
    let Translations: Translations
}

struct Translations: Codable {
    let text, note: String
}

struct Definition: Codable {
    let text, soundURL: String

    enum CodingKeys: String, CodingKey {
        case text
        case soundURL = "soundUrl"
    }
}

struct Image: Codable {
    let url: String
}

struct MeaningsWithSimilarTranslations: Codable {
    let meaningID: Int
    let frequencyPercent, partOfSpeechAbbreviation: String
    let translations: Translations

    enum CodingKeys: String, CodingKey {
        case meaningID = "meaningId"
        case frequencyPercent, partOfSpeechAbbreviation, translations
    }
}

struct Properties: Codable {
}

