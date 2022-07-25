//
//  ContentView.swift
//  Artificx
//
//  Created by Tianyi Gu on 7/22/22.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import UIKit



struct ARMenu : View {
    @Binding var tabSelection : Int
    var body: some View {
        displayARView()
        
    }
}

struct NewARMenu : View {
    var body: some View {
        displayARView()
    }
}
struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: Model?

    func makeUIView(context: Context) -> ARView {

        let arView = CustomARView(frame: .zero)
//        arView.enableObjectRemoval()

        return arView

    }

    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = self.modelConfirmedForPlacement {

            if let modelEntity = model.modelEntity {
                print("DEBUG: adding model to scene- \(model.modelName)")
//              THIS LINE ONLY WORKS ON AN ACTUAL PHONE, DOESNT FUNCTION ON SIMULATIONS
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))

                uiView.scene.addAnchor(anchorEntity)
            } else {
                print("DEBUG: unable to load modelEntity for \(model.modelName)")
            }

            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
    }

}

class CustomARView: ARView {
    let focusSquare = FESquare()

    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)

        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true)

        self.setupARView()
    }

    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupARView()
    {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        //Check if device supports LiDAR
        if #available(iOS 13.4, *) {
            if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
                config.sceneReconstruction = .mesh
            }
        } else {
            // Fallback on earlier versions
        }

        self.session.run(config)
    }
}
//From maxxfrazer's github library FocusEntity
extension CustomARView: FEDelegate {
    func toTrackingState() {
        print("tracking")
    }

    func toInitializingState() {
        print("initializing")
    }
}

struct displayARView: View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?


    private var models: [Model] = {
        //Dynamically get our model filenames
        let filemanager = FileManager.default

        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }

        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)

            availableModels.append(model)
        }
        return availableModels
    }()

    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement)

            if self.isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$modelConfirmedForPlacement)
            } else {
                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: $selectedModel, models: self.models)
            }

        }
    }
}
//
//extension ARView {
//    func enableObjectRemoval() {
//        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(recognizer:)))
//        self.addGestureRecognizer(longPressGestureRecognizer)
//    }
//
//    @objc func handleLongPress(recognizer: UILongPressGestureRecognizer) {
//        let location = recognizer.location(in: self)
//
//        if let entity = self.entity(at: location) {
//            if let anchorEntity = entity.anchor {
//                anchorEntity.removeFromParent()
//                print("DEBUG: Removing anchors")
//            }
//        }
//    }
//}

struct ModelPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?

    var models: [Model]

    var body: some View {
        VStack {
//            Button(action: {
//                print("DEBUG: Resetting Environment")
//
//            }) {
//                Text("Reset!")
//                    .frame(width: 100, height: 60)
//                    .font(.title)
//                    .background(Color.white.opacity(0.75))
//                    .cornerRadius(20)
//                    .padding(20)
//            }
//            NavigationLink(destination: NewARMenu(), label: {
//                Text("Reset Environment!")
//                    .bold()
//                    .frame(width: 280, height: 50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            })
//            Spacer()
        }
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name: \(self.models[index].modelName)")

                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    }) {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }.buttonStyle(PlainButtonStyle())

                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

struct PlacementButtonsView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?

    var body: some View {
        HStack {
            //Cancel Button
            Button(action: {
                print("DEBUG: Model placement canceled.")
                self.resetPlacementParameters()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }

            //Confirm Button
            Button(action: {
                print("DEBUG: Model placement confirmed.")
                self.modelConfirmedForPlacement = self.selectedModel
                self.resetPlacementParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    func resetPlacementParameters() {
        self.isPlacementEnabled = false
        self.selectedModel = nil
    }
}


//#if DEBUG
//struct ContentView_Previews : PreviewProvider {
//    static var previews: some View {
//        ARMenu(tabSelection: $selected)
//    }
//}
//#endif
