class ValidationMixin {
  String validateEmail(String value) {
    //return null if valid otherwise returns a string with error message
    /*
          The validator function right here is what is actually responsible for looking out the value that has
          been entered into the text form fields and saying whether or not it is valid.
           */
    if(!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String validatePassword(String value) {
      if(value.length < 6) {
        return 'Password must be atleast 6 characters';
      }
      return null;
  }
}