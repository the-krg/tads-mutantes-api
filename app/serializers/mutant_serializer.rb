class MutantSerializer < ActiveModel::Serializer
  attributes :id, :name, :photo

  def photo 
    object.photo.service_url if object.photo.respond_to? 'service_url'
  end

  has_many :powers, only: :name
end
