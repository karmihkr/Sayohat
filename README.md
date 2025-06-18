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

# Log in and Sign up screens

- **welcome_screen.dart:** Screen to choose method "Log in" or "Sign up".

- **phone_number_screen.dart:** Screen to enter the user's phone number (Sign up process).
- **confirm_phone_number_screen.dart:** Screen to confirm entered phone number (Sign up process).
- **sms_code_screen.dart:** Screen to enter a code from sms (Sign up process).
- **name_surname_screen.dart** Screen to enter user's name and surname (Sign up process).
- **date_of_birth_screen.dart** Screen to enter user's date of birth (Sign up process).
- **password_screen.dart** Screen to enter and confirm user's password (Sign up process).
- **phone_passwords_screen.dart** Screen to enter user's phone and password (Log in process).

# Main functionality screens

- **main_hub_screen.dart** Screen that contains bottom navigation bar.

- **find_ride_screen.dart** Screen to enter information about a ride to search.
- **list_search_screen.dart** Screen that contains result list of search.
- **ride_details_screen.dart** Screen that contains full information about a ride.
- **find_data.dart** File that contains infromation entered by user.

- **add_ride_screen.dart** Screen to enter information about a ride to post.
- **your_ride_data.dart** File that contains information about all user's rides.

- **list_your_ride_screen.dart** Screen that contains all user's rides.
- **your_ride_details_screen.dart** Screen that contains details about a user's ride.

- **profile_screen.dart** Screen that contains user's profile.

- **test_data_search_screen.dart** File that contains test data for searching.

- **app_colors.dart** File that contains main colors for application.

- **app_logo.dart** File that contains app logo widget.
- **app_name.dart** File that contains app nane widget.

- **user_data.dart** File that contains user's general information.
- **main.dart** Main file of the frontend part.

## Project Setup (Development)

1. [Install Flutter](https://docs.flutter.dev/get-started/install?_gl=1*jjmxmh*_ga*MTYwNjk4MTAxNi4xNzQ5MTM4NTk3*_ga_04YGWK0175*czE3NDk4MDA0NTYkbzYkZzEkdDE3NDk4MDA0ODEkajM1JGwwJGgw) for your development platform
2. Run `flutter doctor` in your terminal until requirements are satisfied
3. Clone the repository
4. Configure virtual python environment in `/backend` folder and install `requirements.txt`
5. Start api server from `/backend` with the command `fastapi dev(or run) api/application.py`
6. Execute `flutter --no-color pub get` from the `/frontend` directory
7. Run **/lib/main.dart** to start the application
