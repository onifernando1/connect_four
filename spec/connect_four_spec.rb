# frozen_string_literal: true

require '/home/onifernando1/ruby/connect_four/lib/ruby'

describe Player do
  subject(:p1) { described_class.new }

  describe '#get_p1_name' do
    context 'Check player one name received' do
      before do
        allow(p1).to receive(:gets).and_return('oni')
      end
      it 'Checks p1 name' do
        p1.get_p1_name
        expect(p1.p1_name).to eql 'oni'
      end
    end
  end
end

describe Game do
  subject(:game) { described_class.new }

  before do
    game.player_move = 1
    game.bottom = 5
  end

  describe '#make_move' do
    it 'Checks bottom is 5 when no other pieces' do
      game.make_move
      expect(game.bottom).to eql 5
    end

    context 'When there are other pieces' do
      before do
        game.player_move = 0
        game.bottom = 5
        game.board[5][0] = game.current_player.symbol
      end

      it 'Checks bottom is 4 when there is one piece already' do
        game.make_move
        expect(game.bottom).to eql 4
      end
    end
  end

  describe '#check_win' do
    subject(:game) { described_class.new }
    before do
      game.board[1][1] = game.p1.symbol
      game.board[1][2] = game.p1.symbol
      game.board[1][3] = game.p1.symbol
      game.board[1][4] = game.p1.symbol
      game.check_win
    end
    it 'Checks horizontal win' do
      expect(game.win).to eql true
    end
  end
  before do
    game.board[1][1] = game.p1.symbol
    game.board[1][2] = game.p1.symbol
    game.board[1][3] = game.p1.symbol
    game.board[1][4] = game.p1.symbol
    game.check_win
  end

  it 'Checks win not automatically true ' do
    expect(game.win).not_to eql false
  end

  before do
    game.board[1][4] = game.p1.symbol
    game.board[2][3] = game.p1.symbol
    game.board[3][2] = game.p1.symbol
    game.board[4][1] = game.p1.symbol
    game.check_win
  end

  it 'Checks diagonal win' do
    expect(game.win).to eql true
    expect(game.win).not_to eql false
  end
end
