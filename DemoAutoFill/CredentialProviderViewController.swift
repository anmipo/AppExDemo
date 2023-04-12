import AuthenticationServices
import IntuneMAMSwift

class CredentialProviderViewController: ASCredentialProviderViewController {
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshStatus()
    }
    
    private func refreshStatus() {
        let enrolledUser = IntuneMAMEnrollmentManager.instance().enrolledAccount()
        statusLabel.text = "Enrolled user: \(enrolledUser ?? "nil")"
        logTextView.text = IntuneMAMDiagnosticConsole.getDiagnosticInformation()?.debugDescription
    }
    
    @IBAction func didPressShowDiagnostics(_ sender: Any) {
        IntuneMAMDiagnosticConsole.display()
        //FIXME: In an extension, the diagnostic console does not show up.
        //So we use the `logTextView` instead.
    }
}

extension CredentialProviderViewController {
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
    }

    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }

    @IBAction func passwordSelected(_ sender: AnyObject?) {
        let passwordCredential = ASPasswordCredential(user: "j_appleseed", password: "apple1234")
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
}
