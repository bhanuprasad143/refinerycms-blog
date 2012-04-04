module Refinery
  module Blog
    module ControllerHelper

      protected

        def find_blog_post
          unless (@post = Refinery::Blog::Post.by_site(current_site).find(params[:id])).try(:live?)
            if refinery_user? and current_user.authorized_plugins.include?("refinerycms_blog") && @post
              @post #= Refinery::Blog::Post.find(params[:id])
            else
              error_404
            end
          end
        end

        def find_all_blog_posts
          @posts = Refinery::Blog::Post.live.by_site(current_site).includes(:comments, :categories).page(params[:page])
        end

        def find_tags
          @tags = current_site.refinery_blog_posts.tag_counts_on(:tags)
        end
        def find_all_blog_categories
          @categories = current_site.refinery_blog_categories
        end
    end
  end
end

