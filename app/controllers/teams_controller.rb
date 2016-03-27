class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:update, :destroy]

  def index
    @teams = Team.all

    render json: @teams
  end

  def create
    team = current_user.teams.create! team_params

    render json: team
  end

  def update
    @team.assign_attributes team_params
    @team.save!

    render json: @team
  end

  def destroy
    @team.destroy!

    head :ok
  end

  private

  def team_params
    params.require(:team).permit :name
  end

  def find_team
    @team = Team.find params[:id]
  end
end
