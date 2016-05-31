require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  def setup
    @vote = Vote.new
  end

  test "has the expected properties" do
    assert @vote.respond_to? :article
    assert @vote.respond_to? :value
  end
end
