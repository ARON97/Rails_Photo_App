class Payment < ApplicationRecord

	# We are not going to store the credit information into our database
	# But the payment model would need to work with the attributes from the credit card info
	# inorder for the JavaScript to send the information to stripe and then get rid off it
	attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
	# Associations
	belongs_to :user

	# When the user is busy selecting the month when they enter in their credit card info
	def self.month_options
		# displaying the form
		Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i + 1]}
	end

	# Year options
	def self.year_options
		# shows the year 2018-2028 which is 10 years
		(Date.today.year..(Date.today.year+10)).to_a
	end

	# Process payment method that we will use while creating the registration
	def process_payment
		# Creating customer
		customer = Stripe::Customer.create email: email, card: token

		Stripe::Charge.create customer: customer.id,
							  amount: 1000,
							  description: 'Premium',
							  currency: 'usd'
		# amount is $10 here = 10c * 1000
	end
end
