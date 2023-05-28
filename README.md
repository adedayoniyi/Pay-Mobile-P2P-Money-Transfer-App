# Pay Mobile- P2P Money Transfer App

<img src="/assets/images/Pay Mobile advert.png" alt="Pay Mobile" title="Pay Mobile">

# Features

#### 1. Pin feature used for authorizing transactions and user login

<p float="left"> <img src="/assets/images/confirm_pin_showcase.png" alt="In app image 1" title="In app image 1" width="260" height="563">  <img src="/assets/images/transfer_notification_image.png" alt="In app image 2" title="In app image 2" width="260" height="563"> </p>

##### 2. Custom in-app notifications

<img src="/assets/images/transfer_notification_image.png" alt="In app image 2" title="In app image 2" width="260" height="563">

##### 3. Error messages included

<img src="/assets/images/error_message_showcase.png" alt="In app image 3" title="In app image 3" width="260" height="563">

### Note: The server running this app has already been deployed to render.com, which means you can immediately clone this repo, run it and start using it (i.e The backend is already connected). Since every username on the app is unique, transfers are performed with usernames. Just enter the ```@username``` of the user and you can easily transfer funds

#### After cloning don't forget to run:

```bash
flutter pub get
```
#### Packages Used
1. <a href="https://pub.dev/packages?q=provider">provider</a>
2. <a href="https://pub.dev/packages/shared_preferences">shared_preferences</a>
3. <a href="https://pub.dev/packages/http">http</a>
4. <a href="https://pub.dev/packages/intl">intl</a>
5. <a href="https://pub.dev/packages/internet_connection_checker">internet_connrction_checker</a>
6. <a href="https://pub.dev/packages/flutter_native_splash">flutter_native_splash</a>

#### Here are some test login details if you don't want to create an account

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

### But if you choose to run it on your own server, or local environment follow these steps below.

### These are the instructions to successfully run this app on a local environment or your personal server

#### Note Also: It's assumed that you already have a basic knowledge of the Flutter Framework

### The server code is located in /money_transfer_server

## Instructions

1. Locate lib/constants/global_constants.dart and edit line 6 using an ip address that the mobile device is connected to and the port of the server. To get your ip(while connected to the internet, open your terminal and type "ipconflg/all" and locate your ipv4 address). Please note that this changes regularly, so it has to be updated if it changes. If you later decide to deploy the server, don't forget to update the "uri".

```dart
6. const String uri = "https://transfer-dayo-niyi.onrender.com";
```

e.g

```dart
6. const String uri = "192.168.0.1:4000";
```

2. Locate /money_transfer_server/.env and edit line 1 with your mongodb url.

```
1. DATABASE_URL =Enter your mongodb database url here
```

## That's All

Now open your terminal and go to the directory of the money_transfer_server and run:

```bash
npm install
```

Then run,

```bash
npm run dev
```

#### After that's done, build your flutter app

## Contributing

Pull requests are welcome. If you encounter any problem with the app or server, you can open an issue.

## Upcoming Features

1. App Notifications
2. Admin Pannel with different levels of priviledges
3. Transaction details screen
4. Download montly statements
5. Email verification and many more

##### If yo liked this project, don't forget to leave a star.

##### Note: As of now, no tests are available

##### Tutorials on how to build a quality software like this will be out soon
## License
This project is licensed under the MIT License - see the <a href="https://github.com/adedayoniyi/Pay-Mobile-P2P-Money-Transfer-App/blob/main/LICENSE.md">LICENSE</a> file for details.
