module ActiveAdmin
  module ControllerExt
    extend ActiveSupport::Concern
    included do
      def user_for_paper_trail
        admin_user_signed_in? ? 'Admin:'<<current_admin_user.email : 'Public user'  # or whatever
      end
    end
  end
end
