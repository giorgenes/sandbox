class Cli
  def initialize(args, db)
    @args = args
    @db = db
  end

  COMMANDS = {
    'search' => 'Search by name',
    'find_dups' => 'Find duplicate emails in the loaded data',
  }

  def help
    puts "Usage: cli [command] [options]"
    puts "Available commands:"
    COMMANDS.each do |command, description|
      puts "  #{command}: #{description}"
    end
  end

  def run
    if @args.empty?
      return help
    end

    command = @args.shift
    case command
    when 'search'
      search(@args)
    when 'find_dups'
      find_dups
    else
      help
    end
  end

  def search(args)
    puts "Searching for: #{args.join(' ')}"

    locs = @db.prefix(:clients, :full_name, args.join(' '))
    if locs.empty?
      puts "No results found for: #{args.join(' ')}"
      return
    end

    locs.each do |loc|
      puts "Found: #{loc.inspect}"
    end

  end

  def find_dups
    puts "Finding duplicates..."

    @db.dups(:clients, :email).each do |loc|
      puts "Duplicate found: #{loc}"
    end
  end
end