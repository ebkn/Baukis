staff_members = StaffMember.all
256.times do |i|
  member = staff_members.sample
  event = member.events.build

  if member.active?
    event.type = i.even? ? 'logged_in' : 'logged_out'
  else
    event.type = 'rejected'
  end

  event.occured_at = (256 - i).hours.ago
  event.save!
end
