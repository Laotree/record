class WelcomeController < ApplicationController
  def index
#puts params[:action].to_s
#puts "+++++++++"
    @message = mix(params[:date].to_s,params[:username].to_s,params[:cpname].to_s,params[:appname].to_s,params[:area].to_s,params[:stuff].to_s)
    @file = '/home/laotree/web/view_record/log/test.log'
    @result = find_line(@file,@message)
#puts '=========='  
    puts (@result.size)
    max = (@result.size - 1)
    if (max <= 0)
      max = max + 1
    end
    puts max
    @resultList = Array.new(max)
    for i in (0..max)
      if (@result[i] != nil)
        @resultList[i] = @result[i].split(",")
        #puts @resultList[i]
      end
    end
  end
end

def find_line(log_name,index_name)
  arr = IO.readlines(log_name)
  max = (arr.size - 1)
  $j = 0
  result = Array.new()
  for i in 0..max
  #[0..max].each do |i|
    if (arr[i].include?index_name)
      result[$j] = arr[i]
      $j += 1
      #puts $j
    end
  end
  return result
end

def traverse_dir(file_path)
    if File.directory? file_path
        Dir.foreach(file_path) do |file|
            if file !="." and file !=".."
                traverse_dir(file_path+"/"+file)
            end
        end
    else
        return "#{File.basename(file_path)}"
    end
end

def mix(date,username,cpname,appname,area,action)
  @mix = ""
  if (action != "")
    @mix = "," + action
#  puts @mix

  end
#puts "-------------"
  if (area != "")
    @mix = "," + area + @mix
 # puts @mix
  end
  if (appname != "")
    @mix = "," + appname + @mix
  #puts @mix
  end
  if (cpname != "")
    @mix = "," + cpname + @mix

  #puts @mix
  end

  if (username != "")
    @mix = "," + username + @mix
  #puts @mix
  end
  #puts @mix
  return @mix
end


