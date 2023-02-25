//
//  CircularTimer.swift
//  Outers_Game
//
//  Created by saba on 01/08/1444 AH.
//

 
         
import SwiftUI
import RealityKit
import ARKit
import Vision


       
         
        struct CircularTimer: View {
            let timer = Timer
                .publish(every: 1, on: .main, in: .common)
                .autoconnect()
            @State var ispressed2 : Bool = false
            @State var counter: Int = 0
            var countTo: Int = 10
             
            var body: some View {
                ZStack{
                    ARViewContainer8().edgesIgnoringSafeArea(.all)
                    //                    ARViewContainer7()
//                    if ispressed2 == false{
                        //                        ARViewContainer8().edgesIgnoringSafeArea(.all)
                        if ispressed2{
                            
                            LosePopUp()
                        }  else {
                            VStack{
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 60)
                                        .fill(Color.black)
                                        .opacity(0.5)
                                        .frame(width: 350, height: 50)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 60).trim(from:0, to: progress())
                                                .stroke(
                                                    style: StrokeStyle(
                                                        lineWidth: 15,
                                                        lineCap: .round,
                                                        lineJoin:.round
                                                    )
                                                )
                                                .foregroundColor(
                                                    (completed() ? Color.red : Color.blue)
                                                ).animation(
                                                    .linear(duration: 1)))
                                    
                                    
                                    Clock(counter: counter, countTo: countTo)
                                }    .padding(.top,670)
                            }
                            
                            .onAppear{
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 11.5){
                                    
                                    withAnimation{
                                        self.ispressed2 = true
                                    }}
                                
                            }
                            
                            
                            
                            .onReceive(timer) { time in
                                if (self.counter < self.countTo) {
                                    self.counter += 1
                                }
                            }
                        }
                        
                    }}
                
                
//            }
            
            
            
            
            
            func completed() -> Bool {
                return progress() == 1
            }
             
            func progress() -> CGFloat {
                return (CGFloat(counter) / CGFloat(countTo))
            }
        }
         
        struct Clock: View {
            var counter: Int
            var countTo: Int
             
            var body: some View {
                VStack {
                    Text(counterToMinutes())
                        .font(.system(size: 30 , weight: .heavy, design: .rounded))
                        .fontWeight(.black)
                        .foregroundColor(.white)
                        .opacity(0.8)
                      
                }
             
            }
             
            func counterToMinutes() -> String {
                let currentTime = countTo - counter
                let seconds = currentTime % 60
                let minutes = Int(currentTime / 60)
                 
        //        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
                return "\(seconds < 10 ? "0" : "")\(seconds)"
            }
        }
 











struct CircularTimer_Previews: PreviewProvider {
    static var previews: some View {
        CircularTimer()
    }
}





struct ARViewContainer8: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: HandInteractionARViewController1, context: Context) {
        
    }
    
 
  
    
//    @State var score: Int = 0

    func makeUIViewController(context: UIViewControllerRepresentableContext<ARViewContainer8>) -> HandInteractionARViewController1 {
        let viewController = HandInteractionARViewController1()
        
//        viewController.setScore = {
//            self.score = $0
//        }

//        viewController.getScore = {
//            self.score
//        }

        return viewController
    }
    
    func updateUIViewController(_ uiViewController: HandInteractionARViewController1, context: UIViewControllerRepresentableContext<ARViewContainer8>) -> Int {
        let viewController = HandInteractionARViewController1()
        return viewController.score.self
    }
    func makeCoordinator8() -> ARViewContainer8.Coordinator8 {
        return Coordinator8()
    }
    
    class Coordinator8 {
        
    }
}








class HandInteractionARViewController1: UIViewController, ARSessionDelegate {
    
    private var arView:ARView!
    
    lazy var request:VNRequest = {
        var handPoseRequest = VNDetectHumanHandPoseRequest(completionHandler: handDetectionCompletionHandler)
        handPoseRequest.maximumHandCount = 20
        
        return handPoseRequest
    }()
    
    
    var viewWidth:Int = 0
    var viewHeight:Int = 0
    var box : ModelEntity!
//    var setScore: Optional<((Int) -> Void)> = nil
//    var getScore: Optional<(() -> Int)> = nil
    //     var score = 0
    var scores: [Int] = []
    var score : Int = 0
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView = ARView(frame: view.bounds)
        arView.session.delegate = self
        view.addSubview(arView)
        let config = ARWorldTrackingConfiguration()
        config.environmentTexturing = .automatic
        config.frameSemantics = [.personSegmentation]
        config.planeDetection = [.horizontal]
        arView.session.run(config, options: [])
        viewWidth = Int(arView.bounds.width)
        viewHeight = Int(arView.bounds.height)
        setupObject()
//        setScore = {
//            self.score = $0
//        }
//        getScore = {
//            self.score
//        }
       
    }
    
    
    
    // object
    private func setupObject(){
        let anchor = AnchorEntity(plane: .any)

      
            box = try! ModelEntity.loadModel(named: "07")
            box.generateCollisionShapes(recursive: false)

            anchor.addChild(box)
      
            arView.scene.addAnchor(anchor)
    }
    
    
    
    
    
    
    
    var recentIndexFingerPoint:CGPoint = .zero
    func handDetectionCompletionHandler(request: VNRequest?, error: Error?) {
      
       
        // Human Hand Observation
            guard let observation = request?.results?.first as? VNHumanHandPoseObservation else { return }
        guard let indexFingerTip = try? observation.recognizedPoints(.all)[.indexTip],
              indexFingerTip.confidence > 0.3 else {return}
        
        
        let normalizedIndexPoint = VNImagePointForNormalizedPoint(CGPoint(x: indexFingerTip.location.y, y: indexFingerTip.location.x), viewWidth,  viewHeight)
        // disapper after tab on it
      
            if let entity =
                arView.entity(at: normalizedIndexPoint) as? ModelEntity, entity == box{
               
                entity.anchor?.removeChild(entity)
           score+=100
                print(score)
            }
        recentIndexFingerPoint = normalizedIndexPoint
        
      
//      print(score)
 
    
    }
    
    
    
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        let pixelBuffer = frame.capturedImage
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let handler = VNImageRequestHandler(cvPixelBuffer:pixelBuffer, orientation: .up, options: [:])
            do {
                try handler.perform([(self?.request)!])

            } catch let error {
                print(error)
            }
        }
    }
}


