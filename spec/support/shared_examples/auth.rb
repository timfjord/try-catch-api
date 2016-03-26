shared_examples 'protected action' do
  it 'should require authentication' do
    action

    expect(response.status).to eql 401
  end
end
