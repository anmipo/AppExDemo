import UIKit
import IntuneMAMSwift

class ViewController: UIViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var enrollButton: UIButton!
    private var latestErrorString: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshStatus()
    }
    
    private func refreshStatus() {
        var statusMessages = [String]()
        if let currentUser = IntuneMAMEnrollmentManager.instance().enrolledAccount() {
            statusMessages.append("Enrolled: \(currentUser)")
            enrollButton.isEnabled = false
        } else {
            statusMessages.append("No user enrolled.")
            enrollButton.isEnabled = true
        }
        
        if let latestErrorString = latestErrorString {
            statusMessages.append(latestErrorString)
        }
        statusLabel.text = statusMessages.joined(separator: "\n")
    }
}

// MARK: Actions
extension ViewController {
    @IBAction func didPressEnrollButton(_ sender: Any) {
        startEnrollment()
    }
    
    @IBAction func didPressDiagnostics(_ sender: Any) {
        IntuneMAMDiagnosticConsole.display()
    }
}

// MARK: - Enrollment

extension ViewController {
    private func startEnrollment() {
        let enrollmentManager = IntuneMAMEnrollmentManager.instance()
        enrollmentManager.delegate = self
        enrollmentManager.loginAndEnrollAccount(enrollmentManager.enrolledAccount())
    }
}

extension ViewController: IntuneMAMEnrollmentDelegate {
    func enrollmentRequest(with status: IntuneMAMEnrollmentStatus) {
        if status.didSucceed {
            latestErrorString = nil
        } else {
            latestErrorString = status.errorString
        }
        refreshStatus()
    }
}
