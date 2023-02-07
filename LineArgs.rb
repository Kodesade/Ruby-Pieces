  class LineArgs

    attr_reader :args
    
    def self.link()
      self.new()
    end

    def initialize()
      array = ARGV
      if not array.is_a? Array
        raise TypeError "#{array.inspect} isn't Array"
      end
      @args = array
    end

    def parse(key,default)

      parser = get_type(key)
      value = parser.call(key,default)

      return value

    end
    
    private

    def get_type(key)
      if key.start_with? "--"
        return method(:parse_value)
      elsif key.start_with? "-"
        return method(:parse_bool)
      end
    end

    def find_index(regex)
      
      for arg in @args
        if arg.match regex
          return arg
        end
      end
      
      return nil

    end

    def parse_value(key,default)
      regex = Regexp.new("^#{key}(?:=(.+))?$")
      arg = find_index(regex)
      
      if not arg
        return default
      else
        value = arg.match(regex)[1]
        if not value
          value = default
        end

        return value
      end
    end

    def parse_bool(key,default)
      regex = Regexp.new("^#{key}$")
      return find_index(regex) ? true : default
    end

  end
