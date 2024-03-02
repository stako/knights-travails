# frozen_string_literal: true

# chess board, each tile referenced by index:
#       0   1   2   3   4   5   6   7

# 0   [ 0][ 1][ 2][ 3][ 4][ 5][ 6][ 7]
# 1   [ 8][ 9][10][11][12][13][14][15]
# 2   [16][17][18][19][20][21][22][23]
# 3   [24][25][26][27][28][29][30][31]
# 4   [32][33][34][35][36][37][38][39]
# 5   [40][41][42][43][44][45][46][47]
# 6   [48][49][50][51][52][53][54][55]
# 7   [56][57][58][59][60][61][62][63]

module KnightsTravails
  # Class to determine a chess knight's shortest path from one tile to another
  class Knight
    def initialize
      @graph = build_graph
    end

    def moves(source_pos, target_pos)
      return puts "Invalid positions!" unless valid_positions?(source_pos, target_pos)

      source_tile = @graph[get_index(source_pos)]
      target_tile = @graph[get_index(target_pos)]

      clear_distances
      target_tile.distance = 0
      build_path(source_tile, [target_tile])
      puts "You made it in #{source_tile.distance} moves! Here's your path:"
      get_path(source_tile).each { |move| p move }
    end

    private

    def valid_positions?(source_pos, target_pos)
      true unless get_index(source_pos).nil? || get_index(target_pos).nil?
    end

    def build_path(source_tile, queue)
      return if queue.empty? || source_tile.distance

      predecessor = queue.shift
      predecessor.adj_list.each do |index|
        tile = @graph[index]
        next unless tile.distance.nil?

        tile.distance = predecessor.distance + 1
        tile.predecessor = predecessor
        queue << tile
      end
      build_path(source_tile, queue)
    end

    def clear_distances
      @graph.each { |tile| tile.distance = nil }
    end

    def get_path(source_tile)
      path = [get_position(source_tile.index)]

      tile = source_tile.predecessor
      until tile.distance.zero?
        path << get_position(tile.index)
        tile = tile.predecessor
      end
      path
    end

    # translates chess board position into index (e.g. get_index([1,3]) == 11)
    def get_index(position)
      return nil unless position[0].between?(0, 7)
      return nil unless position[1].between?(0, 7)

      (position[0] * 8) + position[1]
    end

    # translates chess board index into position (e.g. get_position(11) == [1, 3])
    def get_position(index)
      return nil unless index.between?(0, 63)

      [index / 8, index % 8]
    end

    # builds undirected graph represented by adjacency lists. each vertex in list represents tile on chess board
    def build_graph
      graph = Array.new(8 * 8)
      graph.each_index do |index|
        graph[index] = Vertex.new(build_legal_moves(index).sort!, index)
      end
    end

    # builds array of legal moves for given chess board index
    def build_legal_moves(index)
      x_position = index % 8
      moves = []

      moves.push(-17, 15) if x_position.positive?
      moves.push(-10, 6) if x_position > 1
      moves.push(-6, 10) if x_position < 6
      moves.push(-15, 17) if x_position < 7

      moves.map! { |move| index + move }.select { |move| move.between?(0, 63) }
    end
  end
end
