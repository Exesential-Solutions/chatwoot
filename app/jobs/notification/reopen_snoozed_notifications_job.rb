class Notification::ReopenSnoozedNotificationsJob < ApplicationJob
  queue_as :low

  def perform
    # rubocop:disable Rails/SkipsModelValidations
    Notification.where.not(snoozed_until: nil)
                .where(snoozed_until: 3.days.ago..Time.current)
                .update_all(snoozed_until: nil, updated_at: Time.current)
    # rubocop:enable Rails/SkipsModelValidations
  end
end