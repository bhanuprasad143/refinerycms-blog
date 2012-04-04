module Refinery
  module Blog
    class BlogController < ::ApplicationController

      include ControllerHelper

      helper :'refinery/blog/posts'
      before_filter :find_page, :find_all_blog_categories

      protected

        def find_page
          @page = Refinery::Page.by_site(current_site).where(:link_url => "/blog").first
        end
    end
  end
end

