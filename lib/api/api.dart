Map<String, String> customHeader() => {
      'content-type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };

const timeLimit = Duration(seconds: 30);
const vibrationDuration = 1000;
const noConnection = 'No Internet Connection';
const timeoutMessage =
    'Looks like the server is taking too long to respond, You can still try again later.';
const unableToProcess =
    "We are unable to process this request at the moment, kindly check your network connection and try again.";
const somethingWentWrong = 'Something went wrong, Please try again.';
const unknownError = 'Unknown Error';
const resetPasswordMessage = "we've sent a password reset link to your email.";
const serverIsUnavailable =
    'Server is temporarily unavailable. Please try again later.';
