require 'active_support/concern'

module OAuth2Filter
  extend ActiveSupport::Concern

  module ClassMethods
    def authenticate_with_oauth_and_devise(options = {})
      around_filter OAuthAroundFilter.new(options.delete(:scope)), options
    end

    class OAuthAroundFilter
      def initialize(scope = nil)
        @scope = scope
      end

      def filter(controller, &block)
        wrapped_proc = Proc.new do
          controller.request.env['warden'].authenticate!(:scope => :user)
          block.call
        end

        controller.request.env['oauth2'].authenticate_request! :scope => @scope, &wrapped_proc
      end
    end
  end
end