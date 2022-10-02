class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_many_attached :attachments, dependent: :destroy

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  def chat_attachment(index)
    target = attachments[index]
    return unless attachments.attached?

    target.variant(resize_to_limit: [150, 150])
  end

  def confirm_participant
    if self.room.is_private
      is_participant = Participant.where(user_id: self.user.id, room_id: self.room.id).first
      throw :abort unless is_participant
    end
  end
end
