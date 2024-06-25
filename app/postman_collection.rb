{{jwt}}/users/
for sign_up users

{
    "user": {
        "email": "akshay5@abc.com",
        "password": "Akshay@420",
        "password_confirmation": "Akshay@420"

    }
}



for sign_in
    {{jwt}}/users/sign_in

    {
    "user": {
        "email": "akshay5@abc.com",
        "password": "Akshay@420"
    }
}

for other collections

    token in authorization as bearer token
    