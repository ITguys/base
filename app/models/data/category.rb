class Data::Category < ActiveRecord::Base

  belongs_to :editor, class_name: User, foreign_key: :editor_id
  belongs_to :creator, class_name: User, foreign_key: :creator_id

  validates :name, :creator_id, presence: true

  scope :active, -> {where active: true}

end
