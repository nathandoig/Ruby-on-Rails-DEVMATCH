class Contact < ActiveRecord::Base
    # Contact form field validations
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end