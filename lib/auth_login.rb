module AuthLogin
    attr_accessor :username
    attr_accessor :passwd

    def dologin(username, passwd)
        require 'net/http'
        sign = login_hash(username, passwd)
        passwd = password_hash(passwd)
        
        begin
            url = URI.parse(CONFIG["auth_login_url"])
            response = Net::HTTP.post_form(url, {'username' => username, 'password' => passwd, 'sign' => sign})
            res = response.body
        rescue
            res = "error"
        end

        return res
    end
    
    private
        def password_hash(passwd)
            signKey = CONFIG["auth_sign_key"].dup
            tmpPass = Digest::MD5.hexdigest(passwd)
            
            signKey << tmpPass
            return Digest::MD5.hexdigest(signKey)
        end

        def login_hash(username, passwd)
            tmpPassword = password_hash(passwd)
            tmpUrl = "key="
            tmpUrl << CONFIG["auth_login_key"]
            tmpUrl << "&password="
            tmpUrl << tmpPassword
            tmpUrl << "&username="
            tmpUrl << username
            return Digest::MD5.hexdigest(tmpUrl)
        end

end
