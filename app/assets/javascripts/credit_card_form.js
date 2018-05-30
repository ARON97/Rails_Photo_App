$(document).ready(function() {

	// Data type for the methods that will be declared
	var show_error, stripeResponseHandler, submitHandler;

	
	// Upon the submission of the form it intercepts the default event, which is the
	// form submission to hit the create action in the registration controller
	submitHandler = function (event) {
		var $form = $(event.target);
		$form.find("input[type=submit]").prop("disabled", true);

		// if Stripe was initialized correctly this will create a token using the credit card info
		if (Stripe) {
			Stripe.card.createToken($form, stripeResponseHandler);
		} else {
			show_error("Failed to load credit card processing functionality. Please reload this page in your browser.")
		}
		return false;
	};
	// call the submit handler anytime a form with a class cc_form(in new.html.erb) is handled
	$(".cc_form").on('submit', submitHandler);

	// Handle what happens when we receive the response from stripe
	// That involves removing the credit card fields from the form before the submission
	stripeResponseHandler = function (status, response) {
		var token, $form;

		$form = $('.cc_form');

		if (response.error) {
			console.log(response.error.message);
			show_error(response.error.message);
			$form.find("input[type=submit]").prop("disabled", false);
		} else {
			token = response.id;
			$form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));
			$("[data-stripe=number]").remove();
			$("[data-stripe=cvv]").remove();
			$("[data-stripe=exp-year]").remove();
			$("[data-stripe=exp-month]").remove();
			$("[data-stripe=label]").remove();
			$form.get(0).submit();
		}

		return false;
	};
	// when stripe returns errors
	show_error = function (message) {
		if ($("#flash-messages").size() < 1) {
			$('div.container.main div:first').prepend("<div id='flash-messages'></div>");
		}
		$("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert"></a><div id="flash_alert">' + message + '</div></div>');
		$('.alert').delay(5000).fadeout(3000);
		return false;
	};
});