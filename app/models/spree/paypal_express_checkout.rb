module Spree
	class PaypalExpressCheckout < ActiveRecord::Base
		
		def actions
      %w{capture void credit}
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      payment.pending? || payment.checkout?
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      !payment.failed? && !payment.void?
    end

    # Indicates whether its possible to credit the payment.  Note that most gateways require that the
    # payment be settled first which generally happens within 12-24 hours of the transaction.
    def can_credit?(payment)
      payment.completed? && payment.credit_allowed > 0
    end
  end
end