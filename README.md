## Initial setup

- Build and run the app
- Activate the AutoFill extension
  - Open device settings → Passwords → AutoFill Passwords
  - Enable "AutoFill Passwords"
  - Select "AppExDemo"
- In Intune Admin center, create an iOS app protection policy
  - Target to custom apps with bundle IDs `com.notcontoso.appexdemo` and `com.notcontoso.appexdemo.autofill`
  - Other policy values can remain by default

## Steps to reproduce

- Run the app, tap "Enroll", sign in to an Intune-licensed account
- After the sign-in and mandatory restart, the app shows the user's UPN — all good.
- Now, let's test the extension. Open Safari and navigate to any page with a sign in form (for example, https://github.com/login)
- Above the keyboard, the system will show a "Passwords" button. Tap it to open the AutoFill extension. (In simulator, you might need to press Cmd+K to show the software keyboard.) 
- Check the "Enrolled user" field (based on `IntuneMAMEnrollmentManager.instance().enrolledAccount()`)
  - Expected value: same UPN as in the app
  - Observed value: `nil`
- Tap the "Diagnostics" button in top-right corner. This calls `IntuneMAMDiagnosticConsole.display()`.
  - Expected behavior: Intune diagnostic console should appear on the screen.
  - Observed behavior: no new UI appears on the screen.
