
import SwiftUI
import AVKit

class SoundSetting: ObservableObject {
    
    /// singleton
    /*싱글 톤은 한 번만 생성 된 다음 사용해야하는 모든 곳에서 공유해야하는 객체 */
    static let instance = SoundSetting()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case Click
        case Knock
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 발생했습니다. \(error.localizedDescription)")
        }
    }
}

struct SoundEffectView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                SoundSetting.instance.playSound(sound: .Click)
            } label: {
                imageViews(imageName: "cursorarrow.rays", iconColor: .yellow)
            }
            
            Button {
                SoundSetting.instance.playSound(sound: .Knock)
            } label: {
                imageViews(imageName: "person.fill.questionmark", iconColor: .pink)
            }
        }
    }
}

//MARK: IMAGE VIEWS
struct imageViews: View {
    var imageName: String
    var iconColor: Color
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(iconColor)
    }
}

struct SoundEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SoundEffectView()
    }
}

