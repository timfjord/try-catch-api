shared_examples 'action that requires authentification' do
  it 'should require authentication' do
    action

    expect(response.status).to eql 401
  end
end

shared_examples 'action that requires authorization for' do |role|
  it 'should require authentication' do
    sign_in create(role)
    action

    expect(response.status).to eql 401
  end
end
