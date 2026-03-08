import SwiftUI
import AVFoundation

struct MultiCamView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIView {
        context.coordinator.view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

class Coordinator: NSObject {
    
    let session = AVCaptureMultiCamSession()
    let sessionQueue = DispatchQueue(label: "multiCam.session.queue")
    let view = UIView()
    
    override init() {
        super.init()
        configureSession()
    }
    
    private func configureSession() {
        
        guard AVCaptureMultiCamSession.isMultiCamSupported else {
            print("MultiCam not supported")
            return
        }
        
        sessionQueue.async {
            
            self.session.beginConfiguration()
            self.session.sessionPreset = .inputPriority
            
            // MARK: - Back (Wide)
            guard let backDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                           for: .video,
                                                           position: .back)
            else { return }
            
            self.configureDevice(backDevice)
            
            guard let backInput = try? AVCaptureDeviceInput(device: backDevice),
                  self.session.canAddInput(backInput)
            else { return }
            
            self.session.addInputWithNoConnections(backInput)
            
            let backPreviewLayer = AVCaptureVideoPreviewLayer(sessionWithNoConnection: self.session)
            backPreviewLayer.videoGravity = .resizeAspectFill
            
            guard let backPort = backInput.ports.first else { return }
            
            let backConnection = AVCaptureConnection(inputPort: backPort,
                                                     videoPreviewLayer: backPreviewLayer)
            
            if self.session.canAddConnection(backConnection) {
                self.session.addConnection(backConnection)
            }
            
            DispatchQueue.main.async {
                backPreviewLayer.frame = self.view.bounds
                self.view.layer.addSublayer(backPreviewLayer)
            }
            
            
            // MARK: - Front
            guard let frontDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                            for: .video,
                                                            position: .front)
            else { return }
            
            self.configureDevice(frontDevice)
            
            guard let frontInput = try? AVCaptureDeviceInput(device: frontDevice),
                  self.session.canAddInput(frontInput)
            else { return }
            
            self.session.addInputWithNoConnections(frontInput)
            
            let frontPreviewLayer = AVCaptureVideoPreviewLayer(sessionWithNoConnection: self.session)
            frontPreviewLayer.videoGravity = .resizeAspectFill
            
            guard let frontPort = frontInput.ports.first else { return }
            
            let frontConnection = AVCaptureConnection(inputPort: frontPort,
                                                      videoPreviewLayer: frontPreviewLayer)
            
            if self.session.canAddConnection(frontConnection) {
                self.session.addConnection(frontConnection)
            }
            
            DispatchQueue.main.async {
                frontPreviewLayer.frame = CGRect(x: 20,
                                                 y: 60,
                                                 width: 160,
                                                 height: 220)
                self.view.layer.addSublayer(frontPreviewLayer)
            }
            
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
    
    
    private func configureDevice(_ device: AVCaptureDevice) {
        do {
            try device.lockForConfiguration()
            
            device.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 30)
            device.activeVideoMaxFrameDuration = CMTime(value: 1, timescale: 30)
            
            device.unlockForConfiguration()
        } catch {
            print("Device configuration failed")
        }
    }
}
