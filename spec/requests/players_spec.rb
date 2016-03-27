require 'rails_helper'

RSpec.describe 'Player', type: :request do
  let(:team) { create :team }

  describe 'listing' do
    it_behaves_like 'protected action' do
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

  describe 'create' do
    it_behaves_like 'protected action' do
      let(:action) { post team_players_path(team) }
    end

    context 'signed in' do
      sign_in

      let(:params) do
        {
          player: {
            name: 'Pele'
          }
        }
      end

      it 'should create player for current user and team' do
        post team_players_path(team), params: params

        expect(response).to be_success
        expect(Player.all.size).to eql 1
        player = Player.first
        expect(player.name).to eql params[:player][:name]
        expect(player.user).to eql current_user
        expect(player.team).to eql team
      end
    end
  end

  describe 'update' do
    let(:player) { create :player }

    it_behaves_like 'protected action' do
      let(:action) { patch player_path(player), params: {} }
    end

    context 'signed in' do
      sign_in

      let(:params) do
        {
          player: {
            name: 'Pele'
          }
        }
      end

      it 'should update player' do
        patch player_path(player), params: params

        expect(response).to be_success
        expect(Player.all.size).to eql 1
        player = Player.first
        expect(player.name).to eql params[:player][:name]
      end
    end
  end

  describe 'destroy' do
    let(:player) { create :player }

    it_behaves_like 'protected action' do
      let(:action) { delete player_path(player) }
    end

    context 'signed in' do
      sign_in

      it 'should update team for current user' do
        delete player_path(player)

        expect(response).to be_success
        expect(Player.where(id: player.id)).to be_empty
      end
    end
  end
end
