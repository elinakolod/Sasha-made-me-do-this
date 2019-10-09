module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authorize_access_request!

      def create
        endpoint operation: Comments::Operation::Create,
                 options: { current_user: current_user }
      end

      def destroy
        endpoint operation: Comments::Operation::Destroy,
                 options: { current_user: current_user }
      end
    end
  end
end