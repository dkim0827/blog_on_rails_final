class Post < ApplicationRecord
    belongs_to :user
    has_many(:comments, dependent: :destroy)

    validates :title, presence: true
    validates :body, presence: true
    validates :view_count, numericality: {greater_than_or_equal_to: 0}
    
    before_validation :capitalize_title 
    before_validation :default_view_count

    private
    def capitalize_title
        self.title.capitalize!
    end

    def default_view_count
        self.view_count ||= 0
      end
end
