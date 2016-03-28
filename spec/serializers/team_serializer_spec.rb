require 'rails_helper'

RSpec.describe TeamSerializer, type: :serializer do
  let(:object) { create :team }

  it_behaves_like 'serializer with policy'
end
