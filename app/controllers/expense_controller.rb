class ExpenseController < ApplicationController
    def myList
        uid = session["uid"]
        @myList = Post.where("uid = ?", uid).order("updated_at DESC")
         
    end

    def add

    end
end
