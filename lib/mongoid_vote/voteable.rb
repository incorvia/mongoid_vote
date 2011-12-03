module MongoidVote
  module Voteable
    extend ActiveSupport::Concern

    DEFAULT_VOTES = {
      "up" => [],
      "down" => [],
      "up_count" => 0,
      "down_count" => 0,
      "count" => 0,
    }

    included do
      field :votes, :type => Hash, :default => DEFAULT_VOTES
    end

    module InstanceMethods
      def vote(user, vote = nil)
        vote_adjust(self.current_vote(user), vote, user)
      end

      def current_vote(user)
        if self.votes["up"].include? user.id.to_s
          :up
        elsif self.votes["down"].include? user.id.to_s
          :down
        end
      end

    private

      def vote_adjust(current_vote, vote, user)
        unless current_vote.to_s == vote
          if !current_vote && vote == "up"
            self.votes["up_count"] += 1
            self.votes["count"] += 1
            self.votes["up"] << user.id.to_s
          elsif !current_vote && vote == "down"
            self.votes["down_count"] -= 1
            self.votes["count"] -= 1
            self.votes["down"] << user.id.to_s
          elsif current_vote == :up && vote == "down"
            self.votes["up_count"] -= 1
            self.votes["down_count"] -= 1
            self.votes["count"] -= 1
            self.votes["up"].delete_if {|x| x == user.id.to_s}
            self.votes["down"] << user.id.to_s
          elsif current_vote == :down && vote == "up"
            self.votes["down_count"] += 1
            self.votes["up_count"] += 1
            self.votes["count"] += 1
            self.votes["down"].delete_if {|x| x == user.id.to_s}
            self.votes["up"] << user.id.to_s
          end
        end
      end
    end
  end
end