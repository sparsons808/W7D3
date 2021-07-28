class Goal < ApplicationRecord
  belongs_to :user,
    foreign_key: :author_id,
    class_name: :User
end
