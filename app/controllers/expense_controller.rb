class ExpenseController < ApplicationController
    include SearchUser
    def myList
        uid = session["uid"]
        @myList = Post.where("uid = ?", uid).order("updated_at DESC")
         
    end

    def add
        if request.method == "POST"
            params[:uid] = session["uid"]
            params[:create_at] = Time.new.strftime("%Y-%m-%d %H:%M:%S");
            params[:status] = 0
            
            stepArr = params[:step].split(' ')
            
            params[:step_uid] = stepArr[0]
            params[:step_realname] = stepArr[1]
            params[:department]  = stepArr[2]
            
            @expense = Ex.new(expense_params)
            p @expense.errors.full_messages
            @expense.save
        end
    end

    def get_json_user
        kwd = params[:term].strip
        res = search(kwd)
        require 'rubygems'
        require 'json'
        tmp = JSON.parse(res)

        final = tmp["info"].to_json
        render text: final
    end

    private
        def expense_params
            params.permit(:uid, :money, :borrow, :realoffs, :spread, :status, :capital, :step_uid, :step_realname, :created_at, :update_at)
        end

        def posts_params
            params.permit(:uid, :realname, :department, :project, :type, :money, :des, :eid, :create_at, :update_at)
        end
end
