require_relative 'index'

class Database
  def initialize(adapter)
    @adapter = adapter
    @tables = {}
    @indexes = {}
  end

  def create_index(table_name, column_name)
    raise "Table #{table_name} not found" unless @tables.key?(table_name)

    docs = @tables[table_name]
    data_accessor = ->(i) { docs[i][column_name.to_s] }

    index = Index.new(docs.size, data_accessor)

    @indexes[table_name] ||= {}
    @indexes[table_name][column_name] = index
  end

  def load_table(table_name, file_path)
    docs = @adapter.load_from(file_path)

    @tables[table_name] = docs
  end

  def term(table_name, column_name, query)
    raise "Table #{table_name} not found" unless @tables.key?(table_name)
    raise "Index for column #{column_name} not found" unless @indexes[table_name]&.key?(column_name)

    table = @tables[table_name]
    index = @indexes[table_name][column_name]
    loc = index.term(query)

    return nil if loc.nil?
    loc = index[loc] if loc

    table[loc]
  end

  def prefix(table_name, column_name, query)
    raise "Table #{table_name} not found" unless @tables.key?(table_name)
    raise "Index for column #{column_name} not found" unless @indexes[table_name]&.key?(column_name)

    table = @tables[table_name]
    index = @indexes[table_name][column_name]
    locs = index.prefix(query)

    return [] if locs.empty?

    locs.map do |loc|
      table[loc]
    end
  end

  def dups(table_name, column_name)
    raise "Table #{table_name} not found" unless @tables.key?(table_name)
    raise "Index for column #{column_name} not found" unless @indexes[table_name]&.key?(column_name)

    table = @tables[table_name]
    index = @indexes[table_name][column_name]

    index.dups
  end

end