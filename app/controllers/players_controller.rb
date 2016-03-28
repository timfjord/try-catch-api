class PlayersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:index, :create]
  before_action :find_player, only: [:update, :destroy]

  def index
    @players = @team.players

    render json: @players
  end

  def build
    render json: Player.new
  end

  def create
    player = @team.players.build player_params.merge(user: current_user)
    authorize player
    player.save

    render json: player
  end

  def update
    authorize @player
    @player.assign_attributes player_params
    @player.save!

    render json: @player
  end

  def destroy
    authorize @player
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
