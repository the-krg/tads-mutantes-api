class Mutant < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :powers
  has_one_attached :photo
  validate :check_existence, on: :create

  def check_existence
    if Mutant.find_by(name: name).present?
      errors.add(:name, 'already exists')
    end
  end
end
