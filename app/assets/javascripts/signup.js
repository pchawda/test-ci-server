(function($,W,D)
{
  var JQUERY4U = {};

  JQUERY4U.UTIL =
  {
    setupFormValidation: function()
    {
        //form validation rules
      $("#register-form").validate({
        rules: {
          'user[first_name]': "required",
          'user[last_name]': "required",
          'user[email]': {
            required: true,
            email: true
          },
          'user[password]': {
            required: true,
            minlength: 8
          },
          'user[password_confirmation]': {
            required: true,
            minlength: 8,
            equalTo: '#user_password'
          },
        },    
        messages: {
          'user[first_name]': "Please enter your first name",
          'user[last_name]': "Please enter your last name",
          'user[password]': {
            required: "Please provide a password",
            minlength: "Your password must be at least 8 characters long"
          },
          'user[password_confirmation]': {
            required: "Please provide a password confirmation",
            minlength: "Your password confirmation must be at least 8 characters long",
            equalTo: 'password confirmation not match'
          },
          'user[email]': "Please enter a valid email address",
        },
        submitHandler: function(form) {
          form.submit();
        }
      });
    }
  }

  //when the dom has loaded setup form validation rules
  $(D).ready(function($) {
    JQUERY4U.UTIL.setupFormValidation();
  });

})(jQuery, window, document);