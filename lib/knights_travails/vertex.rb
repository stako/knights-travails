# frozen_string_literal: true

module KnightsTravails
  class Vertex
    attr_reader :adj_list, :index
    attr_accessor :distance, :predecessor

    def initialize(adj_list, index = nil)
      @adj_list = adj_list
      @index = index
    end
  end
end
