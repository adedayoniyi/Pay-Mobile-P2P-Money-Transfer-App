# Pay Mobile - P2P Money Transfer App

<img src="assets/images/pay_mobile_advert.png" alt="Pay Mobile" title="Pay Mobile">

# Features (Don't forget to give it a star 🌟)

## You can perform some actions with the <a href="https://github.com/adedayoniyi/Pay-Mobile-Web-Admin"> Pay Mobile Web Admin </a>

#### 1. Pin feature used for authorizing transactions and user login

<img src="assets/images/pin_feature_showcase.png" alt="In app image 1" title="In app image 1" width="260" height="563">

##### 2. Custom in-app notifications

<img src="assets/images/in_app_notification_image.png" alt="In app image 2" title="In app image 2" width="260" height="563">

##### 3. Push notifications for transfers

<img src="assets/images/push_notification_showcase.png" alt="In app image 3" title="In app image 3" width="260" height="563">

##### 4. In-app customer service support

<img src="assets/images/customer_support_showcase.png" alt="In app image 4" title="In app image 4" width="260" height="563">

##### 5. Success Dialogs

<img src="assets/images/success_dialogs_showcase.png" alt="In app image 5" title="In app image 5" width="260" height="563">

##### 6. Fully responsive(Tablet View)

<img src="assets/images/responsive_showcase.png" alt="In app image 6" title="In app image 6" height="563">

## New App Features 🌟

#### 1. Sign Up Verification

<img src="assets/images/signup_verification_showcase.png" alt="In app image 1" title="Sign Up Verification Image" width="260" height="563">

#### 2. Forgort Password

<img src="assets/images/forgort_password_showcase.png" alt="In app image 1" title="Forgort password Image" width="260" height="563">

### QUICK START ⚡

#### Visit:<a href="https://github.com/adedayoniyi/Pay-Mobile-Full-Stack"> Pay Mobile Full Stack </a> to access the full stack code of the software (i.e the Back End and the Web Admin Front End)

### Note: The server running this app has already been deployed to render.com, which means you can immediately clone this repo, run it and start using it (i.e The backend is already connected).

#### Since every username on the app is unique, transfers are performed with usernames. Just enter the `@username` of the user and you can easily transfer funds

<img src="assets/images/username_transfer_showcase.png" alt="Username Transfer Showcase" title="In app image 3" width="260" height="563">

#### After the username is found then transfers can be made

<img src="assets/images/username_search_success_showcase.png" alt="Username Transfer Showcase" title="Username Transfer Showcase" width="260" height="563">

#### Then tap the transaction to view its details

<img src="assets/images/transaction_details_showcase.png" alt="Username Transfer Showcase" title="Username Transfer Showcase" width="260" height="563">

#### After cloning don't forget to run:

```bash
flutter pub get
```

## Packages Used 📦

1. <a href="https://pub.dev/packages?q=provider">provider</a>
2. <a href="https://pub.dev/packages/shared_preferences">shared_preferences</a>
3. <a href="https://pub.dev/packages/http">http</a>
4. <a href="https://pub.dev/packages/intl">intl</a>
5. <a href="https://pub.dev/packages/internet_connection_checker">internet_connrction_checker</a>

6. <a href="https://pub.dev/packages/flutter_native_splash">flutter_native_splash</a>
7. <a href="https://pub.dev/packages/firebase_core">firebase_core</a>
8. <a href="https://pub.dev/packages/firebase_messaging">firebase_messaging</a>
9. <a href="https://pub.dev/packages/cloud_firestore">cloud_firestore</a>
10. <a href="https://pub.dev/packages/socket_io_client">socket_io_client</a>
11. <a href="https://pub.dev/packages/awesome_notifications">awesome_notifications</a>

#### Here are some test login details of verified users if you don't want to create an account

```json
{
"username":"lere",
"pin":"7171",
"password":"test123",
}
{
"username":"johndoe",
"pin":"7171",
"password":"test123",
}
{
"username":"alice",
"pin":"7070",
"password":"test123",
}
{
"username":"bob",
"pin":"7474",
"password":"test123",
}
```

### If you choose to run it on your own server, visit the Pay Mobile Server Repo

## This is the official Nodejs server code that this app is running on <a href="https://github.com/adedayoniyi/Pay-Mobile-Server">Pay Mobile Server</a>

## Important

### After you are done with configuring the server, dont forget to update the uri in the global_constants.dart file

1. Locate lib\core\utils\global_constants.dart and edit line 6 using the server URL you generated or created. Changes will apply globally. Check Below:

```dart
6. const String uri = "https://transfer-dayo-niyi.onrender.com";
```

To

```dart
6. const String uri = "Your server URL";
```

## That's All 🎉🎉🎉

## Contributing

Pull requests are welcome. If you encounter any problem with the app or server, you can open an issue.

##### If you liked this project, don't forget to leave a star 🌟.

##### Note: As of now, no tests are available

## License

This project is licensed under the MIT License - see the <a href="https://github.com/adedayoniyi/Pay-Mobile-P2P-Money-Transfer-App/blob/main/LICENSE.md">LICENSE</a> file for details.
