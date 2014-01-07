module SearchUser
    attr_accessor :kwd

    def search(kwd)
        key = CONFIG["search_user_key"]
        sign = create_search_sign(kwd)
        require 'net/http'

        begin
            url = URI.parse(CONFIG["search_user_url"])
            response = Net::HTTP.post_form(url, {'kwd' => kwd, 'key' => key, 'sign' => sign})
            res = response.body
        rescue
            res = "error"
        end
        
        return res
    end

    private
        def create_search_sign(kwd)
            signKey = CONFIG["search_user_sign"].dup
            tmp = "key="
            tmp << signKey
            tmp << "&kwd="
            tmp << kwd

            return Digest::MD5.hexdigest(tmp)
        end
end
