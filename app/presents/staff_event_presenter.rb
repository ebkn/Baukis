class StaffEventPresenter < ModelPresenter
  delegate :member, :description, :occured_at, to: :object

  def table_row
    markup(:tr) do |m|
      unless view_context.instance_variable_get(:@staff_member)
        m.td do
          m << link_to(
            member.full_name,
            admin_staff_member_staff_events_path(member)
          )
        end
      end
      m.td description
      m.td occured_at.strftime('%Y/%m/%d %H:%M:%S')
    end
  end
end
