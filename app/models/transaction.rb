class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :holder, class_name: 'Account'
end
