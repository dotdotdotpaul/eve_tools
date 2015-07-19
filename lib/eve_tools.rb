require "eve_tools/railtie" if defined?(Rails)
require "eve_tools/crest"
require "eve_tools/igb"
require "eve_tools/version"

module EveTools

  def self.key_id
    Rails.application.secrets.eve_key_id
  end
  def self.verification_code
    Rails.application.secrets.eve_verification
  end

  TYPE_ID_HASH = {
    :alliance => 16159,
    :character => 1377,
    :corporation => 2,
    :constellation => 4,
    :region => 3,
    :system => 2,
    :station => 3867,
  }
  def self.type_id_for(kind)
    TYPE_ID_HASH[kind.to_sym].tap do | result |
      if result.nil?
        raise ArgumentError.new("Invalid kind #{result.inspect}")
      end
    end
  end

end

