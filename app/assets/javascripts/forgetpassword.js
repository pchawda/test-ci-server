(function($,W,D)
{
  var JQUERY4U = {};

  JQUERY4U.UTIL =
  {
    setupFormValidation: function()
    {
      $("#password-form").validate({
        rules: {
          'user[email]': {
            required: true,
            email: true
          }
        },    
        messages: {
          'user[email]': "Please enter a valid email address",
        },
        submitHandler: function(form) {
          form.submit();
        }
      });
    }
  }
  $(D).ready(function($) {
    JQUERY4U.UTIL.setupFormValidation();
  });

})(jQuery, window, document);