if !defined?(::Diffbot::APIClient::VERSION)
  module Diffbot
    class APIClient

      ##
      # Version compatible with SemVer v2.0.0
      module VERSION
        MAJOR = 1
        MINOR = 2
        TINY  = 0
        PATCH = nil
        STRING = [MAJOR, MINOR, TINY, PATCH].compact.join('.')
      end

    end
  end
end
