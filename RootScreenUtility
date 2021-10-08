
//MARK:- AppDelegate 

var window: UIWindow?
    
   static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
   }

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        RootScreenUtility.setRootScreen(window: window)
        
        //Display splash screen based on your requirement.
        Thread.sleep(forTimeInterval: 3)
        return true
    }

//----------------------------------------------------

//MARK:- SceneDelegate 

 func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        RootScreenUtility.setRootScreen(window: window)
    }

//------------- Set root screen from anyclass\

RootScreenUtility.setRootScreen(window: RootScreenUtility.window(for: self.view))

//--------------------------------------
// MARK: - Root Screen Utility class 
class RootScreenUtility {
    
    class func window(for view: UIView) -> UIWindow? {
        if #available(iOS 13, *) {
            return (view.window?.windowScene?.delegate as! SceneDelegate).window
        }
        else {
            return (UIApplication.shared.delegate as! AppDelegate).window
        }
    }
    
    class func setRootScreen(window: UIWindow?) {
        
        let isUserLogin = UserDefaultManager.sharedManager.getBoolValue(key: Constants.UserDefaultsKeys.isUserLogIn)
   
        
        if isUserLogin{
            let dashboard = UIStoryboard(name: Constants.Storyboard.dashboard.rawValue, bundle: nil).instantiateInitialViewController()
            window?.rootViewController = dashboard!
            window?.makeKeyAndVisible()
        }else{
            let storyboard = UIStoryboard(name: Constants.Storyboard.main.rawValue, bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: LandingViewController.identifier())
            let navigation = UINavigationController(rootViewController: loginViewController)
            navigation.navigationBar.isHidden = true
            window?.rootViewController = navigation
        }
    }
}
