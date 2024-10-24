import CoreMotion
import SwiftUI

enum ThrowDirection: String {
    case left = "left"
    case right = "right"
    case center = "center"
}

class MotionCatcher: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var isThrowDetected = false
    @Published var throwDirection: ThrowDirection = .center
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 50.0 // Optional adjustment
            motionManager.startDeviceMotionUpdates(to: .main) { motionData, error in
                guard let data = motionData else {
                    print("Motion data를 가져오지 못했습니다.")
                    return
                }
                
                let accel = data.userAcceleration
                let rotation = data.rotationRate
                
                if abs(accel.x) > 3 || abs(accel.y) > 3 || abs(accel.z) > 3 ||
                    abs(rotation.x) > 10 || abs(rotation.y) > 10 || abs(rotation.z) > 10 {
                    
                    let isUpsideDown = data.gravity.z > 0
                    
                    if accel.x > 0 {
                        self.throwDirection = isUpsideDown ? .left : .right
                    } else if accel.x < 0 {
                        self.throwDirection = isUpsideDown ? .right : .left
                    } else {
                        self.throwDirection = .center
                    }

                    print("Throw 감지됨! 방향: \(self.throwDirection.rawValue)")
                    self.isThrowDetected = true
                    self.stopMotionUpdates()
                }
            }
        } else {
            print("DeviceMotion 사용 불가")
        }
    }
    
    func stopMotionUpdates() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}
