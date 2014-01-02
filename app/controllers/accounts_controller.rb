class AccountsController < ApplicationController
    include AuthLogin
    def login
        if request.method == "POST"
            username = params[:username].strip
            passwd  =   params[:passwd].strip
           
            if username == ""
                @msg = Hash.new
                @msg["info"] = "请填写用户名"
                @msg["type"] = "error"
            end
            if passwd == ""
                @msg = Hash.new
                @msg["info"] = "请填写密码"
                @msg["type"] = "error"
            end
           
            if not defined? @msg
                res = dologin(username, passwd)
                
                if res == "error"
                    @msg = Hash.new
                    @msg["info"] = "登陆出现系统错误"
                    @msg["type"] = "error"
                else
                    require "rubygems"
                    require "json"
                    parsed = JSON.parse(res)
                    @msg = Hash.new
                    @msg["info"] = parsed["msg"]
                    if parsed["code"] == 0
                        @msg["type"] = "succ"
                        session["realname"] = parsed["info"]["realname"]
                        session["uid"] = parsed["info"]["id"]
                        session["username"] = parsed["info"]["username"]
                        redirect_to root_url
                    else
                        @msg["type"] = "error"
                    end
                end
            end
        end
    end

    def logout
        session.delete(:realname)
        session.delete(:uid)
        session.delete(:username)
        redirect_to root_url
    end

end
