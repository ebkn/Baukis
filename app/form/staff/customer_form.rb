class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer, :inputs_home_address, :inputs_work_address
  delegate :persisted?, :save, to: :customer

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new
    set_addresses
    build_all_phones
  end

  def assign_attributes(params = {})
    @params = params
    self.inputs_home_address = params[:inputs_home_address] == '1'
    self.inputs_work_address = params[:inputs_work_address] == '1'

    customer.assign_attributes(customer_params)
    new_phones = phone_params(:customer).fetch(:phones)
    assign_phones_data(customer.personal_phones, new_phones)

    if inputs_home_address
      customer.home_address.assign_attributes(home_address_params)
      new_phones = phone_params(:home_address).fetch(:phones)
      assign_phones_data(customer.home_address.phones, new_phones)
    else
      customer.home_address.mark_for_destruction
    end

    if inputs_work_address
      customer.work_address.assign_attributes(work_address_params)
      new_phones = phone_params(:work_address).fetch(:phones)
      assign_phones_data(customer.work_address.phones, new_phones)
    else
      customer.work_address.mark_for_destruction
    end
  end

  private

  def set_addresses
    self.inputs_home_address = @customer.home_address.present?
    self.inputs_work_address = @customer.work_address.present?
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
  end

  def build_all_phones
    build_phones(@customer.personal_phones)
    build_phones(@customer.home_address.phones)
    build_phones(@customer.work_address.phones)
  end

  def build_phones(phones)
    (2 - phones.size).times { phones.build }
  end

  def customer_params
    @params.require(:customer).permit(
      :email,
      :password,
      :family_name,
      :given_name,
      :family_name_kana,
      :given_name_kana,
      :birthday,
      :gender
    )
  end

  def home_address_params
    @params.require(:home_address).permit(
      :postal_code,
      :prefecture,
      :city,
      :address1,
      :address2
    )
  end

  def work_address_params
    @params.require(:work_address).permit(
      :postal_code,
      :prefecture,
      :city,
      :address1,
      :address2,
      :company_name,
      :division_name
    )
  end

  def phone_params(record_name)
    @params.require(record_name).permit(phones: %i[number primary])
  end

  def assign_phones_data(phones, new_phones)
    phones.size.times do |index|
      attributes = new_phones[index.to_s]
      if attributes && attributes[:number].present?
        phones[index].assign_attributes(attributes)
      else
        phones[index].mark_for_destruction
      end
    end
  end
end
