//
//  Spinner.swift
//  SearchAPI_Toy
//
//  Created by KyungHeon Lee on 2023/06/19.
//

import SwiftUI

// 색상 커스텀
enum ColorManager {
    case anotherBlue
    case anotherYellow
    
    var color: Color {
        switch self {
        case .anotherBlue:
            return Color("anotherBlue")
        case .anotherYellow:
            return Color("anotherYellow")

        }
    }
}

// MARK: - Spinner
// 소스원본: https://github.com/KeatoonMask/SwiftUI-Animation/tree/master
struct Spinner: View {

    let rotationTime: Double = 0.3
    let animationTime: Double = 0.5 // Sum of all animation times
    let fullRotation: Angle = .degrees(360)
    static let initialDegree: Angle = .degrees(270)

    @State var spinnerStart: CGFloat = 0.0
    @State var spinnerEndS1: CGFloat = 0.55
    @State var spinnerEndS2S3: CGFloat = 0.75

    @State var rotationDegreeS1 = initialDegree
    @State var rotationDegreeS2 = initialDegree
    @State var rotationDegreeS3 = initialDegree

    var body: some View {
        ZStack {
            // S3
            SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS3, color: ColorManager.anotherYellow.color)

            // S2
            SpinnerCircle(start: spinnerStart, end: spinnerEndS2S3, rotation: rotationDegreeS2, color:
                    .green)

            // S1
            SpinnerCircle(start: spinnerStart, end: spinnerEndS1, rotation: rotationDegreeS1, color: ColorManager.anotherBlue.color)
        }
        .frame(width: 150, height: 150)
        .onAppear() {
            self.animateSpinner()
            Timer.scheduledTimer(withTimeInterval: animationTime, repeats: true) { (mainTimer) in
                self.animateSpinner()
            }
        }
    }

    // MARK: Animation methods
    func animateSpinner(with duration: Double, completion: @escaping (() -> Void)) {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            withAnimation(Animation.easeInOut(duration: self.rotationTime)) {
                completion()
            }
        }
    }

    func animateSpinner() {
        animateSpinner(with: rotationTime) { self.spinnerEndS1 = 1.0 }

        animateSpinner(with: (rotationTime * 2) - 0.025) {
            self.rotationDegreeS1 += fullRotation
            self.spinnerEndS2S3 = 0.8
        }

        animateSpinner(with: (rotationTime * 2)) {
            self.spinnerEndS1 = 0.03
            self.spinnerEndS2S3 = 0.03
        }

        animateSpinner(with: (rotationTime * 2) + 0.0525) { self.rotationDegreeS2 += fullRotation }

        animateSpinner(with: (rotationTime * 2) + 0.225) { self.rotationDegreeS3 += fullRotation }
    }
}

// MARK: SpinnerCircle
struct SpinnerCircle: View {
    var start: CGFloat
    var end: CGFloat
    var rotation: Angle
    var color: Color

    var body: some View {
        Circle()
            .trim(from: start, to: end)
            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .fill(color)
            .rotationEffect(rotation)
    }
}


