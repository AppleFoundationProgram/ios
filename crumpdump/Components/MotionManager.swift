import CoreMotion
import UIKit

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private var motionData = [MotionData]()
    private var timer: Timer?
    
    @Published var currentMotionData: [MotionData] = []
    
    func startRecordingMotionData(label: String) {
        guard motionManager.isAccelerometerAvailable, motionManager.isGyroAvailable else {
            print("Accelerometer 또는 Gyroscope가 사용 불가능합니다.")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()

        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            
            if let accelData = self.motionManager.accelerometerData, let gyroData = self.motionManager.gyroData {
                let timestamp = Date().timeIntervalSince1970
                let newData = MotionData(
                    timestamp: timestamp,
                    accelX: accelData.acceleration.x,
                    accelY: accelData.acceleration.y,
                    accelZ: accelData.acceleration.z,
                    gyroX: gyroData.rotationRate.x,
                    gyroY: gyroData.rotationRate.y,
                    gyroZ: gyroData.rotationRate.z,
                    label: label
                )
                
                self.motionData.append(newData)
                
                DispatchQueue.global().async {
                    self.currentMotionData.append(newData)
                }
            }
        }
    }
    
    func stopRecordingMotionData() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        timer?.invalidate()
    }
    
    func exportMotionDataToCSV() -> String {
        var csvString = "id,timestamp,accelX,accelY,accelZ,gyroX,gyroY,gyroZ,label\n"
        
        for data in motionData {
            csvString.append("\(data.id.uuidString),\(data.timestamp),\(data.accelX),\(data.accelY),\(data.accelZ),\(data.gyroX),\(data.gyroY),\(data.gyroZ),\(data.label)\n")
        }
        
        return csvString
    }
    
    func saveCSVToDocuments(csvString: String, fileName: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else {
            print("문서 디렉토리를 찾을 수 없습니다.")
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).csv")
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV 파일이 저장되었습니다: \(fileURL)")
        } catch {
            print("CSV 파일 저장 중 오류 발생: \(error.localizedDescription)")
        }
    }
}
