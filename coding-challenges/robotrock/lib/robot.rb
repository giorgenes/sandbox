require 'matrix'

class Robot
  # face directions represented as (x,y) vectors
  FACE_TO_VECTOR_MAP = {
      'NORTH' => [0, 1].freeze,
      'SOUTH' => [0, -1].freeze,
      'WEST'  => [-1, 0].freeze,
      'EAST'  => [1, 0].freeze,
  }.freeze

  FACES = FACE_TO_VECTOR_MAP.keys.freeze

  VECTOR_TO_FACE_MAP = FACE_TO_VECTOR_MAP.invert.freeze

  # 90 and 270 degree rotation matrices
  # rotation is counter clockwise
  ROTATION_MATRIX_MAP = {
    'LEFT'  => Matrix.columns([[0, 1], [-1, 0]]).freeze,
    'RIGHT' => Matrix.columns([[0, -1], [1, 0]]).freeze
  }.freeze

  DIRECTIONS = ROTATION_MATRIX_MAP.keys.freeze

  def initialize
    set_face('NORTH')
    @placed = false
  end

  def set_tabletop_dimensions(x, y)
    @max_x = x
    @max_y = y
  end

  def set_face(face)
    @face = FACE_TO_VECTOR_MAP[face]
  end

  def place(position, face)
    if inside_limits?(position)
      set_face(face)
      @position = Matrix.column_vector(position)
      @placed = true
      return true
    else
      return false
    end
  end

  # computes next position. doest care about limits
  def next_position
    (@position + face_vector).column(0).to_a
  end

  def face
    VECTOR_TO_FACE_MAP[@face]
  end

  # rotate the `face` vector either 90 degrees or 270 depending on direction
  def turn(direction)
    return unless @placed
    @face = (ROTATION_MATRIX_MAP[direction] * face_vector).column(0).to_a
  end

  def move
    return unless @placed
    n = next_position
    if inside_limits?(n)
      @position = Matrix.column_vector(n)
    end
  end

  def position
    @position.column(0).to_a
  end

  def report(out = STDOUT)
    return unless @placed
    out << "#{position[0]},#{position[1]},#{face}\n"
  end

  private

  def face_vector
    Matrix.column_vector(@face)
  end

  def inside_limits?(v)
    v[0] < @max_x && v[0] >= 0 && v[1] < @max_y && v[1] >= 0
  end
end
