#!/usr/bin/env ruby

class GameNode
    attr_reader :ask, :quit, :text, :options

    def initialize(op = nil, &blk)
        @options = []
        @ask = op

        if block_given?
            instance_eval(&blk)
        end
    end

    def display(text)
        @text = text
    end

    def option(op, &blk) 
        node = GameNode.new(op)
        @options << node

        node.instance_eval(&blk)
    end

    def quit
        @quit = true
    end

    def quit?
        @quit
    end
end

class GameEngine
    def initialize(root)
        @root = root
    end

    def run
        execute(@root)
    end

    private

    def execute(root)
        puts(root.text)
        options = root.options.map(&:ask)

        if options.empty? || root.quit?
            return
        end

        puts(options.inspect)
        option = gets.strip
        while !options.include?(option)
            puts "option not found. try again"
            option = gets.strip
        end

        execute(root.options.find { |o| o.ask == option })
    end

end

root = GameNode.new do
    display "Hello! Would you like to start?"

    option "yes" do
        display "Cool. I see you wanna play. What character then?"

        option "warrior" do
            display "you're strong. but I'm afraid you died"

            quit
        end

        option "sorcerer" do
            display "You cast a spell, but you died anyway."

            quit
        end
    end

    option "no" do
        display "Ok, bye"

        quit
    end
end

engine = GameEngine.new(root)

engine.run

