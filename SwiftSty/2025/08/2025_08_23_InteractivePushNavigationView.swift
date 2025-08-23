//
//  2025_08_23_InteractivePushNavigationView.swift
//  SwiftSty
//
//  Created by 김은찬 on 8/23/25.
//

import SwiftUI

// MARK: - 애니메이션
class InteractivePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        let screenWidth = containerView.frame.width
        
        toView.frame = containerView.frame.offsetBy(dx: screenWidth, dy: 0)
        containerView.addSubview(toView)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                fromView.frame = containerView.frame.offsetBy(dx: -screenWidth * 0.3, dy: 0)
                toView.frame = containerView.frame
            },
            completion: { finished in
                if transitionContext.transitionWasCancelled {
                    toView.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}

// MARK: - InteractivePushNavigationController
class InteractivePushNavigationController: UINavigationController {
    private var interactivePushGestureRecognizer: UIScreenEdgePanGestureRecognizer?
    private var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition?
    private var destinationViewController: UIViewController?
    private let pushAnimator = InteractivePushAnimator()
    private static let gestureVelocityThreshold: CGFloat = 500.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        interactivePopGestureRecognizer?.delegate = self
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func setupInteractivePush(to viewController: UIViewController) {
        destinationViewController = viewController
        delegate = self
        
        let gesture = UIScreenEdgePanGestureRecognizer(
            target: self,
            action: #selector(handleInteractivePushGesture(_:))
        )
        gesture.edges = .right
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        interactivePushGestureRecognizer = gesture
    }
    
    @objc private func handleInteractivePushGesture(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let view = self.view else { return }
        
        let progress = abs(-gestureRecognizer.translation(in: view).x / view.frame.width)
        
        switch gestureRecognizer.state {
        case .began:
            guard let destination = destinationViewController else { return }
            pushViewController(destination, animated: true)
            
        case .changed:
            percentDrivenInteractiveTransition?.update(progress)
            
        case .ended:
            let velocity = gestureRecognizer.velocity(in: view).x
            if velocity < 0.0 && (progress > 0.5 || velocity < -Self.gestureVelocityThreshold) {
                percentDrivenInteractiveTransition?.finish()
            } else {
                percentDrivenInteractiveTransition?.cancel()
            }
            
        default:
            percentDrivenInteractiveTransition?.cancel()
        }
    }
}

extension InteractivePushNavigationController: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return operation == .push ? pushAnimator : nil
    }
    
    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        if interactivePushGestureRecognizer?.state == .began {
            percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            percentDrivenInteractiveTransition?.completionCurve = .easeOut
            return percentDrivenInteractiveTransition
        }
        return nil
    }
}

extension InteractivePushNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === interactivePopGestureRecognizer {
            return viewControllers.count > 1
        }
        if gestureRecognizer === interactivePushGestureRecognizer {
            guard let destination = destinationViewController else { return false }
            return topViewController !== destination && !viewControllers.contains(destination)
        }
        return false
    }
}

// MARK: - SwiftUI 래퍼
struct InteractivePushNavigationControllerView<Content: View>: UIViewControllerRepresentable {
    let content: Content
    let destination: AnyView
    
    init<D: View>(content: Content, destination: D) {
        self.content = content
        self.destination = AnyView(destination)
    }
    
    func makeUIViewController(context: Context) -> InteractivePushNavigationController {
        let hostingController = UIHostingController(rootView: content)
        let navigationController = InteractivePushNavigationController(rootViewController: hostingController)
        let destinationController = UIHostingController(rootView: destination)
        navigationController.setupInteractivePush(to: destinationController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: InteractivePushNavigationController, context: Context) {}
}

// MARK: - SwiftUI Content
struct FirstView: View {
    var body: some View {
        ZStack {
            Color.blue.opacity(0.3)
            Text("First View")
                .font(.largeTitle)
        }
        .ignoresSafeArea()
    }
}

struct DestinationView: View {
    var body: some View {
        ZStack {
            Color.green.opacity(0.3)
            Text("Second View")
                .font(.largeTitle)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    InteractivePushNavigationControllerView(
        content: FirstView(),
        destination: DestinationView()
    )
}

