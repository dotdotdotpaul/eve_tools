# This is a simple wrapper around CCPEVE IGB javascript calls.  If you're
# serving a Rails template, rather than writing the CCPEVE call right into
# the template, substitute a call to a new instance of IGB here; this
# will check the request to see if you're in the IGB or not; if not, then
# nothing is displayed (since it won't work anyway).  This prevents your
# pages from throwing unresolved CCPEVE constant errors on non-IGB clients.
#
# For example, instead of putting this in your application.html.erb:
#   <body onload="CCPEVE.requestTrust('http://mysite.com/')">
# you'd write:
#   <body onload="<%= igb.requestTrust("http://mysite.com/") %>">
# (where ccpeve = IGB.new(request))
#
# Some calls are magical this way -- you can actually just requestTrust() and
# the code will figure out your root path by default, based on the request
# information.
#
# This object instance also provides very easy access to the IGB's headers,
# such as "igb.char_name"

module EveTools
  class IGB
    
    # Store whether or not we detected the EVE IGB client...
    def initialize(request)
      @request = request
      @active = !request.env["HTTP_EVE_TRUSTED"].blank?
    end
  
    def self.key_id
      Rails.application.secrets.eve_key_id
    end
    def self.verification_code
      Rails.application.secrets.eve_verification
    end
  
    # Returns true if we discovered the HTTP_EVE_TRUSTED header in the request
    # -- not a PERFECT check for being in the IGB, but pretty easy.
    def active?
      @active
    end
  
    # Note:  Kept lowerCamelCase to match CCPEVE's documentation...
    def requestTrust(url=nil)
      url ||= "#{request.protocol}#{request.env["HTTP_HOST"]}"
      if_active("requestTrust", url)
    end
  
    # Use method_missing as a cheapout way of supporting ALL CCPEVE calls.
    # MOST of them are lowerCamelCase -- block() and bookmark() are the 
    # exceptions, so only explicitly check for those.
    def method_missing(method_sym, *args)
      if method_sym.to_s =~ /block|bookmark|([a-z]+[A-Z][A-z]+)/
        if_active(method_sym, args)
      elsif HEADERS.include?(header = method_sym.to_s.upcase.gsub("_",""))
        @request.env["HTTP_EVE_#{header}"]
      else
        super
      end
    end
  
    # These are the IGB headers (well, prefixed with HTTP_EVE_ they are...)
    HEADERS = ["TRUSTED",
               "SERVERIP",
               "CHARNAME",
               "CHARID",
               "CORPNAME",
               "CORPID",
               "ALLIANCENAME",
               "ALLIANCEID",
               "REGIONNAME",
               "CONSTELLATIONNAME",
               "SOLARSYSTEMNAME",
               "STATIONNAME",
               "STATIONID",
               "CORPROLE",
               "SOLARSYSTEMID",
               "WARFACTIONID",
               "SHIPID",
               "SHIPNAME",
               "SHIPTYPEID",
               "SHIPTYPENAME"
              ]

  private
    include ::ActionView::Helpers::JavaScriptHelper
    def if_active(func, *args)
      return unless @active
      "CCPEVE.#{func.to_s}(#{args.map{|x| x.is_a?(String) ? "'#{escape_javascript(x)}'" : x }.join(", ")})"
    end
  end
end

