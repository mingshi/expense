class ExpenseController < ApplicationController
    include SearchUser
    def myList
        uid = session["uid"]
        @myList = Post.where("uid = ?", uid).order("updated_at DESC")
         
    end

    def add
        if request.method == "POST"
            
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
end
