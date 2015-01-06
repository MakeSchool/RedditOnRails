module VotesHelper

  def voteButtonClasses(votable)
    vote = current_user.up_or_down_voted(votable)
    if vote == 1
      ["upvoted", "none"]
    elsif vote == 0
      ["none", "none"]
    else
      ["none", "downvoted"]
    end
  end

end
