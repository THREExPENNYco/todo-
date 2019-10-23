require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "tasks#index" do 
    it "should list the tasks in the database" do
      task1 = FactoryBot.create(:task)
      task2 = FactoryBot.create(:task) 
      task1.update_attributes(title: "Something Else")
      get :index
      expect(response).to have_http_status :success 

      response_value = ActiveSupport::JSON.decode(@response.body)
      expect(response_value.count).to eq(2)
      response_ids = [] 
      response_value.each do |task| 
        response_ids << task["id"]
      end 
      expect(response_ids).to eq([task1.id, task2.id])
    end 
    
    it "should change the task status to done in database" do 
      task = FactoryBot.create(:task)
      put :update, params: {id: task.id, task: { done: true }} 
      task.reload
      expect(response).to have_http_status(:success)
    end 
  end 

end
