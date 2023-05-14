# money_transfer_app_server
## This is the official Nodejs server code for the <a href="https://github.com/adedayoniyi/Pay-Mobile-P2P-Money-Transfer-App">Pay Mobile P2P Money Transfer App</a>
### You have to create a ```.env``` for the required environment variables as the one here has been removed
#### After cloning just run this and you server will be live:
```bash
npm run dev
```
#### These are the API endpoints
1. Methods: ```POST``` ```/api/createUser``` This is for user sign up<br/>
```json
{
"fullname":"full name here",
"username":"username here",
"email":"email here",
"password":"password here",
}
```
<br/> 2. Methods: ```POST``` ```/api/login``` THis is for user login where a token is generated<br/>
```json
{
"username":"username here",
"password":"password here",
}
```
<br/> 3. Methods: ```GET``` ```/api/getUsername/:username```This is for checking for existing username during sign up<br/> <br/>
<br/> 4. Methods: ```GET``` ```/api/getUsernameFortransfer/:username``` This is for checking for an existing username during transfers. Usernames are needed for transfers<br/><br/>
<br/> 5. Methods: ```POST``` ```/api/createLoginPin/:username``` This is used for creating a pin for transactions and login. Confirm pin is done in the front-end<br/>
```json
{
"pin":"pin here",
}
```
<br/> 6. Methods: ```POST``` ```/api/loginUsingPin/:username``` This is used for loging into the app using a 4 digit pin<br/>
```json
{
"pin":"pin here",
}
```
<br/> 7. Methods: ```POST``` ```/api/changePin/:username``` This is used for changing an existing pin<br/>
```json
{
"oldPin":"old pin here",
"newPin":"new pin here",
}
```
<br/> 8. Methods: ```GET``` ```/api/balance/:username``` This is used for getting the balance of a user<br/><br/>
<br/> 9. Methods: ```POST``` ```/api/transactions/transfer``` This is used for wallet balance transfers<br/><br/>
<br/> 10. Methods: ```GET``` ```/api/getTransactions/:username"``` This is used for getting all the transactions a user has made<br/><br/>
<br/> 11. Methods: ```POST``` ```/api/fundWallet/:username``` This is used for wallet funding<br/> 
```json
{
"amount":"pin here",
}
```

