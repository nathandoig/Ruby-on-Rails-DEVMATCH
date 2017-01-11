/* global $, Stripe */
//Document ready.
$(document).on('turbolinks:load', function(){
  var  theForm = $('#premium_form');
  var submitBtn = $('#form-submit-btn');
  
  //Set Stripe public key.
  Stripe.setPublishableKey( $ ('meta[name="stripe-key"]').attr('content') );
  //When user clicks form submit btn, prevent default submission behaviour.
  submitBtn.click(function(event){
   event.preventDefault(); 
   
    //Collect the credit card fields.
    var ccNum = $('#cardNumber').val(),
        cvvNum = $('#card_code').val(),
        expMonth = $('#card_month').val(),
        expYear = $('#card_year').val();
        
    //Send the card info to Stripe.
    Stripe.createToken({
      number: ccNum,
      cvv: cvvNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler);
  });
  
  
  //Stripe will return credit card token.
  //Inject card token as hidden field into form.
  //Submit form to our Rails app.
});
