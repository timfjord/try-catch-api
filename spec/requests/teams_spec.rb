require 'rails_helper'

RSpec.describe 'Teams', type: :request do
  describe 'listing' do
    it_behaves_like 'action that requires authentification' do
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

  describe 'show' do
    let(:team) { create :team }

    it_behaves_like 'action that requires authentification' do
      let(:action) { get team_path(team) }
    end

    context 'signed in' do
      sign_in :guest

      it 'should show team' do
        get team_path(team)

        expect(response).to be_success
        resp = parse_json response.body
        expect(resp['team']['id']).to eql team.id
        expect(resp['team']['name']).to eql team.name
      end
    end
  end

  describe 'build' do
    it_behaves_like 'action that requires authentification' do
      let(:action) { get build_teams_path }
    end

    it 'should return built team with policy' do
      user = create :guest
      sign_in user

      get build_teams_path

      expect(response).to be_success
      resp = parse_json response.body
      expect(resp['team']['createable']).to eql false
    end
  end

  describe 'create' do
    let(:params) do
      {
        team: {
          name: 'Lazio'
        }
      }
    end

    it_behaves_like 'action that requires authentification' do
      let(:action) { post teams_path }
    end

    it_behaves_like 'action that requires authorization for', :guest do
      let(:action) { post teams_path, params: params }
    end

    it 'should create team for current user' do
      user = create :regular
      sign_in user
      post teams_path, params: params

      expect(response).to be_success
      expect(Team.all.size).to eql 1
      team = Team.first
      expect(team.name).to eql params[:team][:name]
      expect(team.user).to eql user
    end
  end

  describe 'update' do
    let(:team) { create :team }
    let(:params) do
      {
        team: {
          name: 'Lazio'
        }
      }
    end

    it_behaves_like 'action that requires authentification' do
      let(:action) { patch team_path(team), params: {} }
    end

    it_behaves_like 'action that requires authorization for', :guest do
      let(:action) { patch team_path(team), params: params }
    end

    it_behaves_like 'action that requires authorization for', :regular do
      let(:action) { patch team_path(team), params: params }
    end

    it 'should update any team as admin' do
      sign_in create(:admin)

      patch team_path(team), params: params

      expect(response).to be_success
      expect(Team.all.size).to eql 1
      expect(Team.first.name).to eql params[:team][:name]
    end

    it 'should update own tean as regular user' do
      regular_user = create :regular
      team.update_attributes user: regular_user
      sign_in regular_user

      patch team_path(team), params: params

      expect(response).to be_success
      expect(Team.all.size).to eql 1
      expect(Team.first.name).to eql params[:team][:name]
    end
  end

  describe 'destroy' do
    let(:team) { create :team }

    it_behaves_like 'action that requires authentification' do
      let(:action) { delete team_path(team) }
    end

    it_behaves_like 'action that requires authorization for', :regular do
      let(:action) { delete team_path(team) }
    end

    it 'should destroy any team as admin' do
      sign_in create(:admin)
      delete team_path(team)

      expect(response).to be_success
      expect(Team.where(id: team.id)).to be_empty
    end

    it 'should destroy own team as regular user' do
      regular_user = create :regular
      team.update_attributes user: regular_user
      sign_in regular_user
      delete team_path(team)

      expect(response).to be_success
      expect(Team.where(id: team.id)).to be_empty
    end
  end
end
