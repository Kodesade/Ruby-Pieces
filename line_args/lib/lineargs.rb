  class LineArgs

    def initialize()
      @args = ARGV
    end

    def parse(key,default=nil)

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
      default = true & default
      regex = Regexp.new("^#{key}$")
      return find_index(regex) ? (not default) : default
    end

  end

  ARGL=LineArgs.new
