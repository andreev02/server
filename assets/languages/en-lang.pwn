#define LANG_ACCOUNT_IS_NOT_REGISTERED                      "Account is not registered!"

#define LANG_AUTORIZATION_HEADER                            "Account autorization"
#define LANG_AUTORIZATION_BODY                              "Enter your account password:"
#define LANG_AUTORIZATION_BODY_INCORRECTPASSWORD(%0)        Concat(Concat("Incorrect password! Attemps left: ", IntToStr(%0)), "\n\nEnter your account password:")
#define LANG_AUTORIZATION_FAILED                            "Sorry, attemps to enter a password are out of stock."

#define LANG_EXIT                                           "Exit"
#define LANG_ENTER                                          "Enter"

#define LANG_DATABASE_ERROR(%0)                             Concat("Database error #", IntToStr(%0))