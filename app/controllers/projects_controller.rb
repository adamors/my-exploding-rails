# Controller for projects
class ProjectsController < ApplicationController
  # before_action :authenticate!, only: [:show]

  def index
    projects = repo.all
    render json: projects
  end

  def show
    project = repo.by_id(params[:id])
    render json: project
  end

  def create
    Projects::Create.new.call(project_params) do |result|
      result.success do |project|
        render json: project
      end

      result.failure do |errors|
        render json: errors
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:name).to_h.symbolize_keys
  end

  def repo
    ProjectRepository.new(rom)
  end
end
