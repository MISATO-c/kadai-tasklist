class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def show
    #@task = Task.find(params[:id])
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def new
    #@task = Task.new
    @task = current_user.tasks.build
  end

  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Taskが追加されました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] ='Taskが追加されませんでした。'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success]  = 'Taskは正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskは更新されませんんでした'
      reder :edit
    end
  end

  def destroy
    # @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to root_url
    #redirect_back(fallback_location: root_path)
  end
  
  private
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end

