import Foundation

public protocol EventUpdater: AnyObject {

    var timer: DispatchSourceTimer? { get set }

    var deadline: DispatchTime? { get set }
    var timeInterval: TimeInterval { get set }

    func eventHandler()

    func startUpdating()
    func stopUpdating()

}

extension EventUpdater {

    func startUpdating() {

        let queue = DispatchQueue(label: "com.beaxhem.timer.\(String(describing: self))", attributes: .concurrent)
        timer = DispatchSource.makeTimerSource(queue: queue)

        timer?.setEventHandler { [weak self] in
            self?.eventHandler()
        }

        timer?.schedule(deadline: deadline ?? .now(), repeating: timeInterval)

        timer?.resume()
    }

    func stopUpdating() {
        timer = nil
    }
}

