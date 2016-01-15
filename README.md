# radr://21404408

http://www.openradar.me/21404408

## Summary:
Background: Our app requires the user to log in every time they use it, and logs the user out when entering background or after a period of inactivity. When logging out, the application replaces the window's current rootViewController with a new instance of our login view controller. This is to ensure all views and view controllers used during the user’s session are removed.

If a view controller presentation is in progress when the window's -rootViewController is replaced, then the presented view controller, the presenting view controller, and their views are not deallocated.

## Steps to Reproduce:
1. Create an application with three view controllers, A, B, and C.
2. In application:didFinishLaunchingWithOptions:, create a window and set its root view controller to an instance of A.
3. Use -presentViewController:animated:completion: to present an instance of B from A.
4. Without dismissing B, set the window's root view controller to an instance of C.

### Expected Results:
View controllers A and B are deallocated.

### Actual Results:
View controllers A and B leak, together with their views.

### Version:
iOS 8.3 Simulator

## Notes:
In iOS 7.1, the view controllers A and B are deallocated as expected.

### Configuration:
iOS 8.3 Simulator