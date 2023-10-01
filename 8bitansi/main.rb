STEPS=[0x0,0x5f,0x87,0xaf,0xd7,0xff]

class Bit8Color
  def self.tput(r,g,b)
    color_id = self.calc(r,g,b)
    puts "%sHello World with %s!%s" % [`tput setaf #{color_id}`,color_id,`tput sgr0`]
  end

  private
  def self.calc(r,g,b)
    dist=[]
    for i in 16..231
      c1 = self.rgb(i)
      c2 = [r,g,b]
      dist << [0,1,2].map{|i| Math.sqrt((c1[i] - c2[i])**2)}.sum
    end
    _, idx = dist.each_with_index.min
    return idx+16
  end

  def self.rgb(id)
    id = id - 16
    y=(id / 36)
    col=id - (y * 36)
    x_green = col / 6
    x_blue = col % 6
    return [y,x_green,x_blue].map{|x| STEPS[x]}
  end
end

if ARGV.length == 3 and (ARGV.all?{|x| x =~ /\d+/})
  Bit8Color.tput(ARGV[0].to_i,ARGV[1].to_i,ARGV[2].to_i)
end
