# Pay Mobile- P2P Money Transfer App
<img src="/assets/images/Pay Mobile advert.png" alt="Employee data" title="Employee Data title">

### Note: The server running this app has already been deployed to render.com, which means you can immediately clone this repo, run it and start using it (i.e The backend is already connected). But if you choose to run it on your own server, or local environment follow these steps below.

### These are the instructions to successfully run this app
#### Note Also: It's assumed that you already have a basic knowledge of the Flutter Framework

### The server code is located in /money_transfer_server

## Instructions
1. Locate lib/constants/global_constants.dart and edit line 6 using an ip address that the mobile device is connected to and the port of the server. To get your ip(while connected to the internet, open your terminal and type "ipconflg/all" and locate your ipv4 address). Please note that this changes regularly, so it has to be updated if it changes. If you later decide to deploy the server, don't forget to update the "uri".
```dart
6. const String uri = "https://transfer-dayo-niyi.onrender.com";
````
e.g
```dart
6. const String uri = "192.168.0.1:4000";
````


2. Locate /money_transfer_server/.env and edit line 1 with your mongodb url.
```
1. DATABASE_URL =Enter your mongodb database url here 
````

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

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

##### Note: As of now, no tests are available

