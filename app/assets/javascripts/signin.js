(function($,W,D)
{
  var JQUERY4U = {};

  JQUERY4U.UTIL =
  {
    setupFormValidation: function()
    {
        //form validation rules
      $("#session-form").validate({
        rules: {
          'user[email]': {
            required: true,
            email: true
          },
          'user[password]': {
            required: true,
            minlength: 8
          },
        },    
        messages: {
          'user[password]': {
            required: "Please provide a password",
            minlength: "Your password must be at least 8 characters long"
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