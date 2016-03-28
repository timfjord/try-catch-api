class TeamSerializer < ActiveModel::Serializer
  include Policable

  attributes :id, :name, :editable, :deleteable, :createable
end
