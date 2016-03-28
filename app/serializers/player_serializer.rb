class PlayerSerializer < ActiveModel::Serializer
  include Policable

  attributes :id, :name, :editable, :deleteable, :createable
end
