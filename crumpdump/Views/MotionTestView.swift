import SwiftUI
import CoreMotion

struct MotionData: Identifiable {
    let id = UUID()
    let timestamp: TimeInterval
    let accelX: Double
    let accelY: Double
    let accelZ: Double
    let gyroX: Double
    let gyroY: Double
    let gyroZ: Double
    let label: String
}

struct MotionTestView: View {
    @StateObject private var motionManager = MotionManager()
    @State private var isRecording = false
    @State private var statusMessage = "Press 'Start' to begin recording"
    @State private var currentLabel = "Not Throw"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(statusMessage)
                .font(.headline)
                .padding()

            Picker("Select Label", selection: $currentLabel) {
                Text("Not Throw").tag("Not Throw")
                Text("Throw").tag("Throw")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            List(motionManager.currentMotionData, id: \.id) { data in
                VStack(alignment: .leading) {
                    Text("Timestamp: \(data.timestamp)")
                    Text("Accel: X: \(data.accelX), Y: \(data.accelY), Z: \(data.accelZ)")
                    Text("Gyro: X: \(data.gyroX), Y: \(data.gyroY), Z: \(data.gyroZ)")
                    Text("Label: \(data.label)")
                }
                .padding(5)
            }
            
            Button(action: {
                if isRecording {
                    motionManager.stopRecordingMotionData()
                    let csvString = motionManager.exportMotionDataToCSV()
                    motionManager.saveCSVToDocuments(csvString: csvString, fileName: "MotionData")
                    statusMessage = "Recording stopped. Data saved as CSV."
                } else {
                    motionManager.startRecordingMotionData(label: currentLabel) 
                    statusMessage = "Recording motion data with label: \(currentLabel)"
                }
                isRecording.toggle()
            }) {
                Text(isRecording ? "Stop Recording" : "Start Recording")
                    .font(.title2)
                    .padding()
                    .background(isRecording ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct MotionTestView_Previews: PreviewProvider {
    static var previews: some View {
        MotionTestView()
    }
}
