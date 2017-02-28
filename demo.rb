class Demo
    attr_accessor :name, :num

    def bob
        puts "░░░░███████ ]▄▄▄▄▄▄▄▄ Bob is building an army."
        puts "▂▄▅█████████▅▄▃▂        ☻ / This tank & Bob are against software engineering"
        puts "||███████████████████]. /▌ Copy and Paste this all over"
        puts "◥⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙▲⊙◤.. / \\ GitHub if you are with us"
        puts
    end

    def loops
        listy = ['apple', 'orange', 'banana', 'blueberry', 'durian']
        listy.each do |fruit|
            puts fruit
        end
        puts

        count = 0
        while count < 5 do
            puts count
            count += 1
        end
        puts
    end

    def conditionals
        unless 1 > 2
            puts '1 is greater than 2???'
        else
            puts '1 is not greater than 2'
        end
        puts 'single-line if!' if true
        puts
    end

    def hashes
        hash = Hash["a" => 100, "b" => 200]
        puts hash["a"]
        puts
    end

end

demo = Demo.new

demo.name = "Matthew"
demo.num = 5
puts "name is #{demo.name}, num is #{demo.num}"
puts

demo.bob
demo.loops
demo.conditionals
demo.hashes
