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

      def upvote(user)
        vote_adjust(current_vote(user), 'up', user)
      end

      def downvote(user)
        vote_adjust(current_vote(user), 'down', user)
      end

      def votecount
        self.votes["count"]
      end

      def downcount
        self.votes["down_count"]
      end

      def upcount
        self.votes["up_count"]
      end

      def upvoters
        self.votes["up"]
      end

      def downvoters
        self.votes["down"]
      end

      def current_vote(user)
        if self.votes["up"].include? user.id.to_s
          :up
        elsif self.votes["down"].include? user.id.to_s
          :down
        end
      end

    private

      def vote_adjust(current, vote, user)
        unless current.to_s == vote
          if !current && vote == "up"
            self.votes["up_count"] += 1
            self.votes["count"] += 1
            self.votes["up"] << user.id.to_s
          elsif !current && vote == "down"
            self.votes["down_count"] -= 1
            self.votes["count"] -= 1
            self.votes["down"] << user.id.to_s
          elsif current == :up && vote == "down"
            self.votes["up_count"] -= 1
            self.votes["down_count"] -= 1
            self.votes["count"] -= 2
            self.votes["up"].delete_if {|x| x == user.id.to_s}
            self.votes["down"] << user.id.to_s
          elsif current == :down && vote == "up"
            self.votes["down_count"] += 1
            self.votes["up_count"] += 1
            self.votes["count"] += 2
            self.votes["down"].delete_if {|x| x == user.id.to_s}
            self.votes["up"] << user.id.to_s
          end
        end
      end
    end
  end
end