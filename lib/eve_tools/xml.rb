module EveTools
  class XML
    def initialize(opts={})
      @key_id = opts[:key_id] || EveTools.key_id
      @veri_code = opts[:verification_code] || EveTools.verification_code
      @user_agent = opts[:user_agent] || EveTools.user_agent
      @url = "https://api.eveonline.com"
      @url = "https://api.testeveonline.com" if opts[:test]
    end

    def call_without_auth(endpoint, arg_hash={})
      process_response(endpoint, arg_hash)
    end

    def call_with_auth(endpoint, arg_hash={})
      process_response(endpoint, {:keyID => @key_id, :vCode => @veri_code}.merge(arg_hash))
    end

  protected
    def process_response(endpoint, arg_hash)
      uri = URI.parse("#{@url}/#{endpoint}.xml.aspx")
      response = Net::HTTP.post_form(uri, arg_hash)
    end
  end
end
