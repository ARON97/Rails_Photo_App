Rails.configuration.stripe = {
	:publishable_key => 'pk_test_42VKcbHi2aVqNjr6dbN9n01A',
	:secret_key => 'sk_test_xIgKEnsunaF1ZzPIQv4XO1v8'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]