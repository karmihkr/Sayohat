# Sayohat | Share ride between cities app

Sayohat is a mobile application developed to help users find and publish their rides to save money per trip... blablabla

## Features

- **Find ride:** Users can find ride to share it with someone.
- **Post ride:** Users can post their ride to share it with someone.
- **Some else features:** Will be soon

## Usage

### Find ride

1. Add "from" city
2. Add "to" city
3. Add number of passenger that will ride with you
4. Click on button to find a ride
5. You will see a list of available rides for your preferences 

### Post ride

1. Add "from" city
2. Add "to" city
3. Add number of passenger that you can take with you
4. Add your car plate
5. Click on button to post a ride
6. Your ride will be published and can be seen by another users
7. ...

## Frontend Code Structure

- **lib/screens/registration-screens/registration_screen.dart:** Screen to enter the user's phone number.
- **lib/screens/registration-screens/confirm_phone_number_screen.dart:** Screen to confirm entered phone number.
- **lib/screens/registration-screens/verification_screen.dart:** Screen to enter a code.
- **lib/screens/tab-main-screen/welcome_screen.dart:** Screen that contains bottom navigation bar.
- **lib/screens/tab-main-screen/find_ride_screen.dart:** Screen to enter information about a ride to find.
- **lib/screens/tab-main-screen/add_ride_screen.dart:** Screen to enter information about a ride to post.
- **lib/screens/tab-main-screen/list_ride_screen.dart:** Screen to view history about user's rides.
- **lib/screens/tab-main-screen/profile_screen.dart:** Screen to view user's profile.
- **lib/theme/app_colors.dart:** Colors that are used in application.
- **lib/widgets/app_logo.dart:** Widget that show app logo.
- **lib/widgets/app_name.dart:** Widget that show app name.

## Project Setup (Development)

1. [Install Flutter](https://docs.flutter.dev/get-started/install?_gl=1*jjmxmh*_ga*MTYwNjk4MTAxNi4xNzQ5MTM4NTk3*_ga_04YGWK0175*czE3NDk4MDA0NTYkbzYkZzEkdDE3NDk4MDA0ODEkajM1JGwwJGgw) for your development platform
2. Run `flutter doctor` in your terminal until requirements are satisfied
3. Clone the repository
4. Configure virtual python environment in `/backend` folder and install `requirements.txt`
5. Start api server from `/backend` with the command `fastapi dev(or run) api/application.py`
6. Execute `flutter --no-color pub get` from the `/frontend` directory
7. Run **/lib/main.dart** to start the application
