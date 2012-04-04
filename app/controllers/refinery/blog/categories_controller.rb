module Refinery
  module Blog
    class CategoriesController < BlogController

      def show
        @category = current_site.refinery_blog_categories.find(params[:id])
        @posts = @category.posts.live.includes(:comments, :categories).page(params[:page])
      end

    end
  end
end

