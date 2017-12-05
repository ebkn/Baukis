class StaffEventPresenter < ModelPresenter
  include Rails.application.routes.url_helpers

  delegate :member, :description, :occured_at, to: :object

  def table_row
    markup(:tr, class: 'text-center') do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td do
          m << link_to(
            full_name(member),
            admin_staff_member_staff_events_path(member)
          )
        end
      end
      m.td description
      m.td occured_at.strftime('%Y/%m/%d %H:%M:%S')
    end
  end

  private

  def full_name(member)
    "#{member.family_name} #{member.given_name}"
  end
end
