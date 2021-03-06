class ExpenseController < ApplicationController
    include SearchUser
    def myList
        @menu = "list"
        uid = session["uid"]
        if params[:hova] == "1"
            @msg = Hash.new
            @msg["info"] = "提交成功"
            @msg["type"] = "succ"
        end
        @myList = Ex.where("uid = ?", uid).order("updated_at DESC")
        @myInit = Ex.where("uid = ? AND status = ?", uid, CONFIG["init_status"]).order("updated_at DESC")
        @myChecked = Ex.where("uid = ? AND status = ?", uid, CONFIG["checked_status"]).order("updated_at DESC")
        @myReject = Ex.where("uid = ? AND status = ?", uid, CONFIG["reject_status"]).order("updated_at DESC")
        @myComplete = Ex.where("uid = ? AND status = ?", uid, CONFIG["complete_status"]).order("updated_at DESC")
    end
    
    def myManage
        @menu = "manage"
        uid = session[:uid]
        @ManageInit = Ex.where("step_uid = ? AND status = ?", uid, CONFIG["init_status"]).order("updated_at DESC")
        @ManageReject = Ex.where("step_uid = ? AND status = ?", uid, CONFIG["reject_status"]).order("updated_at DESC")
        @ManageChecked = Ex.where("step_uid = ? AND status = ?", uid, CONFIG["checked_status"]).order("updated_at DESC")
        @ManageComplete = Ex.where("step_uid = ? AND status = ?", uid, CONFIG["complete_status"]).order("updated_at DESC")
    end

    def show
        @check = 0
        unless check_permission(params[:id])
            @msg = Hash.new
            @msg["info"] = "你没有权限查看该记录"
            @msg["type"] = "error"
        else
            @check = 1
            uid = session[:uid]
            @ex = Ex.find(params[:id])
            @posts = Post.where("eid = ?", params[:id]).order("updated_at DESC")
            @checks = Check.where("eid = ?", params[:id]).order("created_at DESC")
        end
    end
   
    def do_check
        if request.method == "POST" 
            
        end
    end

    def add
        if request.method == "POST"

            params[:expense][:uid] = session[:uid]
            params[:expense][:created_at] = Time.new.strftime("%Y-%m-%d %H:%M:%S")
            params[:expense][:status] = 0

            stepArr = params[:step].split(' ')

            params[:expense][:step_uid] = stepArr[0]
            params[:expense][:step_realname] = stepArr[1]        
   
            post_num = 0
            totalMoney = 0
            params[:posts][:des].each_with_index do |d, index|
                p params[:posts]
                if params[:posts][:des][index].to_s.strip.length != 0 && params[:posts][:department][index].to_s.strip.length != 0 && params[:posts][:project][index].to_s.strip.length != 0 && params[:posts][:p_type][index].to_s.strip.length != 0 && params[:posts][:money][index].to_s.strip.length != 0
                    totalMoney += params[:posts][:money][index].to_f
                    post_num += 1
                end
            end
            
            params[:expense][:money] = totalMoney

            @msg = Hash.new
            if post_num == 0 || totalMoney == 0
                @msg["info"] = "报销信息不完整"
                @msg["type"] = "error"
            else
                @expense = Ex.new(expense_params)
                @expense.save
                if @expense.errors.full_messages.any?
                    @msg["info"] = @expense.errors.full_messages.join(',')
                    @msg["type"] = "error"
                else
                    params[:posts][:des].each_with_index do |d, index|
                        unless params[:posts][:des][index].to_s.strip.length == 0 && params[:posts][:department][index].to_s.strip.length == 0 && params[:posts][:project][index].to_s.strip.length == 0 && params[:posts][:p_type][index].to_s.strip.length == 0 && params[:posts][:money][index].to_s.strip.length == 0
                            params[:post] = {
                                "uid"           =>  session[:uid],
                                "realname"      =>  session[:realname],
                                "department"    =>  params[:posts][:department][index],
                                "project"       =>  params[:posts][:project][index],
                                "p_type"          =>  params[:posts][:p_type][index],
                                "money"         =>  params[:posts][:money][index],
                                "des"           =>  params[:posts][:des][index],
                                "eid"           =>  @expense.id,
                                "created_at"    =>  Time.new.strftime("%Y-%m-%d %H:%M:%S")
                            }
                            
                            @post = Post.new(posts_params)
                            unless @post.save
                                @msg["info"] = "报销详细错误"
                                @msg["type"] = "error"

                                Ex.find(@expense.id).destroy
                                Post.find(:eid => @expense.id).destroy_all

                                render :add
                            end
                        end
                    end

                    @msg["info"] = "提交成功"
                    @msg["type"] = "succ"

                    redirect_to :action => 'myList', :hova => 1
                end
            end   
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
            params.require(:expense).permit(:uid, :money, :borrow, :realoffs, :spread, :status, :capital, :step_uid, :step_realname, :created_at, :update_at)
        end

        def posts_params
            params.require(:post).permit(:uid, :realname, :department, :project, :p_type, :money, :des, :eid, :created_at, :update_at)
        end

        def render_to_root
            render :controller => 'expense', :action => 'myList'
        end

        def check_permission(id)
            uid = session[:uid]
            if tmpEx = Ex.find_by_id(id)
                return uid == tmpEx.uid || uid == tmpEx.step_uid 
                # || (CONFIG["finance"].include? uid.to_s)
            else 
                return false
            end
        end
end
