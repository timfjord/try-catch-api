class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team, only: [:update, :destroy, :show]

  def index
    @teams = Team.all

    render json: @teams
  end

  def create
    team = current_user.teams.build team_params
    authorize team
    team.save!

    render json: team
  end

  def show
    render json: @team
  end

  def update
    authorize @team
    @team.assign_attributes team_params
    @team.save!

    render json: @team
  end

  def destroy
    authorize @team
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
