import SwiftUI

struct MotionTestView: View {
    @StateObject private var motionManager = MotionManager()
    @State private var isRecording = false
    @State private var statusMessage = "Press 'Start' to begin recording"
    
    var body: some View {
        VStack(spacing: 20) {
            Text(statusMessage)
                .font(.headline)
                .padding()

            List(motionManager.currentMotionData, id: \.timestamp) { data in
                VStack(alignment: .leading) {
                    Text("Timestamp: \(data.timestamp)")
                    Text("Accel: X: \(data.accelX), Y: \(data.accelY), Z: \(data.accelZ)")
                    Text("Gyro: X: \(data.gyroX), Y: \(data.gyroY), Z: \(data.gyroZ)")
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
                    motionManager.startRecordingMotionData()
                    statusMessage = "Recording motion data..."
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
