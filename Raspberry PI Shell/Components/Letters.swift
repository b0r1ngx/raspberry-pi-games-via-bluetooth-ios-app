import SwiftUI

struct Letters: View {
    var letters: String
    
    var body: some View {
        HStack {
            ForEach(
                Array(letters.enumerated()),
                id: \.offset
            ) { letter in
                Letter(letter: letter.element)
            }
        }
    }
}

struct Letter: View {
    var letter: Character
    
    var body: some View {
        let color = switch letter {
            case "T": Red
            case "C": Blue
            case "A": Green
            case "G": Black
            default: Black
        }
        
        Text(String(letter))
            .font(.system(
                size: 32,
                weight: .bold
            ))
            .foregroundStyle(color)
    }
}

#Preview {
    Letters(
        letters:"ATGC"
    )
}
