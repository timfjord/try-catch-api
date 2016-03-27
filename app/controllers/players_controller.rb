class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:index, :create]
  before_action :find_player, only: [:update, :destroy]

  def index
    @players = @team.players

    render json: @players
  end

  def create
    player = @team.players.create! player_params.merge(user: current_user)

    render json: player
  end

  def update
    @player.assign_attributes player_params
    @player.save!

    render json: @player
  end

  def destroy
    @player.destroy!

    head :ok
  end

  private

  def player_params
    params.require(:player).permit :team_id, :name
  end

  def find_team
    @team = Team.find params[:team_id]
  end

  def find_player
    @player = Player.find params[:id]
  end
end
