import CoreMotion
import UIKit

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    private var motionData = [(timestamp: TimeInterval, accelX: Double, accelY: Double, accelZ: Double, gyroX: Double, gyroY: Double, gyroZ: Double)]()
    
    @Published var currentMotionData: [(timestamp: TimeInterval, accelX: Double, accelY: Double, accelZ: Double, gyroX: Double, gyroY: Double, gyroZ: Double)] = []
    
    func startRecordingMotionData() {
        guard motionManager.isAccelerometerAvailable, motionManager.isGyroAvailable else {
            print("Accelerometer or Gyroscope is not available.")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if let accelData = self.motionManager.accelerometerData, let gyroData = self.motionManager.gyroData {
                let timestamp = Date().timeIntervalSince1970
                let accelX = accelData.acceleration.x
                let accelY = accelData.acceleration.y
                let accelZ = accelData.acceleration.z
                let gyroX = gyroData.rotationRate.x
                let gyroY = gyroData.rotationRate.y
                let gyroZ = gyroData.rotationRate.z
                
                let newData = (timestamp, accelX, accelY, accelZ, gyroX, gyroY, gyroZ)
                self.motionData.append(newData)
                
                // Update published data for live UI update
                DispatchQueue.main.async {
                    self.currentMotionData.append(newData)
                }
            }
        }
    }
    
    func stopRecordingMotionData() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
    }
    
    func exportMotionDataToCSV() -> String {
        var csvString = "timestamp,accelX,accelY,accelZ,gyroX,gyroY,gyroZ\n"
        
        for data in motionData {
            csvString.append("\(data.timestamp),\(data.accelX),\(data.accelY),\(data.accelZ),\(data.gyroX),\(data.gyroY),\(data.gyroZ)\n")
        }
        
        return csvString
    }
    
    func saveCSVToDocuments(csvString: String, fileName: String) {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else {
            print("Unable to access document directory.")
            return
        }
        
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).csv")
        
        do {
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            print("CSV file saved successfully to: \(fileURL)")
        } catch {
            print("Error writing CSV file: \(error.localizedDescription)")
        }
    }
}
