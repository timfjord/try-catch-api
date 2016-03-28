require 'rails_helper'

RSpec.describe 'Player', type: :request do
  let(:team) { create :team }

  describe 'listing' do
    it_behaves_like 'action that requires authentification' do
      let(:action) { get team_players_path(team) }
    end

    context 'signed in' do
      sign_in

      let!(:team_player) { create :player, team: team }
      let!(:player_from_another_team) { create :player }

      it 'should return all players' do
        get team_players_path(team)

        expect(response).to be_success
        resp = parse_json response.body
        expect(resp['players'].size).to eql 1
        expect(resp['players'][0]['id']).to eql team_player.id
        expect(resp['players'][0]['name']).to eql team_player.name
      end
    end
  end

  describe 'build' do
    it_behaves_like 'action that requires authentification' do
      let(:action) { get build_players_path }
    end

    it 'should return built player with policy' do
      user = create :guest
      sign_in user

      get build_players_path

      expect(response).to be_success
      resp = parse_json response.body
      expect(resp['player']['createable']).to eql false
    end
  end

  describe 'create' do
    let(:params) do
      {
        player: {
          name: 'Pele'
        }
      }
    end

    it_behaves_like 'action that requires authentification' do
      let(:action) { post team_players_path(team), params: params }
    end

    it_behaves_like 'action that requires authorization for', :guest do
      let(:action) { post team_players_path(team), params: params }
    end

    it 'should create player for current user and team' do
      user = create :regular
      sign_in user
      post team_players_path(team), params: params

      expect(response).to be_success
      expect(Player.all.size).to eql 1
      player = Player.first
      expect(player.name).to eql params[:player][:name]
      expect(player.user).to eql user
      expect(player.team).to eql team
    end
  end

  describe 'update' do
    let(:player) { create :player }
    let(:params) do
      {
        player: {
          name: 'Pele'
        }
      }
    end

    it_behaves_like 'action that requires authentification' do
      let(:action) { patch player_path(player), params: params }
    end

    it_behaves_like 'action that requires authorization for', :regular do
      let(:action) { patch player_path(player), params: params }
    end

    it 'should update any player as admin' do
      sign_in
      patch player_path(player), params: params

      expect(response).to be_success
      expect(Player.all.size).to eql 1
      player = Player.first
      expect(player.name).to eql params[:player][:name]
    end

    it 'should update own player as regular' do
      regular_user = create :regular
      player.update_attributes user: regular_user
      sign_in regular_user

      patch player_path(player), params: params

      expect(response).to be_success
      expect(Player.all.size).to eql 1
      player = Player.first
      expect(player.name).to eql params[:player][:name]
    end
  end

  describe 'destroy' do
    let(:player) { create :player }

    it_behaves_like 'action that requires authentification' do
      let(:action) { delete player_path(player) }
    end

    it_behaves_like 'action that requires authorization for', :regular do
      let(:action) { delete player_path(player) }
    end

    it 'should destroy any player as admin' do
      sign_in
      delete player_path(player)

      expect(response).to be_success
      expect(Player.where(id: player.id)).to be_empty
    end

    it 'should destroy own player as regular user' do
      regular_user = create :regular
      player.update_attributes user: regular_user
      sign_in regular_user
      delete player_path(player)

      expect(response).to be_success
      expect(Player.where(id: player.id)).to be_empty
    end
  end
end
