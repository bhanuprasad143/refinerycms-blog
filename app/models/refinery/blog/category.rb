module Refinery
  module Blog
    class Category < ActiveRecord::Base
      extend FriendlyId
      include ::BelongsToSite

      friendly_id :title, :use => [:slugged]

      attr_accessible :title

      has_many :categorizations, :dependent => :destroy, :foreign_key => :blog_category_id
      has_many :posts, :through => :categorizations, :source => :blog_post

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true
      validates_uniqueness_of :title, :scope => [:site_id]

      def post_count
        posts.select(&:live?).count
      end

      # how many items to show per page
      self.per_page = Refinery::Blog.posts_per_page

    end
  end
end

