require 'rails_helper'

RSpec.describe 'Teams', type: :request do
  describe 'listing' do
    it_behaves_like 'protected action' do
      let(:action) { get teams_path }
    end

    context 'signed in' do
      sign_in

      let!(:team1) { create :team }

      it 'should return all teams' do
        get teams_path

        expect(response).to be_success
        resp = parse_json response.body
        expect(resp['teams'].size).to eql 1
        expect(resp['teams'][0]['id']).to eql team1.id
        expect(resp['teams'][0]['name']).to eql team1.name
      end
    end
  end

  describe 'create' do
    it_behaves_like 'protected action' do
      let(:action) { post teams_path }
    end

    context 'signed in' do
      sign_in

      let(:params) do
        {
          team: {
            name: 'Lazio'
          }
        }
      end

      it 'should create team for current user' do
        post teams_path, params: params

        expect(response).to be_success
        expect(Team.all.size).to eql 1
        team = Team.first
        expect(team.name).to eql params[:team][:name]
        expect(team.user).to eql current_user
      end
    end
  end

  describe 'update' do
    let(:team) { create :team }

    it_behaves_like 'protected action' do
      let(:action) { patch team_path(team), params: {} }
    end

    context 'signed in' do
      sign_in

      let(:params) do
        {
          team: {
            name: 'Lazio'
          }
        }
      end

      it 'should update team' do
        patch team_path(team), params: params

        expect(response).to be_success
        expect(Team.all.size).to eql 1
        team = Team.first
        expect(team.name).to eql params[:team][:name]
      end
    end
  end

  describe 'destroy' do
    let(:team) { create :team }

    it_behaves_like 'protected action' do
      let(:action) { delete team_path(team) }
    end

    context 'signed in' do
      sign_in

      it 'should update team for current user' do
        delete team_path(team)

        expect(response).to be_success
        expect(Team.where(id: team.id)).to be_empty
      end
    end
  end
end
