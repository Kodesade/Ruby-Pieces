class Color

	@security = true

	def self.security()
		@security
	end

	FG = "38;"
	BG = "48;"
	UL = "58;"

	@fourbit = false

	def self.fourbit()
		@fourbit
	end

	@no_ul = false

	def self.no_ul()
		@no_ul
	end

	def self.reset()
		return "\x01\x1b[0m\x02"
	end

	def self.e_reset(type)
		n = type[0..2].to_i + 1
		return "\x01\x1b[#{n}m\x02"
	end

	def self.reset_fg()
		return self.e_reset(FG)
	end

	def self.reset_bg()
		return self.e_reset(BG)
	end

	def self.reset_ul()
		return self.e_reset(UL)
	end

	def self.create_rgb(r,g,b)
		type = "2;"
		args = "#{r};#{g};#{b}m"

		@security = false
		return self.new(type:type,args:args)
	end

	def self.create_8_bit(n)
		type= "5;"
		args = "#{n}m"
		@no_ul = true
		@security = false
		return self.new(type:type,args:args)
	end

	def self.create_4_bit(n,bright:false)
		if bright
			variation = "1;"
		end

		args = "#{n}m"
		@fourbit = true

		@security = false
		return self.new(variation:variation, args:args)
	end


	def initialize(variation:nil,type:nil,args:nil)
		if self.class.security
			raise "Don't run root method 'initialize'!"
		end

		@variation = variation
		@type = type
		@args = args
	end

	private def make()
        @color = "\x01\x1b[#{@variation}#{@type}#{@args}\x02"
	    return
    end

    private def apply(type,text)
        if not self.class.fourbit
        	@variation = type
        end
        make()
        return "#{@color}#{text}"
    end
    
    def apply_4_bit(text="")
    	return apply(0,text)
    end
    
    def foreground(text="")
    	return apply(FG,text)
    end
    
    def background(text="")
    	return apply(BG,text)
    end
    
    def underline(text="")
    	if self.class.no_ul
    		return text
    	else
    		return apply(UL,text)
    	end
    end

end
