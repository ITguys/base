module Base
  module Utils

    # convert "Google-style" query string to a Hash
    # the format of each field should comply with the data in db
    def self.extract_search_options(query)
      if query.present?
        query_hash = {}
        query = query.to_s.downcase

        names = []
        query.split(',').each do |q|
          q.strip!
          case q
          when AppConfig.regexp.phone_string
            query_hash["mobile_phone"] = q.gsub(/\D/, '')
          when /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
            query_hash["email"] = q
          when /\A\d+\z/
            query_hash["id"] = q
          else
            names << q
          end
        end
        query_hash["name"] = names.join('|') if names.present?
        query_hash
      end
    end
  end
end
