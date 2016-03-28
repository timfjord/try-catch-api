require 'rails_helper'

RSpec.describe PlayerSerializer, type: :serializer do
  let(:object) { create :player }

  it_behaves_like 'serializer with policy'
end
