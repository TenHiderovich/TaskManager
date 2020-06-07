# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::ApplicationController
  respond_to :json

  def index
    tasks = Task.ransack(ransack_params)
                .result
                .order('created_at DESC')
                .page(page)
                .per(per_page)

    respond_with(tasks, each_serializer: TaskSerializer, root: 'items', meta: build_meta(tasks))
  end

  def show
    task = Task.find(params[:id])

    respond_with(task, serializer: TaskSerializer)
  end

  def create
    task = current_user.my_tasks.new(task_params)
    task.author_id ||= current_user.id

    if task.save
      UserMailer.with({ user: current_user, task: task }).task_created.deliver_now
    end

    respond_with(task, serializer: TaskSerializer, location: nil)
  end

  def update
    task = Task.find(params[:id])
    author = User.find(task.author_id)

    if task.update(task_params)
      UserMailer.with({ user: author, task: task }).task_updated.deliver_now
    end

    respond_with(task, serializer: TaskSerializer)
  end

  def destroy
    task = Task.find(params[:id])
    author = User.find(task.author_id)

    if task.destroy
      UserMailer.with({ user: author, task: task }).task_destroyed.deliver_now
    end

    respond_with(task)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :author_id, :assignee_id, :state_event)
  end
end
