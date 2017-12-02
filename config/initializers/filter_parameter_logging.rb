Rails.application.config.filter_parameters += %i(
  email email_for_index password
  family_name given_name family_name_kana given_name_kana
  gender
  birthday birth_year birth_month birth_mday birth_year
  number number_for_index last_four_digits
  postal_code prefecture city address1 address2
  company_name division_name
)
